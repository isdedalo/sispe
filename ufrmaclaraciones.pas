unit ufrmaclaraciones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Comp.Client,
  System.DateUtils ;

type
  TfrmAclaraciones = class(TForm)
    pnlFaltantes: TPanel;
    pnlPinder: TPanel;
    bNavegador: TDBNavigator;
    btnCerrarmod: TBitBtn;
    DBGrid: TDBGrid;
    PnlTop: TPanel;
    etiqueta2: TPanel;
    etiqueta1: TPanel;
    pnlBottom: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    txtRfc: TEdit;
    Panel6: TPanel;
    txtNombre: TEdit;
    Panel7: TPanel;
    Panel8: TPanel;
    btnProcesar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PnlTopResize(Sender: TObject);
    procedure txtRfcChange(Sender: TObject);
    procedure txtNombreChange(Sender: TObject);
    procedure btnCerrarmodClick(Sender: TObject);
    procedure DBGridCellClick(Column: TColumn);
    procedure btnProcesarClick(Sender: TObject);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAclaraciones: TfrmAclaraciones;

implementation

{$R *.dfm}

uses udmDatos, ufrmprincipal, ufuncsispe, ufunciones, ufrmempleados;

procedure TfrmAclaraciones.txtNombreChange(Sender: TObject);
begin
  dmdatos.Qry.Active := True;
  if Length(txtNombre.Text)>0 then
  begin
    dmDatos.QrySqlLite.Active :=  False;
    fnSqliteAclaraciones('select id,rfc,nombre_em from datos.empleados where pendiente = true and nombre_em ilike '+chr(39)+ txtNombre.Text +'%' +chr(39)+' order by nombre_em');
    dmDatos.QrySqlLite.SQL.Add('select * from aclaraciones order by nombre');
  end;
  dmDatos.QrySqlLite.Active := True;
end;

procedure TfrmAclaraciones.btnCerrarmodClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAclaraciones.btnProcesarClick(Sender: TObject);
var
  pgQry : TFDQuery;

begin
  Pgqry            := Tfdquery.Create(Nil);
  Pgqry.Connection := Dmdatos.Pgconeccion;
  while not dmdatos.QrySqlLite.Eof do
  begin
    {Si la marca es un registro Nuevo efectua este proceso}
    if dmdatos.QrySqlLite.FieldByName('mca').AsString ='N' then
    begin
      try
        Pgqry.SQL.Clear;
        Pgqry.SQL.Add('update datos.empleados set pendiente = false,faclaracion='+chr(39)+ formatdatetime('dd/mm/yy hh:nn:ss', now()) + chr(39) + ',taclaracion='+chr(39)+ dmdatos.QrySqlLite.FieldByName('mca').AsString + chr(39)+',idusuarioa='+ IntToStr(ufunciones.idusuario) +' where rfc='+chr(39)+ Trim(dmdatos.QrySqlLite.FieldByName('rfc').AsString)+chr(39));
        Pgqry.ExecSQL;
        Pgqry.SQL.Clear;
        Pgqry.SQL.Add('insert into historial.movimientos(rfc_ant, rfc_nue, movimiento, fmovimiento, idusuario) values('+chr(39)+dmdatos.QrySqlLite.FieldByName('rfc').AsString+chr(39)+','+chr(39)+chr(39)+','+chr(39)+'N-> REGISTRO NUEVO SE AFECTO ESTATUS DE PENDIENTE EN EMPLEADOS Y EL RFC DE LA TABLA APORTACIONES'+chr(39)+','+chr(39)+ formatdatetime('dd/mm/yy hh:nn:ss', now()) + chr(39)+','+ IntToStr(ufunciones.idusuario) +');');
        Pgqry.ExecSQL;
        ShowMessage('El proceso se efectuo correctamente');
      except on E: Exception do
        ShowMessage('Ocurrio un error verifique los datos de este RFC: '+dmdatos.QrySqlLite.FieldByName('rfc').AsString);
      end;
    end;
    {Si la marca es un registro Incorrecto efectua este proceso}
    if dmdatos.QrySqlLite.FieldByName('mca').AsString ='I' then
    begin
      try
        Pgqry.SQL.Clear;
        Pgqry.SQL.Add('update datos.empleados set rfc='+chr(39)+dmdatos.QrySqlLite.FieldByName('aclaracion').AsString+chr(39)+',pendiente = false,faclaracion='+chr(39)+ formatdatetime('dd/mm/yy hh:nn:ss', now()) + chr(39) + ',taclaracion='+chr(39)+ dmdatos.QrySqlLite.FieldByName('mca').AsString + chr(39)+',idusuarioa='+ IntToStr(ufunciones.idusuario) +' where rfc='+chr(39)+ Trim(dmdatos.QrySqlLite.FieldByName('rfc').AsString)+chr(39));;
        Pgqry.ExecSQL;
        Pgqry.SQL.Clear;
        Pgqry.SQL.Add('update datos.aportaciones set rfc='+chr(39)+dmdatos.QrySqlLite.FieldByName('aclaracion').AsString+chr(39)+' where rfc='+chr(39)+ Trim(dmdatos.QrySqlLite.FieldByName('rfc').AsString)+chr(39));;
        Pgqry.ExecSQL;
        Pgqry.SQL.Clear;
        Pgqry.SQL.Add('insert into historial.movimientos(rfc_ant, rfc_nue, movimiento, fmovimiento, idusuario) values('+chr(39)+dmdatos.QrySqlLite.FieldByName('rfc').AsString+chr(39)+','+chr(39)+dmdatos.QrySqlLite.FieldByName('aclaracion').AsString+chr(39)+','+chr(39)+'I-> RFC INCORRECTO SE AFECTO ESTATUS DE PENDIENTE EN EMPLEADOS ASI COMO ACTUALIZO EL RFC CON EL DEL CAMPO ACLARACION SE AFECTA TAMBIEN LA TABLA APORTACIONES'+chr(39)+','+chr(39)+ formatdatetime('dd/mm/yy hh:nn:ss', now()) + chr(39)+','+ IntToStr(ufunciones.idusuario) +');');
        Pgqry.ExecSQL;
        ShowMessage('El proceso se efectuo correctamente');
      except on E: Exception do
        ShowMessage('Ocurrio un error verifique los datos de este RFC: '+dmdatos.QrySqlLite.FieldByName('rfc').AsString);
      end;
    end;
    {Si la marca es un registro Correcto efectua este proceso}
    if dmdatos.QrySqlLite.FieldByName('mca').AsString ='C' then
    begin
      try
        Pgqry.SQL.Clear;
        Pgqry.SQL.Add('update datos.empleados set rfc='+chr(39)+dmdatos.QrySqlLite.FieldByName('aclaracion').AsString+chr(39)+',pendiente = false,faclaracion='+chr(39)+ formatdatetime('dd/mm/yy hh:nn:ss', now()) + chr(39) + ',taclaracion='+chr(39)+ dmdatos.QrySqlLite.FieldByName('mca').AsString + chr(39)+',idusuarioa='+ IntToStr(ufunciones.idusuario) +' where rfc='+chr(39)+ Trim(dmdatos.QrySqlLite.FieldByName('rfc').AsString)+chr(39));;
//        Pgqry.SQL.SaveToFile('D:\BORAME.TXT');
        Pgqry.ExecSQL;
        Pgqry.SQL.Clear;
        Pgqry.SQL.Add('update datos.aportaciones set rfc='+chr(39)+dmdatos.QrySqlLite.FieldByName('rfc').AsString+chr(39)+' where rfc='+chr(39)+ Trim(dmdatos.QrySqlLite.FieldByName('aclaracion').AsString)+chr(39));;
        Pgqry.ExecSQL;
        Pgqry.SQL.Clear;
        Pgqry.SQL.Add('insert into historial.movimientos(rfc_ant, rfc_nue, movimiento, fmovimiento, idusuario) values('+chr(39)+dmdatos.QrySqlLite.FieldByName('rfc').AsString+chr(39)+','+chr(39)+dmdatos.QrySqlLite.FieldByName('aclaracion').AsString+chr(39)+','+chr(39)+'C-> RFC CORRECTO SE AFECTO ESTATUS DE PENDIENTE EN EMPLEADOS ASI COMO ACTUALIZO EL RFC CON EL DEL CAMPO ACLARACION SE AFECTA TAMBIEN LA TABLA APORTACIONES'+chr(39)+','+chr(39)+ formatdatetime('dd/mm/yy hh:nn:ss', now()) + chr(39)+','+ IntToStr(ufunciones.idusuario) +');');
        Pgqry.ExecSQL;
        ShowMessage('El proceso se efectuo correctamente');
      except on E: Exception do
        ShowMessage('Ocurrio un error verifique los datos de este RFC: '+dmdatos.QrySqlLite.FieldByName('rfc').AsString);
      end;
    end;
    dmdatos.QrySqlLite.Next;
  end;
  dmdatos.QrySqlLite.Refresh;
end;

procedure TfrmAclaraciones.DBGridCellClick(Column: TColumn);
begin
  if dmdatos.QrySqlLite.FieldByName('mca').AsString ='N' then
    dmDatos.QrySqlLite.FieldByName('aclaracion').ReadOnly := True
  else
   dmDatos.QrySqlLite.FieldByName('aclaracion').ReadOnly := False;
  if (DbGrid.SelectedIndex = 3) and ((dmdatos.QrySqlLite.FieldByName('mca').AsString ='C') or (dmdatos.QrySqlLite.FieldByName('mca').AsString ='I')) then
  begin
    if not Assigned(frmempleados) then
      frmempleados := Tfrmempleados.Create(nil)
    else
      frmempleados.Show;
  end;
end;

procedure TfrmAclaraciones.DBGridKeyPress(Sender: TObject; var Key: Char);
begin
  Key := UpCase(Key);
  if DbGrid.SelectedIndex = 0 then
  begin
    if (key<>'N') and (key<>'I') and (key<>'C') then
      key:=' ';
  end;
end;

procedure TfrmAclaraciones.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal.nummodulo:=0;
  frmAclaraciones := nil;
  dmDatos.qry.Active := False;
  Action := caFree;
end;

procedure TfrmAclaraciones.FormCreate(Sender: TObject);
var
  nombre,rfc : String;
  idpemplea  : Integer;

begin
  {Se Agrega el identificador de este formulario a la variable gobal }
  frmPrincipal.nummodulo := 264;
  fnSqliteAclaraciones('select id,rfc,nombre_em from datos.empleados where pendiente=true order by nombre_em limit 50');
  dmDatos.QrySqlLite.SQL.Add('select * from aclaraciones order by rfc,nombre');
  dmDatos.QrySqlLite.Active := True;
  dmDatos.QrySqlLite.FieldByName('rfc').ReadOnly := True;
  dmDatos.QrySqlLite.FieldByName('nombre').ReadOnly := True;
end;

procedure TfrmAclaraciones.PnlTopResize(Sender: TObject);
begin
  etiqueta1.Left := (pnlTop.Width div 2) - etiqueta1.Width div 2 ;
  etiqueta2.Left := pnlTop.Width div 2 - etiqueta2.Width div 2 ;
end;

procedure TfrmAclaraciones.txtRfcChange(Sender: TObject);
begin
  dmdatos.Qry.Active := True;
  if Length(txtRfc.Text)>0 then
  begin
    dmDatos.QrySqlLite.Active :=  False;
    fnSqliteAclaraciones('select id,rfc,nombre_em from datos.empleados where pendiente=true and rfc ilike '+chr(39)+ txtRfc.Text +'%' +chr(39)+' order by nombre_em');
    dmDatos.QrySqlLite.SQL.Add('select * from aclaraciones order by nombre');
  end;
  dmDatos.QrySqlLite.Active := True;
end;

end.
