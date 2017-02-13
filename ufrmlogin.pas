unit ufrmlogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg,Vcl.ExtCtrls,
  Vcl.Themes, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Data.DB, Vcl.DBCtrls,Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Comp.Client, FireDAC.Phys.PGDef,
  Vcl.Imaging.pngimage, FireDAC.VCLUI.Wait;

type
  Tfrmlogin = class(TForm)
    FDConeccion: TFDConnection;
    fdDriver: TFDPhysPgDriverLink;
    pgLogin: TPageControl;
    tabSeguridad: TTabSheet;
    pnlLogin: TPanel;
    Shape1: TShape;
    Image1: TImage;
    lblEncabezado: TLabel;
    imgBienestar: TImage;
    lbUsuario: TLabel;
    lblContraseña: TLabel;
    lblServidor: TLabel;
    txtUsuario: TEdit;
    txtPassword: TEdit;
    txtServidor: TEdit;
    btnAceptar: TBitBtn;
    btnVerificar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnVerificarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    class function Execute: boolean;
  end;

var
  frmlogin: Tfrmlogin;
  idusuario: Integer;
  usuario, servidor, entidad: String;

implementation

{$R *.dfm}

uses udmDatos, ufunciones;

procedure Tfrmlogin.btnVerificarClick(Sender: TObject);
begin
  if not ufunciones.fnConeccion(FDConeccion, fdDriver, txtServidor.Text,
    'sispe', '5432') then
  begin
    ShowMessage('Verifique los datos de conexión con el servidor');
    txtServidor.SetFocus;
  end
  else
  begin
    btnAceptar.Enabled := True;
    ShowMessage('Conectado correctamente!!!')
  end;
end;

procedure Tfrmlogin.btnAceptarClick(Sender: TObject);
var
  qry: TFDQuery;
  ip: TStringList;
  activo: boolean;
  total: Integer;
begin
  if ufunciones.fnConeccion(FDConeccion, fdDriver, txtServidor.Text, 'sispe',
    '5432') then
  begin
    FDConeccion.Connected;
    qry := TFDQuery.Create(nil);
    qry.Connection := FDConeccion;

    ip := TStringList.Create;
    ip.LoadFromFile(ExtractFilePath(Application.ExeName) + '\coneccion.txt');
    if ip.Count = 3 then
    begin
      qry.SQL.Clear;
      qry.SQL.Add('select activado from catalogos.sys_opciones');
      qry.Active := True;
      total := qry.RecordCount;
      qry.Close;
      if total > 0 Then
      begin
        qry.SQL.Clear;
        qry.SQL.Add('update catalogos.sys_opciones set activado =true');
        qry.ExecSQL;
        qry.Close;
      end;
    end;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add
      ('select idusuario,usuario,password,activo,cvenivel from catalogos.usuarios as u ');
    qry.SQL.Add('where usuario=''' + self.txtUsuario.Text + '''');
    qry.Active := True;
    activo := qry.Fields[3].Value;
    if qry.RecordCount > 0 then
    begin
      if (qry.Fields[2].Value = self.txtPassword.Text) and activo then
      begin
        idusuario := qry.Fields[0].Value;
        usuario := qry.Fields[1].Value;
        servidor := self.txtServidor.Text;
        ufunciones.nivel := qry.FieldByName('cvenivel').AsString;
        ModalResult := mrOk;
      end
      else if not activo then
        ShowMessage
          ('Su cuenta no esta activa consulte con el administrador del sistema')
      else
        ShowMessage('Contraseña no válida');
    end
    else
      ShowMessage('Usuario inexistente');
    qry.Active := False;
    qry.Free;
  end
  else
  begin
    ShowMessage('Verifique los datos de coneccion con el servidor');
    pgLogin.TabIndex := 1;
    txtServidor.SetFocus;
  end;
end;

class function Tfrmlogin.Execute: boolean;
begin
  with Tfrmlogin.Create(nil) do
    try
      Result := ShowModal = mrOk;
    finally
      Free;
    end;
end;

procedure Tfrmlogin.FormActivate(Sender: TObject);
var
  ip: TStringList;

begin
  { Obtiene los datos de la configuración del servidor del archivo conneccion.txt }
  ip := TStringList.Create;
  ip.LoadFromFile(ExtractFilePath(Application.ExeName) + '\coneccion.txt');
  if ip.Count > 0 then
  begin
    txtServidor.Text := ip.Strings[0];
    txtUsuario.Text := ip.Strings[1];
  end;
  { Verifica si hay acceso al servidor de lo contrario forza a configurarlo }
  if not ufunciones.fnConeccion(FDConeccion, fdDriver, txtServidor.Text,
    'sispe', '5432') then
  begin
    pgLogin.TabIndex := 1;
    ShowMessage('Verifique los datos de coneccion con el servidor');
    txtServidor.SetFocus;
  end
  else
  begin
    { Si no tiene datos el nombre de usuario le pone el foco }
    if txtUsuario.Text = '' then
      txtUsuario.SetFocus
    else { Si tiene datos el foco lo paso a la caja de password }
      txtPassword.SetFocus;
  end;
  ip.Free;
end;

procedure Tfrmlogin.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ip: TStringList;

begin
  ip := TStringList.Create;
  ip.Add(txtServidor.Text);
  ip.Add(txtUsuario.Text);
  ip.SaveToFile('coneccion.txt');
  ip.Free;
end;

procedure Tfrmlogin.FormCreate(Sender: TObject);
var
  ip: TStringList;

begin
  { Obtiene los datos de la configuración del servidor del archivo conneccion.txt }
  ip := TStringList.Create;
  ip.LoadFromFile(ExtractFilePath(Application.ExeName) + '\coneccion.txt');
  if ip.Count > 0 then
  begin
    txtServidor.Text := ip.Strings[0];
    txtUsuario.Text := ip.Strings[1];
  end;
  btnAceptar.Enabled := False;
  if ufunciones.fnConeccion(FDConeccion, fdDriver, txtServidor.Text,
    'postgres', '5432') then
    btnAceptar.Enabled := True;
end;

end.
