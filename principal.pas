unit principal;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.Menus, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ImgList, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin;

type
  TSDIAppForm = class(TForm)
    StatusBar: TStatusBar;
    OpenDialog: TOpenDialog;
    menu: TMainMenu;
    Credenciales1: TMenuItem;
    Lectraydestruccin1: TMenuItem;
    Importarregistros3: TMenuItem;
    Consultaryvalidar1: TMenuItem;
    Lecturayresguardo1: TMenuItem;
    Importarregistros4: TMenuItem;
    Consultar1: TMenuItem;
    N3: TMenuItem;
    Exportarinformacin1: TMenuItem;
    N1: TMenuItem;
    Salir2: TMenuItem;
    Consultas1: TMenuItem;
    HistorialdeCaja1: TMenuItem;
    Estadsticas1: TMenuItem;
    Grficasdepolpularidad1: TMenuItem;
    Herramientas1: TMenuItem;
    Cambiodeusuario1: TMenuItem;
    N15: TMenuItem;
    Administracindeusuarios1: TMenuItem;
    Cambiarpassword1: TMenuItem;
    N16: TMenuItem;
    Apariencia1: TMenuItem;
    N17: TMenuItem;
    Utileriasdelabasededatos1: TMenuItem;
    LimpiarHistorial1: TMenuItem;
    N18: TMenuItem;
    Opciones1: TMenuItem;
    Help1: TMenuItem;
    Ayuda1: TMenuItem;
    N19: TMenuItem;
    RegistrarComanda1: TMenuItem;
    N20: TMenuItem;
    HelpAboutItem: TMenuItem;
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
    ImageList1: TImageList;
    ToolBar2: TToolBar;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure Salir2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SDIAppForm: TSDIAppForm;

implementation


{$R *.dfm}

procedure TSDIAppForm.FileNew1Execute(Sender: TObject);
begin
  { Do nothing }
end;

procedure TSDIAppForm.Salir2Click(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

end.
