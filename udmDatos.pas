unit udmDatos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  Vcl.Forms, Winapi.Windows, Vcl.Dialogs, FireDAC.Phys.ASAWrapper, Vcl.ComCtrls,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.ASA, FireDAC.Phys.PGDef, Vcl.Grids,
  Data.Win.ADODB, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite;

type
  TdmDatos = class(TDataModule)
    pgconeccion: TFDConnection;
    qryUsuarios: TFDQuery;
    pgupdate: TFDUpdateSQL;
    dsUsuarios: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryOpciones: TFDQuery;
    updqryOpciones: TFDUpdateSQL;
    dsOpciones: TDataSource;
    qryDeptos: TFDQuery;
    updDeptos: TFDUpdateSQL;
    dsDeptos: TDataSource;
    qryUsuariosidusuario: TIntegerField;
    qryUsuariosusuario: TWideStringField;
    qryUsuariospassword: TWideStringField;
    qryUsuariosnombre: TWideStringField;
    qryUsuariospuesto: TWideStringField;
    qryUsuariosobservaciones: TWideStringField;
    qryUsuariosfregistro: TDateField;
    qryUsuariosfuacceso: TDateField;
    qryUsuariosactivo: TBooleanField;
    qryUsuariosmenuacceso: TWideStringField;
    qryUsuarioscveent: TWideStringField;
    qryUsuarioscvedtofe: TWideStringField;
    qryUsuarioscvemod: TWideStringField;
    qryUsuarioscvereg: TWideStringField;
    qryUsuarioscvedto: TWideStringField;
    qryUsuarioscvemun: TWideStringField;
    qryUsuarioscveloc: TWideStringField;
    qryUsuarioscvenivel: TWideStringField;
    qryUsuarioscvesecretaria: TSmallintField;
    qryUsuarioscvedireccion: TSmallintField;
    qryUsuarioscvedepartamento: TSmallintField;
    qrySecretarias: TFDQuery;
    updSecretarias: TFDUpdateSQL;
    dsSecretarias: TDataSource;
    qryDirecciones: TFDQuery;
    updDirecciones: TFDUpdateSQL;
    dsDirecciones: TDataSource;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    ADOConeccion: TADOConnection;
    ADOQry: TADOQuery;
    Qry: TFDQuery;
    fdUpdqry: TFDUpdateSQL;
    dsQry: TDataSource;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    coneccionSqlLite: TFDConnection;
    QrySqlLite: TFDQuery;
    dsSqlLite: TDataSource;
    dsADOQry: TDataSource;
    ADOTable: TADOTable;
    qryReportes: TFDQuery;
    dsRteTotales: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryUsuariosAfterScroll(DataSet: TDataSet);
    procedure qryUsuariosBeforeDelete(DataSet: TDataSet);
    procedure qryUsuariosAfterCancel(DataSet: TDataSet);
    procedure qryUsuariosBeforePost(DataSet: TDataSet);
    procedure qryUsuariosAfterPost(DataSet: TDataSet);
    procedure qryUsuariosBeforeInsert(DataSet: TDataSet);
    procedure qryUsuariosBeforeEdit(DataSet: TDataSet);
    procedure qryCorreoError(ASender: TObject; const AInitiator: IFDStanObject;
      var AException: Exception);
    procedure qryUsuariosBeforeScroll(DataSet: TDataSet);
    procedure qryUsuariosAfterInsert(DataSet: TDataSet);
    procedure qryUsuariosAfterEdit(DataSet: TDataSet);
    procedure qryProveedoresBeforeDelete(DataSet: TDataSet);
    procedure QryAfterPost(DataSet: TDataSet);
    procedure QryBeforeDelete(DataSet: TDataSet);
    procedure QryError(ASender, AInitiator: TObject; var AException: Exception);
    procedure QryAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cFlatUnCheck = 1;
  cFlatChecked = 2;

var
  dmDatos: TdmDatos;
  idusuario: Integer;

type
  THackGrid = class(TStringGrid);

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses ufunciones, ufrmadminusuarios, ufrmcemp, ufrmprincipal;

{$R *.dfm}

procedure TdmDatos.DataModuleCreate(Sender: TObject);
var
  ip: TStringList;

begin
  { Se inicializa y agrega a la variable global opciones los valores del arbol de opciones }
  ufunciones.opciones := TStringList.Create;
  ip := TStringList.Create;
  ip.LoadFromFile('coneccion.txt');
  if not ufunciones.fnConeccion(pgconeccion, FDPhysPgDriverLink, ip.Strings[0],
    'sispe', '5432') then
    ShowMessage('Verifique los datos de conexión con el servidor');
  coneccionSqlLite.Params.Clear;
  coneccionSqlLite.DriverName := 'SQLite';
  coneccionSqlLite.Params.Add('Database=' + GetCurrentDir + '\db\sispe.db');
end;

procedure TdmDatos.qryProveedoresBeforeDelete(DataSet: TDataSet);
begin
  If Application.MessageBox('Desea eliminar el proveedor seleccionado?',
    'Eliminar registro de Proveedor', mb_YesNo + MB_ICONQUESTION) = ID_No Then
    Abort
end;

procedure TdmDatos.QryAfterPost(DataSet: TDataSet);
begin
  ShowMessage('Registro guardado corectamente');
end;

procedure TdmDatos.QryAfterScroll(DataSet: TDataSet);
begin
  if Assigned(frmcemp)Then
    frmPrincipal.StatusBar.Panels[4].Text := 'Registro ' + IntToStr(dmDatos.Qry.RecNo) + ' de ' + IntToStr(dmDatos.Qry.RecordCount);
end;

procedure TdmDatos.QryBeforeDelete(DataSet: TDataSet);
begin
  If Application.MessageBox
    ('Esta acción eliminará el registro seleccionado esta seguro?',
    'Borrar un registro', mb_YesNo + MB_ICONQUESTION) = ID_No Then
      Abort
end;

procedure TdmDatos.qryCorreoError(ASender: TObject;
  const AInitiator: IFDStanObject; var AException: Exception);
begin
  ShowMessage('Exception class name = ' + AException.ClassName);
  // ShowMessage('Exception message = '+AException.Message);
  // AException.Message := 'Debe de llenar todos los campos para poder guardar el registro...';

  // ShowMessage('Error');
end;

procedure TdmDatos.QryError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  AException.Message :=
    'Debe de llenar los campos requeridos para poder guardar el registro !';
  ShowMessage(AException.Message);
  Abort;
end;

procedure TdmDatos.qryUsuariosAfterCancel(DataSet: TDataSet);
begin
  frmadminusuarios.tvOpciones.Enabled := False;
  if (Stateqryuser in [dsEdit, dsInsert]) then
  begin
    frmadminusuarios.txtPassb.Text := qryUsuarios.FieldByName('password').Text;
    frmadminusuarios.txtPassa.Text := qryUsuarios.FieldByName('password').Text;
  end;
end;

procedure TdmDatos.qryUsuariosAfterEdit(DataSet: TDataSet);
begin
  if dmDatos.dsUsuarios.State in [dsEdit, dsInsert] then
    frmadminusuarios.tvOpciones.Enabled := True;
end;

procedure TdmDatos.qryUsuariosAfterInsert(DataSet: TDataSet);
begin
  fnRecuperaopc(frmadminusuarios.tvOpciones, 0, True);
  if dmDatos.dsUsuarios.State in [dsEdit, dsInsert] then
    frmadminusuarios.tvOpciones.Enabled := True;
end;

procedure TdmDatos.qryUsuariosAfterPost(DataSet: TDataSet);
var
  qry: TFDQuery;
  id : Integer;
  i: Integer;
  BoolResult: boolean;

begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  if udmDatos.idusuario = 0 then
  begin
    qry.SQL.Clear;
    qry.SQL.Add('select last_value from catalogos.catusuarios_idusuario_seq;');
    qry.Active := True;
    id := qry.Fields[0].Value;
    qry.Close;
  end
  else
  begin
    qry.Close;
    id := udmDatos.idusuario;
    qry.SQL.Clear;
    qry.SQL.Add('delete from catalogos.opciones where idusuario=' +
      IntToStr(id));
    qry.ExecSQL;
  end;
  qry.Close;
  if id > 0 then
  begin
    for i := 0 to frmadminusuarios.tvOpciones.Items.count - 1 do
    begin
      BoolResult := frmadminusuarios.tvOpciones.Items[i].StateIndex
        in [cFlatChecked];
      if BoolResult then
      begin
        qry.SQL.Clear;
        qry.SQL.Add
          ('INSERT INTO catalogos.opciones(idusuario,idopcion,etiqueta,habilitar,ocultar,formulario,checked)'
          + ' VALUES (' + IntToStr(id) + ', ' + IntToStr(i) + ', ''' +
          frmadminusuarios.tvOpciones.Items[i].Text +
          ''', true, false, false, false);');
        qry.ExecSQL;
      end;
    end;
  end;
  qry.Close;
  qry.Free;
  dmDatos.qryUsuarios.Refresh;
end;

procedure TdmDatos.qryUsuariosAfterScroll(DataSet: TDataSet);
begin
  if (dmDatos.dsUsuarios.State in [dsBrowse]) then
  begin
    if Assigned(frmadminusuarios) then
    begin
      fnRecuperaopc(frmadminusuarios.tvOpciones,
        dmDatos.qryUsuarios.FieldByName('idusuario').AsInteger, False);
        //frmprincipal.StatusBar.Panels[0].Text := 'Usuario ' +
        IntToStr(qryUsuarios.FieldByName('idusuario').AsInteger);
        frmprincipal.StatusBar.Panels[4].Text := 'Registro ' +
        IntToStr(qryUsuarios.RecNo) + ' de ' +
        IntToStr(qryUsuarios.RecordCount);
      frmadminusuarios.txtPassb.Text := qryUsuarios.FieldByName
        ('password').Text;
      frmadminusuarios.txtPassa.Text := qryUsuarios.FieldByName
        ('password').Text;
    end;
  end;
end;

procedure TdmDatos.qryUsuariosBeforeDelete(DataSet: TDataSet);
begin
  If Application.MessageBox('Desea eliminar el usuario seleccionado?',
    'Eliminar registro de usuario', mb_YesNo + MB_ICONQUESTION) = ID_No Then
    Abort;
end;

procedure TdmDatos.qryUsuariosBeforeEdit(DataSet: TDataSet);
begin
  frmadminusuarios.txtPassb.Enabled := True;
  frmadminusuarios.tvOpciones.Enabled := True;
  udmDatos.idusuario := dmDatos.qryUsuarios.FieldByName('idusuario')
    .AsInteger;
end;

procedure TdmDatos.qryUsuariosBeforeInsert(DataSet: TDataSet);
begin
  frmadminusuarios.txtPassa.Text := '';
  frmadminusuarios.txtPassb.Text := '';
  udmDatos.idusuario := 0;
end;

procedure TdmDatos.qryUsuariosBeforePost(DataSet: TDataSet);
begin
  if dmDatos.qryUsuarios.State in [dsInsert, dsEdit] then
  begin
    qryUsuarios.FieldByName('password').Text := frmadminusuarios.txtPassb.Text;
    frmadminusuarios.tvOpciones.Enabled := False;
  end;

end;

procedure TdmDatos.qryUsuariosBeforeScroll(DataSet: TDataSet);
begin
  fnRecuperaopc(frmadminusuarios.tvOpciones,
    dmDatos.qryUsuarios.FieldByName('idusuario').AsInteger, False);
end;

end.
