unit ufrmempleados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,FireDAC.Comp.Client;

type
  Tfrmempleados = class(TForm)
    pnlFaltantes: TPanel;
    PnlTop: TPanel;
    txtRfc: TEdit;
    Panel6: TPanel;
    txtNombre: TEdit;
    Panel7: TPanel;
    Panel8: TPanel;
    DBGrid: TDBGrid;
    pnlPinder: TPanel;
    btnCerrarmod: TBitBtn;
    pnlBottom: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnCerrarmodClick(Sender: TObject);
    procedure txtRfcChange(Sender: TObject);
    procedure txtNombreChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmempleados: Tfrmempleados;

implementation

{$R *.dfm}

uses udmDatos, ufuncsispe;

var
  qryPG : TFDQuery;
  dsqryPG : TDataSource;

procedure Tfrmempleados.btnCerrarmodClick(Sender: TObject);
begin
  dmDatos.QrySqlLite.Edit;
  dmDatos.QrySqlLite.FieldByName('aclaracion').AsString := Trim(qryPG.FieldByName('rfc').AsString);
  dmDatos.QrySqlLite.Post;
  Close;
end;

procedure Tfrmempleados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryPG.Close;
  qryPG.Free;
  frmempleados := nil;
  Action := caFree;
end;

procedure Tfrmempleados.FormCreate(Sender: TObject);
begin
  qryPG := TFDQuery.Create(nil);
  dsqryPG := TDataSource.Create(nil);
  dsqryPG.DataSet := qryPG;
  qryPG.Connection := dmDatos.pgconeccion;
  DBGrid.DataSource := dsqryPG;
  qryPG.SQL.Add('select rfc,nombre_em from datos.empleados where pendiente = false limit 25');
  qryPG.Active := True;
end;

procedure Tfrmempleados.txtNombreChange(Sender: TObject);
begin
  if Length(txtNombre.Text)>0 then
  begin
    qryPG.Close;
    qryPG.Active := False;
    qryPG.SQL.Clear;
    qryPG.SQL.Add('select rfc,nombre_em from datos.empleados where pendiente = false and nombre_em ilike '+chr(39) + txtNombre.Text +'%' + chr(39));
    qryPG.Active := True;
  end;
end;

procedure Tfrmempleados.txtRfcChange(Sender: TObject);
begin
  if Length(txtRfc.Text)>0 then
  begin
    qryPG.Close;
    qryPG.Active := False;
    qryPG.SQL.Clear;
    qryPG.SQL.Add('select rfc,nombre_em from datos.empleados where pendiente = false and rfc ilike '+chr(39) + txtRfc.Text +'%' + chr(39));
    qryPG.Active := True;
  end;
end;

end.
