object frmMainForm: TfrmMainForm
  Left = 217
  Top = 159
  Width = 412
  Height = 276
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #26102#38047#27979#35797#31243#24207'-'#32447#31243#25511#21046
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object bvl1: TBevel
    Left = 136
    Top = 13
    Width = 2
    Height = 121
    Style = bsRaised
  end
  object bvl2: TBevel
    Left = 2
    Top = 132
    Width = 135
    Height = 2
    Style = bsRaised
  end
  object rg_Style: TRadioGroup
    Left = 8
    Top = 144
    Width = 129
    Height = 89
    Caption = #26174#31034#27169#24335
    Ctl3D = True
    ItemIndex = 0
    Items.Strings = (
      #25351#38024#22411#26102#38047
      #25968#23383#22411#26102#38047)
    ParentCtl3D = False
    TabOrder = 0
    OnClick = rg_StyleClick
  end
  object grp_Set: TGroupBox
    Left = 152
    Top = 8
    Width = 241
    Height = 225
    Caption = #23646#24615#35774#32622
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    object lbl_Left: TLabel
      Left = 16
      Top = 32
      Width = 48
      Height = 13
      Caption = #24038#31471#28857#65306
    end
    object lbl_Top: TLabel
      Left = 16
      Top = 64
      Width = 48
      Height = 13
      Caption = #39030#31471#28857#65306
    end
    object lbl_Radius: TLabel
      Left = 29
      Top = 96
      Width = 36
      Height = 13
      Caption = #21322#24452#65306
    end
    object lbl_Hour: TLabel
      Left = 143
      Top = 32
      Width = 24
      Height = 13
      Caption = #26102#65306
    end
    object lbl_Minute: TLabel
      Left = 143
      Top = 64
      Width = 24
      Height = 13
      Caption = #20998#65306
    end
    object lbl_Second: TLabel
      Left = 143
      Top = 96
      Width = 24
      Height = 13
      Caption = #31186#65306
    end
    object lbl7: TLabel
      Left = 45
      Top = 194
      Width = 60
      Height = 13
      Caption = #36816#34892#29366#24577#65306
    end
    object lbl_Size: TLabel
      Left = 29
      Top = 122
      Width = 36
      Height = 13
      Caption = #22823#23567#65306
    end
    object lbl_Colour: TLabel
      Left = 5
      Top = 148
      Width = 60
      Height = 13
      Caption = #39068#33394#35774#32622#65306
    end
    object se_Left: TSpinEdit
      Left = 72
      Top = 25
      Width = 41
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 15
      OnChange = se_LeftChange
    end
    object se_Top: TSpinEdit
      Left = 72
      Top = 57
      Width = 41
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 15
      OnChange = se_LeftChange
    end
    object se_Radius: TSpinEdit
      Left = 72
      Top = 90
      Width = 41
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 50
      OnChange = se_LeftChange
    end
    object se_Hour: TSpinEdit
      Left = 168
      Top = 25
      Width = 41
      Height = 22
      MaxValue = 23
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = se_SecondChange
    end
    object se_Minute: TSpinEdit
      Left = 168
      Top = 57
      Width = 41
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 4
      Value = 0
      OnChange = se_SecondChange
    end
    object se_Second: TSpinEdit
      Left = 168
      Top = 90
      Width = 41
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 5
      Value = 0
      OnChange = se_SecondChange
    end
    object btn_Run: TBitBtn
      Left = 117
      Top = 186
      Width = 75
      Height = 25
      Caption = #21551#29992
      TabOrder = 6
      OnClick = btn_RunClick
      Kind = bkOK
    end
    object se_Size: TSpinEdit
      Left = 72
      Top = 120
      Width = 41
      Height = 22
      MaxValue = 50
      MinValue = 1
      TabOrder = 7
      Value = 10
      OnChange = se_LeftChange
    end
    object btn_HourColour: TBitBtn
      Left = 75
      Top = 144
      Width = 41
      Height = 25
      Caption = #26102#38024
      TabOrder = 8
      OnClick = btn_HourColourClick
    end
    object btn_MinuteColour: TBitBtn
      Left = 129
      Top = 144
      Width = 41
      Height = 25
      Caption = #20998#38024
      TabOrder = 9
      OnClick = btn_MinuteColourClick
    end
    object btn_SecondColour: TBitBtn
      Left = 182
      Top = 144
      Width = 41
      Height = 25
      Caption = #31186#38024
      TabOrder = 10
      OnClick = btn_SecondColourClick
    end
  end
  object dlgColor: TColorDialog
    Left = 272
  end
end
