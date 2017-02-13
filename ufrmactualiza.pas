unit ufrmactualiza;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls,Vcl.Grids, Vcl.DBGrids,Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.CheckLst,
  Vcl.DBCtrls,FireDAC.Comp.Client,Data.DB,Vcl.Imaging.jpeg,ShellApi,
  Data.Win.ADODB, Vcl.Mask, Vcl.Menus, System.ImageList, Vcl.ImgList,
  Vcl.DBActns, System.Actions, Vcl.ActnList,StrUtils, uselfecha, frxClass,
  frxDBSet, System.Math;

type
  Tfrmactualiza = class(TForm)
    pnlPinArriba: TPanel;
    Image1: TImage;
    Image2: TImage;
    pnlFaltantes: TPanel;
    pnlPinder: TPanel;
    bNavegador: TDBNavigator;
    btnProcesar: TSpeedButton;
    btnEliminar: TSpeedButton;
    btnModificar: TSpeedButton;
    btnGuardar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnActualizar: TSpeedButton;
    btnCerrarmod: TBitBtn;
    acciones: TActionList;
    dsEliminar: TDataSetDelete;
    dsModificar: TDataSetEdit;
    dsGuardar: TDataSetPost;
    dsCancelar: TDataSetCancel;
    dsRefresh: TDataSetRefresh;
    dsInsertar: TDataSetInsert;
    DataSetFirst1: TDataSetFirst;
    DataSetPrior1: TDataSetPrior;
    DataSetNext1: TDataSetNext;
    DataSetLast1: TDataSetLast;
    ImageList: TImageList;
    PopupMenu: TPopupMenu;
    First1: TMenuItem;
    Prior1: TMenuItem;
    Next1: TMenuItem;
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
    frxrteTotales: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    CategoryPanelGroup: TCategoryPanelGroup;
    CategoryPanel: TCategoryPanel;
    pnlIzquierdo: TPanel;
    pnlActualizacion: TPanel;
    DBGrid: TDBGrid;
    Panel: TPanel;
    Panel2: TPanel;
    txtRuta: TEdit;
    btnExaminar: TBitBtn;
    Panel3: TPanel;
    dtFregistro: TDateTimePicker;
    procedure btnCerrarmodClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnExaminarClick(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnProcesarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmactualiza: Tfrmactualiza;

implementation

{$R *.dfm}

uses udmDatos,ufunciones,ufuncsispe, ufrmprincipal;


procedure Tfrmactualiza.btnExaminarClick(Sender: TObject);
var
  archenc: TStringList;
  Carpeta,nomfile,cuenta,ctipo,tipo,quincena,year,cdesde,cmes,chasta,dependencia,status : String;
  i, nMaxWidth, nItemWidth : integer;
  openDialog : TOpenDialog;
  qry, qryPG : TFDQuery;
  desde,hasta : TDate;
  mes : Integer;
  existe : Boolean;
  wideChars   : array[0..250] of WideChar;

begin
  qry := TFDQuery.Create(nil);
  qryPG := TFDQuery.Create(nil);
  archenc := TStringlist.Create;
  qry.Connection := dmDatos.coneccionSqlLite;
  qryPG.Connection := dmDatos.pgconeccion;
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := [ofAllowMultiSelect];
  openDialog.Filter :=
      'Archivos DBF|*.dbf';
  openDialog.FilterIndex := 1;
  qry.SQL.Clear;
  qry.SQL.Add('delete from actualizacion');
  qry.ExecSQL;
  qry.SQL.Clear;
  {Reseteamos el autoincrementable}
  qry.SQL.Add('UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME='+chr(39)+'actualizacion'+chr(39));
  qry.ExecSQL;
  qry.Close;
  if openDialog.Execute then
  begin
    txtRuta.Text := extractfiledir(opendialog.FileName);
    for i := 0 to openDialog.Files.Count-1 do
    begin
      existe := False;
    {Obtenemos el nombre del archivo que se van a importar}
      nomfile := ExtractFileName(openDialog.Files[i]);
      nomfile := copy(nomfile,1,Pos('.',nomfile)-1);
      nomfile:= UpperCase(nomfile);
      {validamos que el archivo no exista en la tabla historial.archivos de la principal PG
      si existe no lo subimos y lo dejamos en la tabla temporal actualizacion SqlLite de lo
      contrario se registra }
      qryPG.SQL.Clear;
      qryPG.SQL.Add('select archivo from historial.archivos where archivo =' + chr(39) + nomfile + chr(39));
      qryPG.Active := True;
      if qryPG.RecordCount > 0 then
        existe := True;
      qryPG.Close;
      nomfile  := ansiuppercase(nomfile);
      ctipo    := Copy(nomfile, 1, 1);
      cuenta   := Copy(nomfile, 2, 3);
      year     := '20' + Copy(nomfile, 5, 2);
      quincena := Copy(nomfile, 7, 2);
      mes      := Floor((StrToInt(quincena)+1)/2);
      cmes     := IntToStr(mes);
      if  cmes.Length = 1 then
        cmes := '0'+cmes;
      if (StrToInt(quincena) mod 2 ) = 0 then
      begin
        if quincena = '04' then
        begin
          cdesde := '16/' + cmes + '/' + year;
          chasta := '28/'  + cmes + '/' + year;
        end
        else
        begin
          cdesde := '16/' + cmes + '/' + year;
          chasta := '30/'  + cmes + '/' + year;
        end;
      end
      else
      begin
        cdesde := '01/' + cmes + '/' + year;
        chasta := '15/' + cmes + '/' + year;
      end;
      qryPG.SQL.Clear;
      qryPG.SQL.Add('select cuenta,descripcion,status from catalogos.disket where cuenta=''' + Copy(nomfile, 2, 3)+'''');
      qryPG.Active := True;
      dependencia  := qryPG.FieldByName('descripcion').AsString;
      status       := qryPG.FieldByName('status').AsString;
      if existe Then
        archenc.Add('Archivo: ' + nomfile + ' Dependencia: ' + dependencia);
      qryPG.Active := False;
      if ctipo='A' then
        tipo := 'APORTACION'
      else
        tipo := 'DESCUENTO';
      qry.SQL.Clear;
      qry.SQL.Add('insert into actualizacion(archivo,dependencia,desde,hasta,cuenta,status,concepto,tipo,anio,mes,existe)');
      qry.SQL.Add('values(''' + nomfile + ''','''+ dependencia+''','''+cdesde+''','''+chasta+''','''+cuenta+chr(39)+','+chr(39)+status+chr(39)+','+chr(39)+tipo+chr(39)+','+chr(39)+ctipo+chr(39)+','+chr(39)+year+chr(39)+','+chr(39)+cmes+chr(39)+','+BoolToStr(existe)+')');
      qry.ExecSQL;
    end;
    dmDatos.QrySqlLite.Active := False;
    dmDatos.QrySqlLite.SQL.Clear;
    dmDatos.QrySqlLite.SQL.Add('select * from actualizacion');
    dmDatos.QrySqlLite.Active := True;
  end;
  {importante si existen el el historico.archivos no incluirlos en el grid y al finalizar la carga dar la lista de archivos ke ya han sido cargados anteriormente}
//  sbimportar.Panels[0].Text := 'Importar '+IntToStr(i)+' archivos CSV';
  archenc.SaveToFile(ExtractFilePath(Application.ExeName) + '\tmp\encontrados.txt');
  openDialog.Free;
  {Activa la barra horizontal en la lista de archivos}
  qry.Close;
  qry.Free;
  qryPG.Close;
  qryPG.Free;
  if dmDatos.QrySqlLite.RecordCount > 0 then
  begin
    if archenc.Count > 0 then
    begin
      ShowMessage('¡Se encontraron archivos que ya habian sido dado de alta se mostrará la lista!');
      ShellExecute(Handle, 'open', 'notepad.exe',StringToWideChar(ExtractFilePath(Application.ExeName) + '\tmp\encontrados.txt',wideChars, 250), nil, SW_SHOW);
    end;
    btnProcesar.Enabled := True;
  end;
end;

procedure Tfrmactualiza.btnCerrarmodClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmactualiza.btnProcesarClick(Sender: TObject);
var
  pgQry,pgQry2      : TFDQuery;
  ADOTable          : TADOTable;
  ruta,nomarch,dependencia,desde,hasta,canio,cmes,t_prestamo,archivos : String;
  rfc,nombre,proyecto,categoria,cuenta,tipoaporta,curp,sexo,sentencia:string;
  sueldo,aportacion,normal,retroactivo,sueldotot : Double;
  fnac : TDate;
  borrame : TStringlist;
  anio,mes,dia : Word;
  cWideString  : WideString;
  cWideCharPtr : PWideChar;
  cvedesc,folio,numdesc,totdesc : Integer;
  importe,patronal : double;
  historial : Boolean;

begin
  dtFregistro.Date := Now();
  cWideString  := 'Se ingresaran los archivo con la fecha: ' + DateToStr(dtFregistro.Date);
  cWideCharPtr := Addr(cWideString[1]);
  if Application.MessageBox(cWideCharPtr,'¡Atencion!',mb_OkCancel+mb_IconQuestion)= IdOk then
  begin
    borrame      := TStringlist.Create;
    ADOTable     := TADOTable.Create(nil);
    pgQry        := TFDQuery.Create(nil);
    pgQry2       := TFDQuery.Create(nil);
    pgQry.Connection   := dmDatos.pgconeccion;
    pgQry2.Connection  := dmDatos.pgconeccion;
    ruta := txtRuta.Text;
    ADOTable.ConnectionString := 'Provider=VFPOLEDB.1;Data Source='+ruta+';Password="";Collating Sequence=MACHINE';
    historial := False;
    archivos:='';
    dmDatos.QrySqlLite.Close;
    dmDatos.QrySqlLite.SQL.Clear;
    dmDatos.QrySqlLite.SQL.Add('select * from actualizacion');
    dmDatos.QrySqlLite.Active := True;
    dmDatos.QrySqlLite.First;
    while not dmDatos.QrySqlLite.Eof do {Recorre la lista de archivos que se van a ingresar}
    begin
      {Por cada registro de la tabla actualizacion vamos a recorrer el archivo DBF
      relacionado a ese registro y lo vamos a agregar a la tabla empleados y aportaciones,d_ecquir,d_echipo}
      nomarch := dmDatos.QrySqlLite.FieldByName('archivo').AsString;
      archivos:= archivos + chr(39) + nomarch + chr(39) + ',';
      dependencia := dmDatos.QrySqlLite.FieldByName('dependencia').AsString;
      desde := dmDatos.QrySqlLite.FieldByName('desde').AsString;
      hasta := dmDatos.QrySqlLite.FieldByName('hasta').AsString;
      cuenta := dmDatos.QrySqlLite.FieldByName('cuenta').AsString;
      canio := dmDatos.QrySqlLite.FieldByName('anio').AsString;
      cmes := dmDatos.QrySqlLite.FieldByName('mes').AsString;
      ADOTable.TableName := nomarch;
      ADOTable.Active := True;
      sueldo      := 0.00;
      normal      := 0.00;
      retroactivo := 0.00;
      patronal := 0.00;
      sueldotot := 0.00;
      importe := 0.00;
      while not ADOTable.Eof do {Recorre el archivo DBF de la lista de SqlLite}
      begin
        if copy(nomarch,1,1) ='A' then {Si el Archivo es de Aportadores}
        begin
          fnAportaciones(ADOTable,nomarch,dependencia,desde,hasta,dtFregistro.Date);
          if ADOTable.FieldByName('tipoaporta').AsString = 'N' then
          begin
            normal := normal + ADOTable.FieldByName('aportacion').AsFloat;
            sueldo := sueldo + ADOTable.FieldByName('sueldo').AsFloat;
          end;
          if ADOTable.FieldByName('tipoaporta').AsString = 'R' then
            retroactivo := retroactivo + ADOTable.FieldByName('aportacion').AsFloat;
          if dmDatos.ADOTable.FindField('patronal') <> nil then
            patronal := ADOTable.FieldByName('patronal').AsFloat;
        end;
        if copy(nomarch,1,1) ='D' then {Si el Archivo es de Descuentos}
        begin
          nombre := Trim(ADOTable.FieldByName('nombre').AsString);
          rfc := Trim(ADOTable.FieldByName('rfc').AsString);
          proyecto := Trim(ADOTable.FieldByName('proyecto').AsString);
          cvedesc  := ADOTable.FieldByName('cvedesc').AsInteger;
          folio    := ADOTable.FieldByName('folio').AsInteger;
          numdesc  := ADOTable.FieldByName('numdesc').AsInteger;
          totdesc  := ADOTable.FieldByName('totdesc').AsInteger;
          importe := importe + ADOTable.FieldByName('importe').AsFloat;
          if ADOTable.FindField('curp') <> nil then
            curp := Trim(ADOTable.FieldByName('curp').AsString)
          else
            curp := '';
          if cvedesc = 205 then {Prestamo Quirografario}
            t_prestamo := 'Q';
          if cvedesc = 206 then {Prestamo Hipotecario}
            t_prestamo := 'H';
          pgQry.SQL.Clear;
          pgQry.SQL.Add('select folio from datos.prestamos where folio =' + IntToStr(folio));
          pgQry.Active := True;
          if pgQry.RecordCount > 0 then {Si encuentra el folio en la tabla de prestamos}
            sentencia := 'VALUES('+IntToStr(folio)+','+ chr(39)+desde+chr(39)+','+chr(39)+rfc+chr(39)+','+ IntToStr(numdesc)+','+IntToStr(totdesc)+','+FloatToStr(importe)+','+ chr(39)+cuenta +chr(39)+','+ chr(39)+proyecto +chr(39)+','+chr(39)+t_prestamo+chr(39)+','+chr(39)+nomarch+chr(39)+','+chr(39)+desde+chr(39)+','+chr(39)+hasta+chr(39)+','+chr(39)+curp+chr(39)+','+chr(39)+'N'+chr(39)+');'
          else
            sentencia := 'VALUES('+IntToStr(folio)+','+ chr(39)+desde+chr(39)+','+chr(39)+rfc+chr(39)+','+ IntToStr(numdesc)+','+IntToStr(totdesc)+','+FloatToStr(importe)+','+ chr(39)+cuenta +chr(39)+','+ chr(39)+proyecto +chr(39)+','+chr(39)+t_prestamo+chr(39)+','+chr(39)+nomarch+chr(39)+','+chr(39)+desde+chr(39)+','+chr(39)+hasta+chr(39)+','+chr(39)+curp+chr(39)+','+chr(39)+'P'+chr(39)+');';
          try
            pgQry2.SQL.Clear;
            pgQry2.SQL.Add('insert into datos.descuentos(folio, f_descuento, rfc, numdesc, totdesc, importe,');
            pgQry2.SQL.Add('cuenta, proyecto,t_prestamo,archivo, desde, hasta, curp, status) ');
            pgQry2.SQL.Add(sentencia);
            pgQry2.ExecSQL;
          except on E: Exception do
          begin
            ShowMessage('Ocurrio un error verifique los registros del archivo: '+nomarch);
          end;
          end;
        end;
        pgQry.Active := False;
        ADOTable.Next;
      end;{while not ADOTable.Eof do}
      {Ya que se ingresaron los registros del archivo a la tabla empleados se ingresan los datos del archivo a la tabla historial.archivos}
      if copy(nomarch,1,1) ='A' then {Si el Archivo es de Aportadores}
      begin
        {Si todo el proceso de Aportaciones sale bien agraga un registro al historial de archivos }
        {Se agrega el registro al historial de archivos}
        pgQry2.SQL.Clear;
        pgQry2.SQL.Add('insert into historial.archivos(archivo,dependencia,desde,hasta,tipo,cuenta,anio,mes,normal,retroactivo,total,sueldo,fecha,patronal) ');
        pgQry2.SQL.Add('values('+chr(39)+nomarch+chr(39)+','+chr(39)+dependencia+chr(39)+
        ','+chr(39)+desde+chr(39)+','+chr(39)+hasta+chr(39)+','+chr(39)+copy(nomarch,1,1)+chr(39)+
        ','+chr(39)+cuenta+chr(39)+ ','+chr(39)+canio+chr(39)+','+chr(39)+cmes+chr(39)+
        ','+FloatToStr(normal)+','+FloatToStr(retroactivo)+','+FloatToStr(normal+retroactivo)+','+FloatToStr(sueldo)+ ',current_timestamp,'+FloatToStr(patronal) + ')');
        try
          pgQry2.ExecSQL;
        except on E: Exception do
          ShowMessage('Ocurrio un error verifique el archivo: '+nomarch);
        end;
      end;
      if copy(nomarch,1,1) ='D' then {Si el Archivo es de Descuentos}
      begin
        pgQry2.Close;
        pgQry2.SQL.Clear;
        pgQry2.SQL.Add('insert into historial.archivos(archivo,dependencia,desde,hasta,tipo,cuenta,anio,mes,normal,retroactivo,total,sueldo,fecha) ');
        pgQry2.SQL.Add('values('+chr(39)+nomarch+chr(39)+','+chr(39)+dependencia+chr(39)+
        ','+chr(39)+desde+chr(39)+','+chr(39)+hasta+chr(39)+','+chr(39)+copy(nomarch,1,1)+chr(39)+
        ','+chr(39)+cuenta+chr(39)+ ','+chr(39)+canio+chr(39)+','+chr(39)+cmes+chr(39)+
        ','+FloatToStr(normal)+','+FloatToStr(retroactivo)+','+FloatToStr(importe)+','+FloatToStr(sueldotot)+ ',current_timestamp)');
        try
          pgQry2.ExecSQL;
        except on E: Exception do
          ShowMessage('Ocurrio un error verifique el archivo: '+nomarch);
        end;
      end;
      pgQry2.Close;;
      borrame.SaveToFile('D:\QRY.TXT');
      ADOTable.Active := False;
      dmDatos.QrySqlLite.Next;
    end;
    ShowMessage('Proceso Terminado');
  end;
  dmDatos.qryReportes.Close;
  archivos := copy(archivos,0,length(archivos)-1);
  dmDatos.qryReportes.Sql.Clear;
  if copy(nomarch,1,1) ='A' Then
    dmDatos.qryReportes.Sql.Add('select (total/sueldo) * 100 as porcen,* from historial.archivos where archivo in (' +archivos +')' )
  else
    dmDatos.qryReportes.Sql.Add('select 0 as porcen,* from historial.archivos where archivo in (' +archivos +')' );
  try
    dmDatos.qryReportes.Active := True;
    frxrteTotales.ShowReport();
  except on E: Exception do
    ShowMessage('Error al generar el reporte');
  end;
  pgQry.Free;
  pgQry2.Free;
  borrame.Free;
  ADOTable.Free;
  dmDatos.qryReportes.Close;
end;

procedure Tfrmactualiza.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  qry : TFDQuery;

begin
  if (Key=VK_DELETE) then
  begin
    qry := TFDQuery.Create(nil);
    qry.Connection := dmDatos.coneccionSqlLite;
    qry.SQL.Add('delete from actualizacion where id =' + IntToStr(dmDatos.QrySqlLite.FieldByName('id').AsInteger));
    qry.ExecSQL;
    qry.Close;
    qry.Free;
    dmDatos.QrySqlLite.Refresh;
  end;
end;

procedure Tfrmactualiza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal.nummodulo:=0;
  frmactualiza := nil;
  Action := caFree;
end;

procedure Tfrmactualiza.FormCreate(Sender: TObject);
begin
  {Se Agrega el identificador de este formulario a la variable gobal }
  frmPrincipal.nummodulo :=261;
  pnlActualizacion.Width := 750;
  btnProcesar.Enabled := False;
end;

procedure Tfrmactualiza.FormResize(Sender: TObject);
begin
  dtFregistro.Left := Panel.Width - 200;
  Panel3.Left := Panel.Width - 200;
end;

end.
