object frmAclaraciones: TfrmAclaraciones
  Left = 0
  Top = 0
  Caption = 'Aclaraciones'
  ClientHeight = 638
  ClientWidth = 1202
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFaltantes: TPanel
    Left = 0
    Top = 0
    Width = 1202
    Height = 23
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' Fondo de Pensiones/Diskettes/Aclaraciones'
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
  end
  object pnlPinder: TPanel
    Left = 1064
    Top = 136
    Width = 138
    Height = 408
    Align = alRight
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    BorderWidth = 1
    Color = 14674156
    Ctl3D = False
    ParentBiDiMode = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 1
    object btnProcesar: TSpeedButton
      Left = 8
      Top = 54
      Width = 120
      Height = 40
      Hint = 'Agregar un Nuevo Registro'
      Caption = 'Procesar Registros'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Myriad Pro'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnProcesarClick
    end
    object bNavegador: TDBNavigator
      Left = 8
      Top = 0
      Width = 120
      Height = 50
      DataSource = dmDatos.dsUsuarios
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Hints.Strings = (
        'Primer registro'
        'Anterior registro'
        'Siguiente registro'
        'Ultimo registro'
        'Insert record'
        'Delete record'
        'Edit record'
        'Post edit'
        'Cancel edit'
        'Refresh data'
        'Apply updates'
        'Cancel updates')
      TabOrder = 0
    end
    object btnCerrarmod: TBitBtn
      Left = 8
      Top = 326
      Width = 120
      Height = 40
      Hint = 'Cerrar M'#243'dulo actual'
      Caption = 'Cerrar M'#243'dulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Myriad Pro'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCerrarmodClick
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 136
    Width = 1064
    Height = 408
    Align = alClient
    Ctl3D = False
    DataSource = dmDatos.dsSqlLite
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGridCellClick
    OnKeyPress = DBGridKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'mca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'MCA'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'rfc'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'RFC'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nombre'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'NOMBRE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 300
        Visible = True
      end
      item
        Alignment = taCenter
        Color = clBlack
        Expanded = False
        FieldName = 'aclaracion'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'ACLARACION'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end>
  end
  object PnlTop: TPanel
    Left = 0
    Top = 23
    Width = 1202
    Height = 113
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    OnResize = PnlTopResize
    object etiqueta2: TPanel
      Left = 338
      Top = 38
      Width = 393
      Height = 17
      BevelOuter = bvNone
      Caption = 'A LA BANDEJA DE ENTRADA O SE FUSIONAR'#193'N'
      Color = clWhite
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object etiqueta1: TPanel
      Left = 274
      Top = 13
      Width = 545
      Height = 19
      BevelOuter = bvNone
      Caption = 'MARQUE EL CAMPO "MCA" SOLO LOS CAMPOS QUE SERAN AGREGADOS'
      Color = clWhite
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
    end
    object txtRfc: TEdit
      Left = 40
      Top = 86
      Width = 137
      Height = 21
      AutoSize = False
      TabOrder = 2
      OnChange = txtRfcChange
    end
    object Panel6: TPanel
      Left = 4
      Top = 86
      Width = 30
      Height = 11
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'RFC:'
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
      TabOrder = 3
    end
    object txtNombre: TEdit
      Left = 288
      Top = 86
      Width = 257
      Height = 21
      TabOrder = 4
      OnChange = txtNombreChange
    end
    object Panel7: TPanel
      Left = 228
      Top = 88
      Width = 54
      Height = 11
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'NOMBRE:'
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
      TabOrder = 5
    end
    object Panel8: TPanel
      Left = 4
      Top = 62
      Width = 85
      Height = 11
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'BUSCAR POR:'
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
      TabOrder = 6
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 544
    Width = 1202
    Height = 94
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    object Panel2: TPanel
      Left = 4
      Top = 14
      Width = 61
      Height = 11
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'MARCAS:'
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
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 71
      Top = 14
      Width = 130
      Height = 11
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'N -> REGISTRO NUEVO'
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
    object Panel4: TPanel
      Left = 71
      Top = 32
      Width = 450
      Height = 11
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'I -> REGISTRO INCORRECTO, AGREGAR EN ACLARACI'#211'N EL RFC CORRECTO.'
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
      TabOrder = 2
    end
    object Panel5: TPanel
      Left = 71
      Top = 48
      Width = 570
      Height = 11
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 
        'C -> RFC CORRECTO, AGREGAR EN ACLARACI'#211'N EL RFC INCORRECTO PARA ' +
        'SU FUSI'#211'N AUTOM'#193'TICA.'
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
      TabOrder = 3
    end
  end
end
