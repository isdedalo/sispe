unit ufrmimportar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls,Vcl.Grids, Vcl.DBGrids,Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.CheckLst,
  Vcl.DBCtrls,FireDAC.Comp.Client,Data.DB,Vcl.Imaging.jpeg,ShellApi,
  Data.Win.ADODB;

type
  TfrmImportar = class(TForm)
    sbimportar: TStatusBar;
    pnlPinArriba: TPanel;
    Image1: TImage;
    Image2: TImage;
    pnlFaltantes: TPanel;
    pnlPinder: TPanel;
    DBNavigator: TDBNavigator;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    Panel9: TPanel;
    listArchivos: TCheckListBox;
    Panel4: TPanel;
    Panel1: TPanel;
    txtAbrir: TEdit;
    btnAbrir: TBitBtn;
    btnImportar: TBitBtn;
    btnCerrarmod: TBitBtn;
    ADOConnection1: TADOConnection;
    CategoryPanel2: TCategoryPanel;
    procedure btnImportarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnGenfoliosClick(Sender: TObject);
    procedure btnCerrarmodClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportar: TfrmImportar;

implementation

{$R *.dfm}

uses udmDatos,ufunciones, ufrmprincipal;

procedure TfrmImportar.btnEliminarClick(Sender: TObject);
var
  qry : TFDQuery;
  Sql : String;
  Dir : String;
  Archivos: TSearchRec;

begin
{  if FindFirst(ExtractFilePath (Application.ExeName)+'archivos\*.csv', faAnyFile, Archivos) = 0 then
    if application.MessageBox ('Existen archivos en la carpeta desea Eliminarlos permanentemente...? ',pchar('Confirmar ...'),
      (MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION)) = IDYES then
    begin
      {Borra todo el contenido de la carpeta archivos}
{      Dir:=ExtractFilePath (Application.ExeName)+'\archivos\*.*';
      if FindFirst(Dir, faArchive, Archivos) = 0 then
      begin
        repeat
        if (Archivos.Attr and faArchive) = Archivos.Attr then
        begin
          DeleteFile(ExtractFilePath (Application.ExeName)+'\archivos\'+Archivos.Name);
        end;
        until FindNext(Archivos) <> 0;
        FindClose(Archivos);
      end;
    end;
  }
end;

procedure TfrmImportar.btnCerrarmodClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmImportar.btnAbrirClick(Sender: TObject);
var
  directorio : TStringList;
  Carpeta: String;
  i, nMaxWidth, nItemWidth : integer;
  openDialog : TOpenDialog;
begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := [ofAllowMultiSelect];
  openDialog.Filter :=
      'Archivos DBF|*.dbf';
  openDialog.FilterIndex := 1;
  if openDialog.Execute then
  begin
    listArchivos.Clear;
    txtAbrir.Text := extractfiledir(opendialog.FileName);
    for i := 0 to openDialog.Files.Count-1 do
    begin
      listArchivos.Items.Add(ExtractFileName(openDialog.Files[i]));
      listArchivos.Checked[i] := true;
      listArchivos.State[i]   := cbChecked;
    end;
  end;
  if openDialog.Files.Count>0 then
    btnImportar.Enabled:=True
  else
    btnImportar.Enabled:=False;
  sbimportar.Panels[0].Text := 'Importar '+IntToStr(i)+' archivos CSV';
  openDialog.Free;
  {Activa la barra horizontal en la lista de archivos}
  nMaxWidth := listArchivos.ClientWidth;
	for i := 0 to listArchivos.Items.Count - 1 do
	begin
		nItemWidth := Length(listArchivos.Items[i]) * 5 + 100;
		if (nItemWidth > nMaxWidth) then
			nMaxWidth := nItemWidth;
	end;
	if (nMaxWidth > listArchivos.ClientWidth) then
		listArchivos.ScrollWidth := nMaxWidth;
end;

procedure TfrmImportar.btnGenfoliosClick(Sender: TObject);
var
  qry,qrysel,qryupd : TFDQuery;
  dto,num_fuar : String;
  idfuarelec,paquetelec : Integer;

begin
  if application.MessageBox ('Asignar un Fólio y un Paquete a toda la conciliación de FUARs entregadas...? ',pchar('Confirmar ...'),
    (MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION)) = IDYES then
  begin
    qry := TFDQuery.Create(nil);
    qry.Connection := dmDatos.pgconeccion;
    qry.SQL.Clear;
    qrysel := TFDQuery.Create(nil);
    qrysel.Connection := dmDatos.pgconeccion;
    qryupd := TFDQuery.Create(nil);
    qryupd.Connection := dmDatos.pgconeccion;
    qry.SQL.Add('select substring(num_fuar from 5 for 2) as cvedtofe from datos.fuars where archivo_origen like '''+'%ENTREGADA%'+'''  group by substring(num_fuar from 5 for 2)');
    qry.Active:=True;
    qry.First;
    while not qry.Eof do
    begin
      idfuarelec := 1;
      paquetelec := 1;
      qrysel.SQL.Clear;
      dto := qry.Fields[0].Value;
      qrysel.SQL.Add('select num_fuar from datos.fuars where archivo_origen like '''+'%ENTREGADA%'+''' and substring(num_fuar from 5 for 2)='''+dto+''' order by archivo_origen,id');
      qrysel.Active:=True;
      qrysel.First;
      while not qrysel.Eof do
      begin
        num_fuar := qrysel.Fields[0].Value;
        qryupd.SQL.Clear;
  //      ShowMessage('update datos.fuars set idfuarelec ='+IntToStr(idfuarelec)+',paqueteelec='+IntToStr(paquetelec)+' where num_fuar='''+num_fuar+'''');
        qryupd.SQL.Add('update datos.fuars set idfuarelec ='+IntToStr(idfuarelec)+',paqueteelec='+IntToStr(paquetelec)+' where num_fuar='''+num_fuar+'''');
        qryupd.ExecSQL;
        idfuarelec := idfuarelec + 1;
        if idfuarelec>500 then
          idfuarelec:=1;
        if idfuarelec=1 then
          paquetelec := paquetelec + 1;
        qrysel.Next;
      end;
      qry.Next;
    end;
    ShowMessage('Folios generados correctamente...');
  end;
end;

procedure TfrmImportar.btnImportarClick(Sender: TObject);
var
  archivo,campos,repetidos,sql,documentos,solreimp : TStringList;
  i,n,x,y,z,ndoc: integer;
  nombrearch,entidad,distrito,palabra,tipodoc,nomarch,sentencia: string;
  qry : TFDQuery;
//  Archivos: TSearchRec;

begin
  z:=0;
  repetidos  := TStringList.Create;
  repetidos.Clear;
  sql  := TStringList.Create;
  //sbimportar.Panels[2].Width:=350;
  {Se establecen las propiedades de la barra de progreso}
  {Crear carpeta para guardar los todos los archivos importados}
{  If not DirectoryExists(ExtractFilePath(Application.ExeName)+'\archivos') then
    MKdir(ExtractFilePath(Application.ExeName)+'\archivos');
  {Borra todo el contenido de la carpeta archivos}
{  Dir:=ExtractFilePath (Application.ExeName)+'\archivos\*.*';
  if FindFirst(Dir, faArchive, Archivos) = 0 then
  begin
    repeat
    if (Archivos.Attr and faArchive) = Archivos.Attr then
    begin
      DeleteFile(ExtractFilePath (Application.ExeName)+'\archivos\'+Archivos.Name);
    end;
    until FindNext(Archivos) <> 0;
    FindClose(Archivos);
  end;}
  for y:=0  to listArchivos.Items.Count-1 do begin
    if listArchivos.Checked[y] then begin
      archivo := TStringList.Create;
      campos  := TStringList.Create;
      documentos := TStringList.Create;
      solreimp := TStringList.Create;
      solreimp.Clear;
      nombrearch := listArchivos.Items[y];
      nomarch := nombrearch;
      {Copia la lista de archivos a la carpeta archivos}
       //CopyFile(PChar(txtAbrir.Text+'\'+nombrearch), PChar(ExtractFilePath(Application.ExeName)+'\archivos\'+nombrearch), false);
        nombrearch := txtAbrir.Text+'\'+nombrearch;
        archivo.LoadFromFile(nombrearch);
        archivo.Delimiter:='|';
        sbimportar.Panels[1].Width:=370;
        sbimportar.Panels[1].Text := ExtractFileName(nombrearch);
        for i := 1 to archivo.count -1 do begin{recorre todo el archivo csv}
          campos.Clear;
          sbimportar.Panels[2].Text := IntToStr(Round(((y*100)/listArchivos.Items.Count-1))) + ' %';
          for n:=1 to GetTokenCount(archivo[i],'|') do begin {Corta cada campo dividido por el simbolo |}
            campos.Add(trim((GetToken(archivo[i],'|',n))));{Lo ingresa a una lista de cadenas}
          end;
      frmimportar.Refresh;
      end;{Fin del for i := 1 to archivo.count -1}
      archivo.free;
      campos.free;
      end;{Fin del if listArchivos.Checked[y] then begin}
      {Si hay mas de una solicitud de reimpresion lo pasa a una función
      para validar que exista su correspondiente fuar en caso de no existir
      ingresa un registro de excepción en el log de transacciones.}

      if solreimp.Count>0 Then
        for n:=0 to solreimp.Count-1 do
        begin
          if not fnrSolreimp(solreimp[n]) Then
            repetidos.Add('|SOLICITUD DE REIMPRESION SIN SU FUAR: '+listArchivos.Items[y]+'| ' + 'Fuar:'+solreimp[n] + ' Fecha:' + FormatDateTime( 'd/m/y hh:mm:ss ', Now ));
        end;
    end;
    //repetidos.SaveToFile(ExtractFilePath(Application.ExeName)+'\log\log.txt');//Activar si se desea guardar los registros repetidos en un archivo de texto
    if FileExists(ExtractFilePath(Application.ExeName)+'\log\log.txt')then
    begin
      ShowMessage('Se encontraron registros repetidos se abrirá un editor de texto ' + sLineBreak +  'con los siguientes datos: Nombre del archivo y número de FUAR... ');
      ShellExecute(Handle, 'open', 'notepad.exe', Pchar(ExtractFilePath(Application.ExeName)+'\log\log.txt'), '', SW_SHOW);
    end;
    sbimportar.Panels[1].Width:=200;
//    sql.SaveToFile('SQL.txt');//Activar si se desea salvar la sentencia SQL a un archivo de texto
    repetidos.Free;
    sql.Free;
    sbimportar.Panels[1].Text := 'Generando Folios espere un momento';
    pGenfolios();
    sbimportar.Panels[1].Text := 'Total de registros importados...'+IntToStr(z);
    sbimportar.Panels[2].Text := 'Total de registros duplicados...'+IntToStr(x);
    ShowMessage('Proceso Finalizado se ingresaron '+IntToStr(z)+' registros a la Base de Datos' );
    z:=0;x:=0;
end;

procedure TfrmImportar.btnLimpiarClick(Sender: TObject);
var
  qry : TFDQuery;

begin
  if application.MessageBox ('Esta acción eliminará todos los registros de la base de datos...? ',pchar('Confirmar ...'),
    (MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION)) = IDYES then
  begin
    qry       := TFDQuery.Create(nil);
    qry.Connection := dmDatos.pgconeccion;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('delete from datos.fuars;');
    qry.ExecSQL;
    ShowMessage('Registros Borrados correctamente...');
    qry.Close;
    qry.Free;
  end;
end;

procedure TfrmImportar.Button1Click(Sender: TObject);
var
  Carpeta: String;
  directorio : TStringList;
  i : Integer;
begin
  if SelectDirectory(
    'Seleccione una carpeta', // Texto de la ventana
    'c:\documentos',  // Carpeta inicial
    Carpeta  // Carpeta seleccionada
  )
  then
  txtAbrir.Text := carpeta;
  Directorio := TStringList.Create;
  listArchivos.Clear;
  ShowMessage(IntToStr(Directorio.Count));
  for i := 0 to Directorio.Count-1 do begin
    listArchivos.Items.Add(Directorio[i]);
    listArchivos.Checked[i] := true;
    listArchivos.State[i]   := cbChecked;
  end;
  if Directorio.Count>0 then
    btnImportar.Enabled:=True
  else
    btnImportar.Enabled:=False;
  Directorio.Free;
  sbimportar.Panels[0].Text := 'Archivos cargados...'+IntToStr(i);
end;

procedure TfrmImportar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal.nummodulo:=0;
  frmimportar := nil;
  Action := caFree;
end;

procedure TfrmImportar.FormCreate(Sender: TObject);
var
  Dir,Sql : String;
  Archivos: TSearchRec;
  qry : TFDQuery;

begin
  qry       := TFDQuery.Create(nil);
  qry.Connection := dmDatos.pgconeccion;
  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('select count(*) from datos.fuars where cvedto='''+ ufunciones.cvedtofe +'''');
  qry.Active := False;
  btnImportar.Enabled := False;
  qry.Close;
  qry.Free;
  frmPrincipal.nummodulo :=261;
{Crear carpeta para guardar los todos los archivos importados}
{  If not DirectoryExists(ExtractFilePath(Application.ExeName)+'\archivos') then
    MKdir(ExtractFilePath(Application.ExeName)+'\archivos');}

{Carga el combo de Distritos que se han cargado en la base de datos que está en la pestaña Eliminar registros cargados}
  Sql := 'select cveent,cvedtofe,descripcion from catalogos.catdtofe where cveent='''+cveent+'''  and cvedtofe in (select substring(num_fuar from 5 for 2) as cvedtofe from datos.fuars group by substring(num_fuar from 5 for 2)) order by cveent,cvedtofe';
end;

procedure TfrmImportar.SpeedButton1Click(Sender: TObject);
var
  i, nMaxWidth, nItemWidth : integer;
  openDialog : TOpenDialog;
begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := [ofAllowMultiSelect];
  openDialog.Filter := 'Archivos CSV|*.csv|Archivos de Texto|*.txt';
  openDialog.FilterIndex := 1;
  i:=0;
  if not openDialog.Execute then
    ShowMessage('Apertura de archivos cancelada...')
  else
  begin
    listArchivos.Clear;
    txtAbrir.Text := extractfiledir(opendialog.FileName);
    for i := 0 to openDialog.Files.Count-1 do
    begin
      listArchivos.Items.Add(ExtractFileName(openDialog.Files[i]));
      listArchivos.Checked[i] := true;
      listArchivos.State[i]   := cbChecked;
    end;
  end;
  if openDialog.Files.Count>0 then
    btnImportar.Enabled:=True
  else
    btnImportar.Enabled:=False;
  sbimportar.Panels[0].Text := 'Importados '+IntToStr(i)+' archivos CSV';
  openDialog.Free;
  {Activa la barra horizontal en la lista de archivos}
  nMaxWidth := listArchivos.ClientWidth;
	for i := 0 to listArchivos.Items.Count - 1 do
	begin
		nItemWidth := Length(listArchivos.Items[i]) * 5 + 100;
		if (nItemWidth > nMaxWidth) then
			nMaxWidth := nItemWidth;
	end;
	if (nMaxWidth > listArchivos.ClientWidth) then
		listArchivos.ScrollWidth := nMaxWidth;
end;

procedure TfrmImportar.SpeedButton2Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to listArchivos.Count - 1 do
    listArchivos.Checked[i] := false;
end;

procedure TfrmImportar.SpeedButton3Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to listArchivos.Count - 1 do
    listArchivos.Checked[i] := true;
end;

procedure TfrmImportar.SpeedButton6Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to listArchivos.Count - 1 do
    listArchivos.Checked[i] := not listArchivos.Checked[i];
end;

function numeroSeleccionados (lista : TCheckListBox) : integer;
var
  i : integer;
  numero : integer;
begin
  numero := 0;
  for i := 0 to lista.Count - 1 do
    if lista.Checked[i] then
      numero := numero + 1;
  result := numero;
end;
end.
