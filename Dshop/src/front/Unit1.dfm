object Pass: TPass
  Left = 553
  Top = 335
  BorderStyle = bsNone
  Caption = 'Pass'
  ClientHeight = 157
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 32
    Width = 250
    Height = 125
    Align = alClient
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 39
      Top = 19
      Width = 42
      Height = 12
      Caption = #29992#25143#21517':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 39
      Top = 50
      Width = 42
      Height = 12
      Caption = #23494#12288#30721':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 43
      Top = 83
      Width = 76
      Height = 26
      Caption = #30331#12288#24405
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 126
      Top = 83
      Width = 76
      Height = 26
      Caption = 'Esc.'#36864#12288#20986
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton2Click
    end
    object Edit1: TEdit
      Left = 83
      Top = 16
      Width = 121
      Height = 18
      BevelKind = bkSoft
      BevelOuter = bvNone
      Color = clBlack
      Ctl3D = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
    object Edit2: TEdit
      Left = 83
      Top = 47
      Width = 121
      Height = 20
      BevelKind = bkSoft
      BevelOuter = bvNone
      Color = clBlack
      Ctl3D = False
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Wingdings'
      Font.Style = []
      MaxLength = 12
      ParentCtl3D = False
      ParentFont = False
      PasswordChar = 'v'
      TabOrder = 1
      OnKeyPress = Edit2KeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    Caption = #36523#12288#20221#12288#39564#12288#35777
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = #20223#23435'_GB2312'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 8
    Top = 8
  end
end