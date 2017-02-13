unit uselfecha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  Tfrmfecha = class(TForm)
    pnlFaltantes: TPanel;
    Panel2: TPanel;
    dtFregistro: TDateTimePicker;
    btnAceptar: TButton;
    btnCancelar: TButton;
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmfecha: Tfrmfecha;

implementation

{$R *.dfm}

procedure Tfrmfecha.btnCancelarClick(Sender: TObject);
begin
  close;
end;

end.
