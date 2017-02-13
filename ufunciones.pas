{ Author : Jesús Vicente Pérez
  Lugar  : Area de Sistemas Oficina de Pensiones Gobiernod el Estado de Oaxaca
  Fecha de Inicio : 01-Diciembre-2015
  Ultima Actualización : 09-Diciembre-2015
}
unit ufunciones;

interface

uses
  ShlObj, SysUtils, System.Classes, Vcl.ComCtrls, Vcl.Dialogs,
  Vcl.Menus, Windows, Vcl.Forms, System.Variants, Vcl.StdCtrls,
  Vcl.Buttons, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG, Vcl.Grids;

function GetTokenCount(Cadena: string; Separador: char): integer; overload;
function GetToken(Cadena, Separador: String; Token: integer): String; overload;
function checapermisos(idusuario: integer; opcion: TMenuItem;
  numpermiso: integer): boolean;
function fnGenerarchivos(cPath: String; cnomArch: String; cSql: String)
  : boolean;
function fnConeccion(coneccion: TFDConnection; driver: TFDPhysPgDriverLink;
  servidor: String; bd: String; puerto: String): boolean;
function fnCargaDtofe(Sql: String; cboDtofe: TComboBox): boolean;
function fnRecordcount(tabla: String; where: String): integer;
function fnConsultas(Sql: String): integer;
function fnValconecciones(): boolean;
function chkVentana(id: integer): boolean;
function fnrSolreimp(numfuar: String): boolean;
function fHabilitabtn(idusuario: integer; idbtn: integer): boolean;
function fnRecuperaopc(tvOpciones: TTreeView; idusuario: integer;
  limpiar: boolean): boolean;
procedure GetItems(idusuario: integer; mi: TMenuItem);
procedure ingresaopc(idusuario: integer);
procedure pGenfolios();
procedure valSolinv(num_fuar, txtDistrito, txtPaquete: String);
procedure ToggleTreeViewCheckBoxes(Node: TTreeNode;
  cUnChecked, cChecked: integer);
procedure limpiaGrid(sgArchivos: TStringGrid);

var
  menuopc, usuario, servidor, cveent, cvedtofe, nivel, entidad: string;
  idusuario, idusuarioau: integer;
  opciones: TStringList;
  qry: TFDQuery;

type
  THackGrid = class(TStringGrid);

implementation

uses udmDatos, ufrmadminusuarios, ufrmprincipal, ufrmproveedores,
  ufrmimportar, ufrmcmov, ufrmcdep, ufrmcemp, ufrmactualiza, ufrmaclaraciones;

function GetTokenCount(Cadena: string; Separador: char): integer; overload;
var
  Posicion: integer;
begin
  Posicion := Pos(Separador, Cadena);
  Result := 1;
  if Cadena <> '' then
  begin
    if Posicion <> 0 then
    begin
      while Posicion <> 0 do
      begin
        Delete(Cadena, 1, Posicion);
        Posicion := Pos(Separador, Cadena);
        Inc(Result);
      end;
    end;
  end
  else
    Result := 0;
end;

function GetToken(Cadena, Separador: String; Token: integer): String; overload;
var
  Posicion: integer;
begin
  while Token > 1 do
  begin
    Delete(Cadena, 1, Pos(Separador, Cadena) + Length(Separador) - 1);
    Dec(Token);
  end;
  Posicion := Pos(Separador, Cadena);
  if Posicion = 0 then
    Result := Cadena
  else
    Result := Copy(Cadena, 1, Posicion - 1);
end;

function fnActualizaopc(idusuario: integer; var arbolmenu: TTreeView): boolean;
var
  i: integer;
  Cadena: String;
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  for i := 0 to arbolmenu.Items.Count - 1 do
  begin
    qry.Sql.Clear;
    if arbolmenu.Items[i].StateIndex = 1 then
      Cadena := 'update catalogos.opciones set checked=false where idusuario=' +
        IntToStr(idusuario) + ' and idopcion=' +
        IntToStr(arbolmenu.Items[i].AbsoluteIndex) + ';';
    if arbolmenu.Items[i].StateIndex = 2 then
      Cadena := 'update catalogos.opciones set checked=true where idusuario=' +
        IntToStr(idusuario) + ' and idopcion=' +
        IntToStr(arbolmenu.Items[i].AbsoluteIndex) + ';';
    qry.Sql.Add(Cadena);
    qry.ExecSQL;
  end;
  qry.Close;
  qry.Free;
end;

function checapermisos(idusuario: integer; opcion: TMenuItem;
  numpermiso: integer): boolean;
{ Checa en la tabla opciones los derechos que tiene asignado una opcion del menu }
var
  qry: TFDQuery;
  resultado: boolean;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  qry.Sql.Clear;
  { Checamos en la base de datos si ya hay registro de opciones del usuario que en estos momentos estamos visualizando }
  if numpermiso = 0 then
    qry.Sql.Add('select checked from catalogos.opciones where idusuario=' +
      IntToStr(idusuario) + ' and idopcion=' + IntToStr(opcion.Tag));
  if numpermiso = 1 then
    qry.Sql.Add('select ocultar from catalogos.opciones where idusuario=' +
      IntToStr(idusuario) + ' and idopcion=' + IntToStr(opcion.Tag));
  qry.Active := True;
  if qry.Fields[0].Value = null then
    resultado := false
  else
    resultado := qry.Fields[0].Value;
  // resultado := qry.Fields[0].Value;
  qry.Active := false;
  qry.Free;
  checapermisos := resultado;
end;

procedure ingresaopc(idusuario: integer);

begin
end;

{ funcion que genera archivos de texto a partir de una consulta dada }
function fnGenerarchivos(cPath: String; cnomArch: String; cSql: String)
  : boolean;
var
  i, numres, totcampos: integer;
  arcTotreg, registro, Cadena: String;
  F: TextFile;
  qry: TFDQuery;
  aTamcampos: array of integer;

const
  encabezado: array [0 .. 15] of string = ('NUMERO DE FUAR', 'CLAVE DE ELECTOR',
    'FOLIO NACIONAL', 'TRAMITE INICIAL', 'TRAMITE DEFINITIVO', 'ENT', 'DTO',
    'MPIO', 'LOC', 'SECC', 'MZA', 'CIUDADANO', 'FECHA EVENTO', 'ESTATUS',
    'DOC. ANEXA', 'REMESA');

begin
  Try
    If not DirectoryExists(cPath) then
      CreateDir(cPath);
    arcTotreg := cPath + '\' + cnomArch;
    AssignFile(F, arcTotreg);
    Rewrite(F);
    qry := TFDQuery.Create(nil);
    qry.Connection := dmDatos.pgconeccion;
    qry.Sql.Clear;
    qry.Sql.Add(cSql);
    qry.Open;
    qry.First;
    totcampos := qry.Fields.Count - 1;
    { Contiene el total de campos de nuestra consulta }
    SetLength(aTamcampos, totcampos); { Establecemos el tamaño del arreglo }
    For i := 0 To totcampos
      do { Genera el encabezado y lo acumula en una variable para escribirla posteriormente }
      registro := registro + encabezado[i] + '|';
    WriteLn(F, registro); { Escribe el encabezado en el archivo }
    while not qry.Eof do
    begin
      registro := '';
      numres := 0;
      For i := 0 To totcampos do
      begin
        numres := (aTamcampos[i] - StrLen(Pchar(qry.Fields[i].Text)));
        if qry.Fields[i].Value = null then
          Cadena := ''
        else
          Cadena := qry.Fields[i].Value;
        registro := registro + Cadena + '|';
      end;
      WriteLn(F, registro);
      qry.Next;
    end;
    CloseFile(F);
    qry.Close;
    qry.Free;
    fnGenerarchivos := True;
  Except
    fnGenerarchivos := false;
  End;
End;

{ Obtiene el total de registros de una table }
function fnRecordcount(tabla: String; where: String): integer;
var
  qry: TFDQuery;

begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  qry.Sql.Clear;
  qry.Sql.Add('select count(*) from ' + tabla + ' ' + where);
  qry.Active := True;
  Result := qry.Fields[0].Value;
  qry.Close;
  qry.Free;
end;

procedure GetItems(idusuario: integer; mi: TMenuItem);
var
  i: integer;
  str: string;

begin
  for i := 0 to (mi.Count - 1) do
  begin
    str := mi.Items[i].Caption;
    { Si el nivel del usuario es 2 deshabilita la administración del usuario por default }
    if (nivel = '2') and (mi.Items[i].Tag = 13) then
      mi.Items[i].Visible := false
    else
    begin
      if checapermisos(idusuario, mi.Items[i], 0) then
        mi.Items[i].Enabled := True
      else
        mi.Items[i].Enabled := false;
      if checapermisos(idusuario, mi.Items[i], 1) then
        mi.Items[i].Visible := false
      else
        mi.Items[i].Visible := True;
      GetItems(idusuario, mi.Items[i]);
    end;
  end;
end;

function fnConsultas(Sql: String): integer;
var
  qry: TFDQuery;
begin
  if Sql <> '' then
  begin
    qry := TFDQuery.Create(nil);
    qry.Connection := dmDatos.pgconeccion;
    qry.Sql.Clear;
    qry.Sql.Add(Sql);
    qry.Active := True;
    fnConsultas := qry.Fields[0].Value;
    qry.Close;
    qry.Free;
  end;
end;

{ Función que devuelve verdadero al verificar si se puede conectar al servidor de
  base de datos y llena el combo de estados si no pide la configuración del mismo y devuelve false }
function fnConeccion(coneccion: TFDConnection; driver: TFDPhysPgDriverLink;
  servidor: String; bd: String; puerto: String): boolean;
begin
  coneccion.Params.Clear;
  driver.VendorHome := GetCurrentDir + '\';
  coneccion.Params.Add('Server=' + servidor);
  coneccion.Params.Add('User_Name=postgres');
  coneccion.Params.Add('Password=admindie');
  coneccion.Params.Add('Database=' + bd);
  coneccion.Params.Add('DriverID=PG');
  coneccion.Params.Add('DriverName=PG');
  coneccion.Params.Add('Port=5432');
  coneccion.Params.Add('ApplicationName=Sistema de Pensiones');
  try
    coneccion.Connected := True;
    fnConeccion := True;
  except
    fnConeccion := false;
  end;
end;

{ Función que devuelve verdadero al verificar si se puede conectar al servidor de
  base de datos y llena el combo de estados si no pide la configuración del mismo y devuelve false }
function fnCargaDtofe(Sql: String; cboDtofe: TComboBox): boolean;
var
  qry: TFDQuery;
  ip: TStringList;

begin
  try
    ip := TStringList.Create;
    ip.LoadFromFile(ExtractFilePath(Application.ExeName) + '\coneccion.txt');
    qry := TFDQuery.Create(nil);
    qry.Connection := dmDatos.pgconeccion;
    qry.Sql.Clear;
    cboDtofe.Items.Clear;
    cboDtofe.Text := '';
    qry.Sql.Add(Sql);
    qry.Active := True;
    while not qry.Eof do
    begin
      cboDtofe.Items.Add(qry.Fields[1].Value + ' ' + qry.Fields[2].Value);
      qry.Next;
    end;
    fnCargaDtofe := True;
  except
    fnCargaDtofe := false;
  end;
  cboDtofe.ItemIndex := 0;
  qry.Close;
  qry.Free;
end;

function fnrSolreimp(numfuar: String): boolean;
var
  qry: TFDQuery;
  Count: integer;

begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  fnrSolreimp := false;
  qry.Sql.Clear;
  qry.Sql.Add('select num_fuar from datos.fuars where num_fuar=' + '''' +
    numfuar + '''');
  qry.Active := True;
  Count := qry.RecordCount;
  qry.Close;
  if Count > 0 Then
  begin
    qry.Sql.Clear;
    qry.Sql.Add('update datos.fuars set solreimp = solreimp + 1 where num_fuar='
      + '''' + numfuar + '''');
    qry.ExecSQL;
    fnrSolreimp := True;
  end;
  qry.Close;
  qry.Free;
end;

function chkVentana(id: integer): boolean;
begin
  if frmPrincipal.nummodulo > 0 then
  begin
    if Application.MessageBox
      ('¿Está seguro que desea salir de la operación actual?',
      Pchar('Confirmar'), (MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION)) = IDYES
      then
      begin
        { ------Cierra el módulo abierto------- }
        //      ShowMessage(IntToStr(frmPrincipal.nummodulo));
        if frmPrincipal.nummodulo = 9 then
          frmadminusuarios.Close;
        if frmPrincipal.nummodulo = 261 then
          frmimportar.Close;
        if frmPrincipal.nummodulo = 264 then
          frmAclaraciones.Close;
        if frmPrincipal.nummodulo = 11 then
          frmcmov.Close;
        if frmPrincipal.nummodulo = 12 then
          frmcdep.Close;
        if frmPrincipal.nummodulo = 13 then
          frmcemp.Close;

        { -------Abre el módulo que está solicitando abrirse------- }
        if id = 9 then
          if not Assigned(frmadminusuarios) then
            frmadminusuarios := Tfrmadminusuarios.Create(nil)
          else
            frmadminusuarios.Show;
        if id = 11 then
          if not Assigned(frmcmov) then
            frmcmov := Tfrmcmov.Create(nil)
          else
            frmcmov.Show;
        if id = 12 then
          if not Assigned(frmcdep) then
            frmcdep := Tfrmcdep.Create(nil)
          else
            frmcdep.Show;
        if id = 13 then
          if not Assigned(frmcemp) then
            frmcemp := Tfrmcemp.Create(nil)
          else
            frmcemp.Show;
        if id = 261 then
          if not Assigned(frmactualiza) then
            frmactualiza := Tfrmactualiza.Create(nil)
          else
            frmactualiza.Show;
        if id = 264 then
          if not Assigned(frmAclaraciones) then
            frmAclaraciones := TfrmAclaraciones.Create(nil)
          else
            frmAclaraciones.Show;
    end;
  end
  else
  begin
      if id = 9 then
        if not Assigned(frmadminusuarios) then
          frmadminusuarios := Tfrmadminusuarios.Create(nil)
        else
          frmadminusuarios.Show;
      if id = 11 then
        if not Assigned(frmcmov) then
          frmcmov := Tfrmcmov.Create(nil)
        else
          frmcmov.Show;
      if id = 12 then
        if not Assigned(frmcdep) then
          frmcdep := Tfrmcdep.Create(nil)
        else
          frmcdep.Show;
      if id = 13 then
        if not Assigned(frmcemp) then
          frmcemp := Tfrmcemp.Create(nil)
        else
          frmcdep.Show;
      if id = 261 then
        if not Assigned(frmactualiza) then
          frmactualiza := Tfrmactualiza.Create(nil)
        else
          frmactualiza.Show;
        if id = 264 then
          if not Assigned(frmAclaraciones) then
            frmAclaraciones := TfrmAclaraciones.Create(nil)
          else
            frmAclaraciones.Show;
  end;
end;


procedure pGenfolios();
var
  qry, qrysel, qryupd: TFDQuery;
  dto, num_fuar: String;
  idfuarelec, paquetelec: integer;

begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  qry.Sql.Clear;
  qrysel := TFDQuery.Create(nil);
  qrysel.Connection := dmDatos.pgconeccion;
  qryupd := TFDQuery.Create(nil);
  qryupd.Connection := dmDatos.pgconeccion;
  qry.Sql.Add
    ('select substring(num_fuar from 5 for 2) as cvedtofe from datos.fuars where archivo_origen like '''
    + '%ENTREGADA%' + '''  group by substring(num_fuar from 5 for 2)');
  qry.Active := True;
  qry.First;
  while not qry.Eof do
  begin
    idfuarelec := 1;
    paquetelec := 1;
    qrysel.Sql.Clear;
    dto := qry.Fields[0].Value;
    qrysel.Sql.Add
      ('select num_fuar from datos.fuars where archivo_origen like ''' +
      '%ENTREGADA%' + ''' and substring(num_fuar from 5 for 2)=''' + dto +
      ''' order by archivo_origen,id');
    qrysel.Active := True;
    qrysel.First;
    while not qrysel.Eof do
    begin
      num_fuar := qrysel.Fields[0].Value;
      qryupd.Sql.Clear;
      qryupd.Sql.Add('update datos.fuars set idfuarelec =' +
        IntToStr(idfuarelec) + ',paqueteelec=' + IntToStr(paquetelec) +
        ' where num_fuar=''' + num_fuar + '''');
      qryupd.ExecSQL;
      idfuarelec := idfuarelec + 1;
      if idfuarelec > 500 then
        idfuarelec := 1;
      if idfuarelec = 1 then
        paquetelec := paquetelec + 1;
      qrysel.Next;
    end;
    qry.Next;
  end;
end;

function fnValconecciones(): boolean;
var
  qry: TFDQuery;

begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  fnValconecciones := True;
  qry.Sql.Clear;
  qry.Sql.Add('select text(client_addr) from pg_stat_activity where datname='''
    + 'FUARS' + ''' and substring(text(client_addr) from 0 for 2) <>''' +
    ':' + '''');
  qry.Active := True;
  if qry.RecordCount > 0 then
    fnValconecciones := false;
  qry.Close;
  qry.Free;
end;

procedure valSolinv(num_fuar, txtDistrito, txtPaquete: String);
var
  qry: TFDQuery;
  consulta: String;
  rec: integer;

begin
  { Valida que exista un registro electrónico si existe continua el proceso si
    no crea una incidencia del registro físico no encontrado en el registro electrónico }
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  qry.Active := false;
  consulta := 'select count(num_fuar) from datos.fuars where num_fuar = ''' +
    trim(num_fuar) + '''';
  qry.Sql.Clear;
  qry.Sql.Add(consulta);
  qry.Active := True;
  rec := qry.Fields[0].Value;
  qry.Active := false;
  if rec > 0 then { Si encuentra un fuar }
  begin
    consulta := 'select count(num_fuar) from datos.fuars where num_fuar = ''' +
      trim(num_fuar) + ''' and fuar_fisico in (''' + '1' + ''',''' +
      '2' + ''')';
    qry.Sql.Clear;
    qry.Sql.Add(consulta);
    qry.Active := True;
    rec := qry.Fields[0].Value;
    qry.Active := false;
    if rec > 0 Then
    begin
      ShowMessage('');
      ShowMessage('FUAR ya registrado...');
    end
    else
    begin
      qry.Close;
      qry.Sql.Clear;
      qry.Sql.Add('update datos.fuars set fuar_fisico=''' + '1' +
        ''',paquete = ''' + txtPaquete + ''',idusuario = ''' +
        IntToStr(ufunciones.idusuario) + ''' where num_fuar= ''' +
        trim(num_fuar) + '''');
      qry.ExecSQL;
    end;
  end
  else
  begin
    ShowMessage('');
    if Application.MessageBox('FUAR Físico no encontrado... ' + sLineBreak +
      ' desea agregar un registro de insidencia?',
      Pchar('Confirmar insidencia'),
      (MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION)) = IDYES then
    begin
      qry.Sql.Clear;
      qry.Sql.Add
        ('insert into datos.fuars(num_fuar,fuar_fisico,paquete,idusuario)  values('''
        + trim(num_fuar) + ''',''' + '2' + ''',''' + txtPaquete + ''',''' +
        IntToStr(ufunciones.idusuario) + ''');');
      try
        qry.ExecSQL;
      except
        on E: Exception do
          ShowMessage('Este FUAR ya fué registrado');
      end;
    end;
  end; // if rec > 0 then{Si encuentra un fuar }
end;

procedure ToggleTreeViewCheckBoxes(Node: TTreeNode;
  cUnChecked, cChecked: integer);
var
  tmp: TTreeNode;
begin
  if Assigned(Node) then
  begin
    if Node.StateIndex = cUnChecked then
      Node.StateIndex := cChecked
    else if Node.StateIndex = cChecked then
      Node.StateIndex := cUnChecked
  end; // if Assigned(Node)
end; (* ToggleTreeViewCheckBoxes *)

function fHabilitabtn(idusuario: integer; idbtn: integer): boolean;
var
  qry: TFDQuery;
  habilitado: boolean;

begin
  if idbtn <> 0 then
  begin
    qry := TFDQuery.Create(nil);
    qry.Connection := dmDatos.pgconeccion;
    qry.Sql.Clear;
    qry.Sql.Add('select habilitar from catalogos.opciones where idusuario=' +
      IntToStr(idusuario) + ' and idopcion=' + IntToStr(idbtn));
    qry.Active := True;
    habilitado := qry.FieldByName('habilitar').AsBoolean;
    qry.Active := false;
    qry.Free;
    Result := habilitado;
  end;
end;

{ Funcion que recupera las opciones que estan registradas en la base de datos
  para el usuario que es pasado como parametro }
function fnRecuperaopc(tvOpciones: TTreeView; idusuario: integer;
  limpiar: boolean): boolean;
var
  i: integer;
  chk: boolean;

begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  for i := 0 to tvOpciones.Items.Count - 1 do
  begin
    chk := false;
    if tvOpciones.Items[i].StateIndex <> -1 then
      tvOpciones.Items[i].StateIndex := 1;
    if not limpiar then
    begin
      qry.Sql.Clear;
      qry.Open('select habilitar from catalogos.opciones where idusuario=' +
        IntToStr(idusuario) + ' and idopcion=' + IntToStr(i));
      chk := qry.FieldByName('habilitar').AsBoolean;
      if chk then
        tvOpciones.Items[i].StateIndex := 2;
    end;
  end;
  qry.Close;
end;

procedure limpiaGrid(sgArchivos: TStringGrid);
var
  i: integer;

begin
  for i := 1 To 20 do
  begin
    sgArchivos.RowCount := +sgArchivos.RowCount;
    sgArchivos.Cells[0, i] := '';
    sgArchivos.Cells[1, i] := '';
  end;
  for i := 0 to sgArchivos.RowCount - 1 do
    THackGrid(sgArchivos).DeleteRow(i);
end;
end.
