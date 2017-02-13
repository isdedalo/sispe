unit ufrmadminusuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Vcl.DBActns, Vcl.ActnList,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Tabs,
  Vcl.Buttons,Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Menus,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, System.Actions,
  FireDAC.Comp.Client, Vcl.Imaging.jpeg, System.ImageList, Vcl.CheckLst;

type
  Tfrmadminusuarios = class(TForm)
    acciones: TActionList;
    dsEliminar: TDataSetDelete;
    dsModificar: TDataSetEdit;
    dsGuardar: TDataSetPost;
    dsCancelar: TDataSetCancel;
    dsRefresh: TDataSetRefresh;
    dsInsertar: TDataSetInsert;
    Imagenes: TImageList;
    PopupMenu1: TPopupMenu;
    DataSetFirst1: TDataSetFirst;
    First1: TMenuItem;
    DataSetPrior1: TDataSetPrior;
    Prior1: TMenuItem;
    DataSetNext1: TDataSetNext;
    Next1: TMenuItem;
    DataSetLast1: TDataSetLast;
    Last1: TMenuItem;
    N1: TMenuItem;
    Nuevo1: TMenuItem;
    Eliminar1: TMenuItem;
    Modificar1: TMenuItem;
    Guardar1: TMenuItem;
    Cancelar1: TMenuItem;
    Actualizar1: TMenuItem;
    N2: TMenuItem;
    Salir1: TMenuItem;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    Panel1: TPanel;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    btnCerrarmod: TBitBtn;
    DBNavigator1: TDBNavigator;
    pnlFaltantes: TPanel;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    Panel9: TPanel;
    Label5: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblDepto: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Panel10: TPanel;
    Label11: TLabel;
    lblUactivo: TLabel;
    txtNombre: TDBEdit;
    txtPuesto: TDBEdit;
    chkActivo: TDBCheckBox;
    txtClave: TDBEdit;
    txtPassa: TEdit;
    txtPassb: TEdit;
    mObservaciones: TDBMemo;
    Panel5: TPanel;
    tvOpciones: TTreeView;
    txtBuscar: TEdit;
    btnBuscar: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridopcDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Salir1Click(Sender: TObject);
    procedure txtPassbExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lcboDistritoCloseUp(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure tvOpcionesClick(Sender: TObject);
    procedure tvOpcionesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvOpcionesCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure txtBuscarEnter(Sender: TObject);
    procedure txtBuscarChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmadminusuarios: Tfrmadminusuarios;
  Stateqryuser  : TDataSetState;//Se guarda el estado en que se encuentra el dataset de los usuarios
  idusuario : integer;

implementation

{$R *.dfm}

uses udmDatos, ufunciones, ufrmprincipal;

procedure Tfrmadminusuarios.gridopcDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

const IsChecked : array[Boolean] of Integer =
      (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
begin

end;

procedure Tfrmadminusuarios.lcboDistritoCloseUp(Sender: TObject);
var
  qry : TFDQuery;

begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  if(dmDatos.dsUsuarios.State in [dsInsert,dsEdit]) then
  begin
    Stateqryuser := dmDatos.dsUsuarios.State;
    frmprincipal.StatusBar.panels[4].Text:='Modificando usuario';
    frmadminusuarios.txtPassa.Enabled:=True;
    frmadminusuarios.txtPassb.Enabled:=True;
    qry.SQL.Clear;
    qry.SQL.Add('select cvemod from catalogos.catmod where cveent='''+ufunciones.cveent+''' and cvedtofe='''+ ufunciones.cvedtofe+'''');
    qry.Active:= True;
    if(dmDatos.dsUsuarios.State in [dsInsert]) then
    begin
      frmadminusuarios.txtPassa.Text:='';
      frmadminusuarios.txtPassb.Text:='';
    end;
  end;
end;

procedure Tfrmadminusuarios.btnSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmadminusuarios.FormActivate(Sender: TObject);
begin
  txtPassb.text := dmDatos.qryusuarios.FieldByName('password').Text;
  txtPassa.text := dmDatos.qryusuarios.FieldByName('password').Text;
end;

procedure Tfrmadminusuarios.FormClose(Sender: TObject;
  var Action: TCloseAction);

begin
  frmPrincipal.nummodulo:=0;
  dmDatos.qryUsuarios.Active := False;
  dmDatos.qrySecretarias.Active := False;
  dmDatos.qryDirecciones.Active := False;
  dmDatos.qryDeptos.Active := False;
  frmadminusuarios := nil;
  Action := caFree;
end;

procedure Tfrmadminusuarios.FormCreate(Sender: TObject);
begin
  dmDatos.qryUsuarios.Active := True;
  dmDatos.qrySecretarias.Active := True;
  dmDatos.qryDirecciones.Active := True;
  dmDatos.qryDeptos.Active := True;
  frmPrincipal.nummodulo :=9; {Asigna a la variable global que esta en el contenedor principal
                               el numero de modulo que se esta abriendo que es en realidad el numero
                               que le toca dentro del numero de opciones del menu esto con la finalidad
                               de cerralo al momento de abrir otro módulo y liberarlo de la memoria}
//  tvOpciones.FullExpand;
  fnRecuperaopc(tvOpciones,dmDatos.qryUsuarios.FieldByName('idusuario').AsInteger,false);
end;

procedure Tfrmadminusuarios.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure Tfrmadminusuarios.Salir1Click(Sender: TObject);
begin
  frmadminusuarios.Close;
end;

procedure Tfrmadminusuarios.tvOpcionesClick(Sender: TObject);
var
  P:TPoint;
begin
  GetCursorPos(P);
  P := tvOpciones.ScreenToClient(P);
  if (htOnStateIcon in
             tvOpciones.GetHitTestInfoAt(P.X,P.Y)) then
       ToggleTreeViewCheckBoxes(
       tvOpciones.Selected,
       cFlatUnCheck,
       cFlatChecked);
end;

procedure Tfrmadminusuarios.tvOpcionesCollapsing(Sender: TObject;
  Node: TTreeNode; var AllowCollapse: Boolean);
begin
  AllowCollapse := true;
end;

procedure Tfrmadminusuarios.tvOpcionesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = VK_SPACE) and
     Assigned(tvOpciones.Selected) then
       ToggleTreeViewCheckBoxes(
          tvOpciones.Selected,
          cFlatUnCheck,
          cFlatChecked);
end;

procedure Tfrmadminusuarios.txtBuscarChange(Sender: TObject);
begin
  dmDatos.qryUsuarios.Filter := '[nombre] = ' + QuotedStr(txtBuscar.Text + '*');
  dmDatos.qryUsuarios.Filtered := True;
end;

procedure Tfrmadminusuarios.txtBuscarEnter(Sender: TObject);
begin
  txtBuscar.Text := '';
end;

procedure Tfrmadminusuarios.txtPassbExit(Sender: TObject);
begin
  if not (txtPassa.Text = txtPassb.Text) then
  begin
    if(dmDatos.dsUsuarios.State in [dsInsert,dsEdit]) then
    begin
      ShowMessage('Verifique su contraseña');
      if(dmDatos.dsUsuarios.State in [dsInsert]) then
      begin
        txtPassa.Text:='';
        txtPassb.Text:='';
      end;
      txtPassa.SetFocus;
    end;
  end;
end;

end.
