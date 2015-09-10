object FrmType: TFrmType
  Left = 422
  Top = 361
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #20998#31867#22686#21152
  ClientHeight = 171
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 130
    Width = 429
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BtnAdd: TButton
      Left = 112
      Top = 8
      Width = 75
      Height = 25
      Caption = #30830#23450
      TabOrder = 0
      OnClick = BtnAddClick
    end
    object BtnCancel: TButton
      Left = 248
      Top = 8
      Width = 75
      Height = 25
      Caption = #36864#20986
      TabOrder = 1
      OnClick = BtnCancelClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 429
    Height = 130
    Align = alClient
    TabOrder = 0
    object lblTypeName: TLabel
      Left = 88
      Top = 51
      Width = 65
      Height = 13
      AutoSize = False
      Caption = #20998#31867#21517#31216
    end
    object EdtTypeName: TEdit
      Left = 172
      Top = 48
      Width = 121
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
    end
  end
end
