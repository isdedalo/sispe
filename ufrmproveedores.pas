unit ufrmproveedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client,
  Vcl.Grids,Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,Data.DB,
  Vcl.DBCtrls, Vcl.Mask, Vcl.DBActns, System.Actions, Vcl.ActnList, Vcl.ImgList,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,System.DateUtils,
  IdExplicitTLSClientServerBase, IdFTP, Vcl.Imaging.jpeg, System.ImageList,
  Vcl.Menus, Vcl.OleCtrls, SHDocVw, ShellApi;

type
  TfrmProveedores = class(TForm)
    pnlPinArriba: TPanel;
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
    pnlPinder: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    btnGuardar: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    btnSalir: TBitBtn;
    pnlFaltantes: TPanel;
    DBNavigator1: TDBNavigator;
    Image1: TImage;
    Image2: TImage;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    Label2: TLabel;
    txtId: TDBEdit;
    txtDescripcion: TDBEdit;
    pnlEnc1: TPanel;
    PopupMenu1: TPopupMenu;
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
    ImageList1: TImageList;
    Label6: TLabel;
    DBGrid1: TDBGrid;
    txtBuscar: TEdit;
    btnBuscar: TButton;
    procedure btnSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cFlatUnCheck = 0;
  cFlatChecked = 1;


var
  frmProveedores: TfrmProveedores;

implementation

{$R *.dfm}

uses ufunciones, ufrmprincipal, udmDatos;

procedure TfrmProveedores.btnSalirClick(Sender: TObject);
begin
  frmProveedores.Close;
end;

procedure TfrmProveedores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal.nummodulo:=0;
  frmProveedores := nil;
  Action := caFree;
end;

end.
