object FrmEdit: TFrmEdit
  Left = 812
  Top = 208
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #20449#24687#32534#36753
  ClientHeight = 349
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottom: TPanel
    Left = 0
    Top = 292
    Width = 521
    Height = 57
    Align = alBottom
    TabOrder = 1
    object BtnNew: TButton
      Left = 164
      Top = 16
      Width = 75
      Height = 25
      Caption = #30830#23450
      TabOrder = 0
      OnClick = BtnNewClick
    end
    object BtnCancel: TButton
      Left = 272
      Top = 16
      Width = 75
      Height = 25
      Caption = #21462#28040
      TabOrder = 1
      OnClick = BtnCancelClick
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 521
    Height = 292
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 99
      Width = 40
      Height = 13
      AutoSize = False
      Caption = #21517#31216
    end
    object Label2: TLabel
      Left = 48
      Top = 152
      Width = 33
      Height = 13
      AutoSize = False
      Caption = #20998#31867
    end
    object Label3: TLabel
      Left = 256
      Top = 99
      Width = 29
      Height = 13
      AutoSize = False
      Caption = #20135#22320
    end
    object Label4: TLabel
      Left = 256
      Top = 152
      Width = 29
      Height = 13
      AutoSize = False
      Caption = #21333#20215
    end
    object lblUnit: TLabel
      Left = 456
      Top = 152
      Width = 37
      Height = 13
      AutoSize = False
      Caption = #20803'/Kg'
    end
    object EdtName: TEdit
      Left = 94
      Top = 96
      Width = 145
      Height = 21
      AutoSize = False
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
    end
    object ComboBoxClassity: TComboBox
      Left = 94
      Top = 149
      Width = 145
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 13
      TabOrder = 2
    end
    object EditArea: TEdit
      Left = 296
      Top = 96
      Width = 193
      Height = 21
      AutoSize = False
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object EdtPrice: TEdit
      Left = 296
      Top = 149
      Width = 154
      Height = 21
      AutoSize = False
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
      OnKeyPress = EdtPriceKeyPress
    end
  end
end
