object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Dimension'
  ClientHeight = 222
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 174
    Caption = ' Image '
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 41
      Width = 227
      Height = 15
      Caption = 'Cant find *.stub file for Image Dimensions !'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 62
      Width = 185
      Height = 15
      Caption = 'Type Picture Height / Width Values.'
    end
    object Label3: TLabel
      Left = 30
      Top = 102
      Width = 78
      Height = 15
      Caption = 'Image Height :'
    end
    object Label4: TLabel
      Left = 34
      Top = 132
      Width = 74
      Height = 15
      Caption = 'Image Width :'
    end
    object Edit1: TEdit
      Left = 114
      Top = 99
      Width = 95
      Height = 23
      TabOrder = 0
      Text = '256'
      OnKeyPress = Edit1KeyPress
    end
    object Edit2: TEdit
      Left = 114
      Top = 128
      Width = 95
      Height = 23
      TabOrder = 1
      Text = '256'
      OnKeyPress = Edit2KeyPress
    end
  end
  object Button1: TButton
    Left = 194
    Top = 188
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 1
    OnClick = Button1Click
  end
end
