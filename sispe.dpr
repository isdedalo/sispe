program sispe;

uses
  Forms,
  ufrmlogin in 'ufrmlogin.pas' {frmlogin},
  ufrmprincipal in 'ufrmprincipal.pas' {frmPrincipal},
  ufunciones in 'ufunciones.pas',
  udmDatos in 'udmDatos.pas' {dmDatos: TDataModule},
  ufrmadminusuarios in 'ufrmadminusuarios.pas' {frmadminusuarios},
  ufrmimportar in 'ufrmimportar.pas' {frmImportar},
  ufrmacercade in 'ufrmacercade.pas' {frmAcercade},
  ufrmcmov in 'ufrmcmov.pas' {frmcmov},
  ufrmcdep in 'ufrmcdep.pas' {frmcdep},
  ufrmcemp in 'ufrmcemp.pas' {frmcemp},
  ufrmactualiza in 'ufrmactualiza.pas' {frmactualiza},
  ufuncsispe in 'ufuncsispe.pas',
  ufrmexpedientes_ph in 'prestamos_hipotecarios\ufrmexpedientes_ph.pas' {frmexpediente_ph},
  ufrmaclaraciones in 'ufrmaclaraciones.pas' {frmAclaraciones},
  ufrmempleados in 'ufrmempleados.pas' {frmempleados};

{$R *.RES}

begin
  if Tfrmlogin.Execute then
  begin
    Application.Initialize;
    Application.Title := 'OFICINA DE PENSIONES - Sistema de Pensiones';
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmDatos, dmDatos);
  Application.CreateForm(Tfrmexpediente_ph, frmexpediente_ph);
  ufunciones.idusuario := ufrmlogin.idusuario;
    ufunciones.usuario := ufrmlogin.usuario;
    ufunciones.servidor := ufrmlogin.servidor;
    Application.Run;
  end;
end.
