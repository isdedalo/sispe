unit ufrmprincipal;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.Menus, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ImgList, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin, ShlObj, SysUtils,
  System.Actions, Vcl.Imaging.jpeg, Vcl.CategoryButtons, Vcl.DBActns,
  System.ImageList, FireDAC.UI.Intf, FireDAC.VCLUI.Script, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, Vcl.Imaging.pngimage, Vcl.WinXCtrls;

type
  TfrmPrincipal = class(TForm)
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileClose1: TWindowClose;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowArrangeAll1: TWindowArrange;
    HelpAbout1: TAction;
    ImageList: TImageList;
    ProgressBar: TProgressBar;
    DatasetInsert1: TDataSetInsert;
    DatasetInsert2: TDataSetInsert;
    mnuPrincipal: TMainMenu;
    Catlogos1: TMenuItem;
    Movimientos1: TMenuItem;
    Dependencias1: TMenuItem;
    Empleados1: TMenuItem;
    Categoras1: TMenuItem;
    Proyectos1: TMenuItem;
    Firmas1: TMenuItem;
    FondodePensiones1: TMenuItem;
    Aportaciones1: TMenuItem;
    Consultas1: TMenuItem;
    Fusionar1: TMenuItem;
    Reportes1: TMenuItem;
    N1: TMenuItem;
    Constancias1: TMenuItem;
    Diskettes1: TMenuItem;
    ReportesdeSaldos1: TMenuItem;
    Elaborar1: TMenuItem;
    Imprimir1: TMenuItem;
    Actualizar1: TMenuItem;
    VaciarBE1: TMenuItem;
    Resumen1: TMenuItem;
    Aclaraciones1: TMenuItem;
    Reportes2: TMenuItem;
    ReportedeSaldos1: TMenuItem;
    ReportedePendientes1: TMenuItem;
    PrestacionesEconmicas1: TMenuItem;
    OtorgamientoPQ1: TMenuItem;
    Altasdesolicitudes1: TMenuItem;
    ModificarSolicitudes1: TMenuItem;
    ActualizacionFechasdeCheque1: TMenuItem;
    N2: TMenuItem;
    Utilerias1: TMenuItem;
    Reportes3: TMenuItem;
    asas1: TMenuItem;
    FolioActual1: TMenuItem;
    Verprogramacin1: TMenuItem;
    Programarcheques1: TMenuItem;
    SolicEntrega1: TMenuItem;
    Pagares1: TMenuItem;
    Alfabtico1: TMenuItem;
    Montos1: TMenuItem;
    Actualizar2: TMenuItem;
    Consultar1: TMenuItem;
    Reportes4: TMenuItem;
    OtorgamientoPH1: TMenuItem;
    Expediente1: TMenuItem;
    Solicitudes1: TMenuItem;
    Documentos1: TMenuItem;
    Reportes5: TMenuItem;
    N3: TMenuItem;
    FechaAutorizacin1: TMenuItem;
    Complementopconsejo1: TMenuItem;
    CambiodeStatus1: TMenuItem;
    asaas1: TMenuItem;
    ReporteHipotecarios1: TMenuItem;
    Actualizar3: TMenuItem;
    Consultar2: TMenuItem;
    Reportes6: TMenuItem;
    Estadosdecuenta1: TMenuItem;
    Consulta1: TMenuItem;
    Consultapdev1: TMenuItem;
    N4: TMenuItem;
    Quirografario1: TMenuItem;
    Hipotecarios1: TMenuItem;
    Actualizacin1: TMenuItem;
    Interesesmoratorios1: TMenuItem;
    N5: TMenuItem;
    Saldos1: TMenuItem;
    EstadosdeCuenta2: TMenuItem;
    RegistrosManuales1: TMenuItem;
    Controlyregistro1: TMenuItem;
    Quirografarios1: TMenuItem;
    Generarporfecha1: TMenuItem;
    AltasCambios1: TMenuItem;
    ActualizarRelLab1: TMenuItem;
    ValidarSitLab1: TMenuItem;
    FondodeGarantia1: TMenuItem;
    DevFdoGarantia1: TMenuItem;
    Captura1: TMenuItem;
    Hipotecarios2: TMenuItem;
    Generarporfecha2: TMenuItem;
    AltasCambios2: TMenuItem;
    ActualizarRelLab2: TMenuItem;
    ValidarSitLab2: TMenuItem;
    Reportes7: TMenuItem;
    Diskettes2: TMenuItem;
    N6: TMenuItem;
    Validaciones1: TMenuItem;
    Sinpagos1: TMenuItem;
    erminandepagar1: TMenuItem;
    Sinestadosdecuenta1: TMenuItem;
    Seguros1: TMenuItem;
    IncrementarSeries1: TMenuItem;
    Importarinformacin1: TMenuItem;
    UltimosAsegurados1: TMenuItem;
    Actualizacin2: TMenuItem;
    Quirografarios2: TMenuItem;
    Hipotecarios3: TMenuItem;
    Reportes8: TMenuItem;
    Generar1: TMenuItem;
    Quirografarios3: TMenuItem;
    Hipotecarios4: TMenuItem;
    Diskettes3: TMenuItem;
    Pagodemarcha1: TMenuItem;
    AltasCambios3: TMenuItem;
    Impresin1: TMenuItem;
    N7: TMenuItem;
    PagoporCaja1: TMenuItem;
    SV: TSplitView;
    catMenuItems: TCategoryButtons;
    imlIcons: TImageList;
    ActionList2: TActionList;
    actHome: TAction;
    actLayout: TAction;
    actPower: TAction;
    pnlToolbar: TPanel;
    imgMenu: TImage;
    lblTitle: TLabel;
    Action1: TAction;
    actSalir: TAction;
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure AdministracindeusuariosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Ayuda1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnM1aClick(Sender: TObject);
    procedure btnM2aClick(Sender: TObject);
    procedure btnM2bClick(Sender: TObject);
    procedure btnM3aClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnM3bClick(Sender: TObject);
    procedure btnM4aClick(Sender: TObject);
    procedure btnAcercadeClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Actualizar1Click(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure SearchBox1Click(Sender: TObject);
    procedure actSalirExecute(Sender: TObject);
    procedure actLayoutExecute(Sender: TObject);
    procedure Movimientos1Click(Sender: TObject);
    procedure Dependencias1Click(Sender: TObject);
    procedure Empleados1Click(Sender: TObject);
    procedure Aclaraciones1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    nummodulo: Integer;

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses ufrmacercade, udmDatos, ufunciones, ufrmadminusuarios,
  FireDAC.Comp.Client;

{$R *.dfm}

procedure TfrmPrincipal.FormActivate(Sender: TObject);
var
  habilitado: Boolean;
  i: Integer;

begin
  { Habilitar Botones }
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TBitBtn) then
      if TBitBtn(Components[i]).Tag <> 0 then
        TBitBtn(Components[i]).Enabled := fHabilitabtn(ufunciones.idusuario,
          TBitBtn(Components[i]).Tag);
  StatusBar.Panels[1].Text := 'Usuario activo [' + ufunciones.usuario + ']';
  StatusBar.Panels[3].Text := 'Conectado al Servidor [' +
    ufunciones.servidor + ']';
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;

begin
  { Cierra cualquier formulario que este activo para que no marque error al cerrar la ventana principal }
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i].Active then
      Screen.Forms[i].Close;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  ProgressBarStyle: Integer;

begin
  Application.HelpFile := ExtractFilePath(Application.ExeName) +
    'ayuda\ayuda.chm';
  SV.CloseStyle := TSplitViewCloseStyle(1);
  frmPrincipal.nummodulo := 0;
  StatusBar.Panels[2].Style := psOwnerDraw;
  ProgressBar.Parent := StatusBar;
  ProgressBarStyle := GetWindowLong(ProgressBar.Handle, GWL_EXSTYLE);
  ProgressBarStyle := ProgressBarStyle - WS_EX_STATICEDGE;
  SetWindowLong(ProgressBar.Handle, GWL_EXSTYLE, ProgressBarStyle);
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F1:
      begin
        HtmlHelp(0, Application.HelpFile, HH_DISPLAY_TOC, 0);
      end;
  end;
end;

procedure TfrmPrincipal.Aclaraciones1Click(Sender: TObject);
begin
  chkVentana(264);
end;

procedure TfrmPrincipal.actHomeExecute(Sender: TObject);
begin
//   SV.Close;
end;

procedure TfrmPrincipal.actLayoutExecute(Sender: TObject);
begin
  chkVentana(9);
  SV.Close;
end;

procedure TfrmPrincipal.actSalirExecute(Sender: TObject);
begin
  If Application.MessageBox('Desea salir del sistema?', 'Salir del sistema',
    mb_YesNo + MB_ICONQUESTION) = ID_Yes Then
    frmprincipal.Close;
end;

procedure TfrmPrincipal.Actualizar1Click(Sender: TObject);
begin
  chkVentana(261);
end;

procedure TfrmPrincipal.AdministracindeusuariosClick(Sender: TObject);
begin
  frmadminusuarios := Tfrmadminusuarios.Create(Self);
  frmadminusuarios.ShowModal;
end;

procedure TfrmPrincipal.Ayuda1Click(Sender: TObject);
begin
  HtmlHelp(0, Application.HelpFile, HH_DISPLAY_TOC, 0);
end;

procedure TfrmPrincipal.btnM4aClick(Sender: TObject);
begin
  HtmlHelp(0, Application.HelpFile, HH_DISPLAY_TOC, 0);
end;

procedure TfrmPrincipal.BitBtn2Click(Sender: TObject);
begin
  chkVentana(3);
end;

procedure TfrmPrincipal.btnM1aClick(Sender: TObject);
begin
  chkVentana(2);
end;

procedure TfrmPrincipal.btnM2aClick(Sender: TObject);
begin
  chkVentana(6);
end;

procedure TfrmPrincipal.btnSalirClick(Sender: TObject);
begin
  If Application.MessageBox('Desea salir del sistema?', 'Salir del sistema',
    mb_YesNo + MB_ICONQUESTION) = ID_Yes Then
    Close;
end;

procedure TfrmPrincipal.Dependencias1Click(Sender: TObject);
begin
  chkVentana(12);
end;

procedure TfrmPrincipal.Empleados1Click(Sender: TObject);
begin
  chkVentana(13);
end;

procedure TfrmPrincipal.btnM3bClick(Sender: TObject);
begin
  chkVentana(10);
end;

procedure TfrmPrincipal.btnAcercadeClick(Sender: TObject);
begin
  if not Assigned(frmAcercade) then
    frmAcercade := TfrmAcercade.Create(nil)
  else
    frmAcercade.ShowModal;
end;

procedure TfrmPrincipal.btnM3aClick(Sender: TObject);
begin
  chkVentana(9);
end;

procedure TfrmPrincipal.btnM2bClick(Sender: TObject);
begin
  chkVentana(7);
end;

procedure TfrmPrincipal.FileExit1Execute(Sender: TObject);
begin
  If Application.MessageBox('Desea salir del sistema?', 'Salir del sistema',
    mb_YesNo + MB_ICONQUESTION) = ID_Yes Then
    Close;
end;

procedure TfrmPrincipal.HelpAbout1Execute(Sender: TObject);
begin
  frmAcercade.ShowModal;
end;

procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
begin
  if SV.Opened then
    SV.Close
  else
    SV.Open;
end;

procedure TfrmPrincipal.Movimientos1Click(Sender: TObject);
begin
  chkVentana(11);
end;

procedure TfrmPrincipal.SalirClick(Sender: TObject);
begin
  If Application.MessageBox('Desea salir del sistema?', 'Salir del sistema',
    mb_YesNo + MB_ICONQUESTION) = ID_Yes Then
    Close;
end;

procedure TfrmPrincipal.SearchBox1Click(Sender: TObject);
begin
  ShowMessage('Prueba');
end;

procedure TfrmPrincipal.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[2] then
    with ProgressBar do
    begin
      Top := Rect.Top;
      Left := Rect.Left;
      Width := Rect.Right - Rect.Left - 15;
      Height := Rect.Bottom - Rect.Top;
    end
end;

end.
