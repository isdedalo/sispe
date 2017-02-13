unit ufrmcemp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls,Vcl.Grids, Vcl.DBGrids,Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.CheckLst,
  Vcl.DBCtrls,FireDAC.Comp.Client,Data.DB,Vcl.Imaging.jpeg,ShellApi,
  Data.Win.ADODB, Vcl.Mask, Vcl.Menus, System.ImageList, Vcl.ImgList,
  Vcl.DBActns, System.Actions, Vcl.ActnList;

type
  Tfrmcemp = class(TForm)
    pnlPinArriba: TPanel;
    Image1: TImage;
    Image2: TImage;
    pnlFaltantes: TPanel;
    pnlPinder: TPanel;
    CategoryPanelGroup: TCategoryPanelGroup;
    bNavegador: TDBNavigator;
    btnNuevo: TSpeedButton;
    btnEliminar: TSpeedButton;
    btnModificar: TSpeedButton;
    btnGuardar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnActualizar: TSpeedButton;
    btnCerrarmod: TBitBtn;
    CategoryPanel: TCategoryPanel;
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
    pnlDerecho: TPanel;
    Label11: TLabel;
    txtRfc: TDBEdit;
    txtNombre: TDBEdit;
    Panel5: TPanel;
    txtBuscar: TEdit;
    txtSexo: TDBEdit;
    txtFnac: TDBEdit;
    txtStatus: TDBEdit;
    mDireccion: TDBMemo;
    Panel1: TPanel;
    txtNap: TDBEdit;
    txtFing: TDBEdit;
    txtCuenta: TDBEdit;
    txtProyecto: TDBEdit;
    txtCateg: TDBEdit;
    txtSueldo: TDBEdit;
    txtTiporel: TDBEdit;
    pnlIzquierdo: TPanel;
    lblRfc: TLabel;
    lblNombre: TLabel;
    lblSexo: TLabel;
    lblFnac: TLabel;
    lblEstatus: TLabel;
    lblDireccion: TLabel;
    lblNap: TLabel;
    lblFingreso: TLabel;
    lblDependencia: TLabel;
    lblProyecto: TLabel;
    lblCvecateg: TLabel;
    lblSueldo: TLabel;
    lblRelaboral: TLabel;
    cboBuscar: TComboBox;
    Panel4: TPanel;
    procedure btnCerrarmodClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure txtBuscarClick(Sender: TObject);
    procedure txtBuscarChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcemp: Tfrmcemp;

implementation

{$R *.dfm}

uses udmDatos,ufunciones, ufrmprincipal;


procedure Tfrmcemp.btnCerrarmodClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmcemp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmDatos.Qry.Close;
  frmPrincipal.nummodulo:=0;
  frmPrincipal.StatusBar.Panels[4].Text := '';
  frmcemp := nil;
  Action := caFree;
end;

procedure Tfrmcemp.FormCreate(Sender: TObject);
begin
  {Se Agrega el identificador de este formulario a la variable gobal }
  frmPrincipal.nummodulo :=13;
  cboBuscar.ItemIndex := 0;
  {Agrega la consulta al dataset Qry [consultas] ubicado en el múdulode datos
  dmDatos}
  dmDatos.Qry.SQL.Clear;
  dmDatos.Qry.SQL.Add('select id,rfc,nombre_em,sexo,fecha_nac,status,direccion,nap,');
  dmDatos.Qry.SQL.Add('fecha_ing,depe,proyecto,cve_categ,sueldo_base,tipo_rel ');
  dmDatos.Qry.SQL.Add('from datos.empleados');

  {Agrega la sentencia de actualización al objeto fdUpdqry [insert] ubicado en el múdulode datos
  dmDatos}
  dmDatos.fdUpdqry.InsertSQL.Clear;
  dmDatos.fdUpdqry.InsertSQL.Add('insert into datos.empleados');
  dmDatos.fdUpdqry.InsertSQL.Add('(rfc,nombre_em,sexo,fecha_nac,status,direccion,nap,');
  dmDatos.fdUpdqry.InsertSQL.Add('fecha_ing,depe,proyecto,cve_categ,sueldo_base,tipo_rel) ');
  dmDatos.fdUpdqry.InsertSQL.Add('values (:rfc,:nombre_em,:sexo,:fecha_nac,:status,:direccion,:nap,');
  dmDatos.fdUpdqry.InsertSQL.Add(':fecha_ing,:depe,:proyecto,:cve_categ,:sueldo_base,:tipo_rel) ');
  dmDatos.fdUpdqry.InsertSQL.Add('returning id,rfc,nombre_em,sexo,fecha_nac,status,direccion,nap,');
  dmDatos.fdUpdqry.InsertSQL.Add('fecha_ing,depe,proyecto,cve_categ,sueldo_base,tipo_rel');
  {Agrega la sentencia de modificación al objeto fdUpdqry [update] ubicado en el múdulode datos
  dmDatos}
  dmDatos.fdUpdqry.ModifySQL.Clear;
  dmDatos.fdUpdqry.ModifySQL.Add('update datos.empleados ');
  dmDatos.fdUpdqry.ModifySQL.Add('set rfc = :rfc,  nombre_em = :nombre_em,  sexo = :sexo,');
  dmDatos.fdUpdqry.ModifySQL.Add('fecha_nac = :fecha_nac,  status = :status,  direccion = :direccion,');
  dmDatos.fdUpdqry.ModifySQL.Add('nap = :nap,  fecha_ing = :fecha_ing,  depe = :depe,  proyecto = :proyecto,');
  dmDatos.fdUpdqry.ModifySQL.Add('cve_categ = :cve_categ,  sueldo_base = :sueldo_base,  tipo_rel = :tipo_rel ');
  dmDatos.fdUpdqry.ModifySQL.Add('where id = :old_id ');
  dmDatos.fdUpdqry.ModifySQL.Add('returning id,rfc,nombre_em,sexo,fecha_nac,status,direccion,nap,fecha_ing,depe,');
  dmDatos.fdUpdqry.ModifySQL.Add('proyecto,cve_categ,sueldo_base,tipo_rel ');
  {Agrega la sentencia de eliminación al objeto fdUpdqry [borrado] ubicado en el múdulode datos
  dmDatos}
  dmDatos.fdUpdqry.DeleteSQL.Clear;
  dmDatos.fdUpdqry.DeleteSQL.Add('delete from datos.empleados ');
  dmDatos.fdUpdqry.DeleteSQL.Add('where id = :old_id');
  {Agrega la sentencia de re al objeto fdUpdqry [borrado] ubicado en el múdulode datos
  dmDatos}
  dmDatos.fdUpdqry.FetchRowSQL.Clear;
  dmDatos.fdUpdqry.FetchRowSQL.Add('select id,rfc,nombre_em,sexo,fecha_nac,status,direccion,nap,');
  dmDatos.fdUpdqry.FetchRowSQL.Add('fecha_ing,depe,proyecto,cve_categ,sueldo_base,tipo_rel ');
  dmDatos.fdUpdqry.FetchRowSQL.Add('from datos.empleados where id = :id order by id');
  {Asignamos campos a los objetos que muestran datos}
  txtRfc.DataField := 'rfc';
  txtNombre.DataField := 'nombre_em';
  txtSexo.DataField := 'sexo';
  txtFnac.DataField := 'fecha_nac';
  txtStatus.DataField := 'status';
  mDireccion.DataField := 'direccion';
  txtNap.DataField := 'nap';
  txtFing.DataField := 'fecha_ing';
  txtCuenta.DataField := 'depe';
  txtProyecto.DataField := 'proyecto';
  txtCateg.DataField := 'cve_categ';
  txtSueldo.DataField := 'sueldo_base';
  txtTiporel.DataField := 'tipo_rel';
  bNavegador.DataSource := dmDatos.dsQry;
  dmDatos.Qry.Active:= True;
end;

procedure Tfrmcemp.txtBuscarChange(Sender: TObject);
begin
  if cboBuscar.ItemIndex = 0  then
    dmDatos.Qry.Filter := '[rfc] = ' + QuotedStr(txtBuscar.Text + '*')
  else
    dmDatos.Qry.Filter := '[nombre_em] = ' + QuotedStr(txtBuscar.Text + '*');
  dmDatos.qRY.Filtered := True;
end;

procedure Tfrmcemp.txtBuscarClick(Sender: TObject);
begin
  txtBuscar.Text := '';
end;

end.
