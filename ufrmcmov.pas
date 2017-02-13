unit ufrmcmov;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls,Vcl.Grids, Vcl.DBGrids,Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.CheckLst,
  Vcl.DBCtrls,FireDAC.Comp.Client,Data.DB,Vcl.Imaging.jpeg,ShellApi,
  Data.Win.ADODB;

type
  Tfrmcmov = class(TForm)
    sbimportar: TStatusBar;
    pnlPinArriba: TPanel;
    Image1: TImage;
    Image2: TImage;
    pnlFaltantes: TPanel;
    pnlPinder: TPanel;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    DBNavigator1: TDBNavigator;
    btnNuevo: TSpeedButton;
    btnEliminar: TSpeedButton;
    btnModificar: TSpeedButton;
    btnGuardar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnActualizar: TSpeedButton;
    btnCerrarmod: TBitBtn;
    gridMovimientos: TDBGrid;
    procedure btnCerrarmodClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcmov: Tfrmcmov;
  qry : TFDQuery;
  dsqry : TDatasource;


implementation

{$R *.dfm}

uses udmDatos,ufunciones, ufrmprincipal;


procedure Tfrmcmov.btnCerrarmodClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmcmov.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qry.Close;
  qry.Free;
  dsqry.Free;
  frmPrincipal.nummodulo:=0;
  frmcmov := nil;
  Action := caFree;
end;

procedure Tfrmcmov.FormCreate(Sender: TObject);
begin
  btnNuevo.Enabled := False;
  btnEliminar.Enabled := False;
  btnModificar.Enabled := False;
  btnGuardar.Enabled := False;
  btnCancelar.Enabled := False;
  btnActualizar.Enabled := False;
  frmPrincipal.nummodulo :=11;
  qry := TFDQuery.Create(nil);
  dsqry := TDatasource.Create(nil);
  dsqry.AutoEdit := False;
  qry.Connection := dmDatos.pgconeccion;
  qry.SQL.Add('select tipo_mov,tipo,movimiento from catalogos.movimientos');
  dsqry.Dataset := qry;
  gridMovimientos.DataSource := dsqry;
  qry.Active := True;
end;

end.
