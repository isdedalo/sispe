object frmfecha: Tfrmfecha
  Left = 0
  Top = 0
  Caption = 'frmfecha'
  ClientHeight = 160
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFaltantes: TPanel
    Left = 0
    Top = 0
    Width = 335
    Height = 23
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'Fecha de Registro de los Archivos a procesar'
    Color = 14674156
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = -12413445
    Font.Height = -13
    Font.Name = 'Myriad Pro'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 338
  end
  object Panel2: TPanel
    Left = 3
    Top = 30
    Width = 134
    Height = 11
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'SELECCIONE LA FECHA:'
    Color = clWhite
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
  end
  object dtFregistro: TDateTimePicker
    Left = 143
    Top = 29
    Width = 186
    Height = 21
    Date = 42613.488908113430000000
    Time = 42613.488908113430000000
    TabOrder = 2
  end
  object btnAceptar: TButton
    Left = 172
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 3
  end
  object btnCancelar: TButton
    Left = 254
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btnCancelarClick
  end
end
