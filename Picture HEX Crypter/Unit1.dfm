object Form1: TForm1
  Left = 166
  Top = 200
  Caption = 'Picture HEX Crypter'
  ClientHeight = 540
  ClientWidth = 866
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 438
    Top = 55
    Width = 5
    Height = 428
    ExplicitLeft = 414
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 866
    Height = 55
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitWidth = 862
    object Label1: TLabel
      Left = 11
      Top = 7
      Width = 249
      Height = 39
      Caption = 'Picture HEX Crypter'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Impact'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 483
    Width = 866
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    ExplicitTop = 482
    ExplicitWidth = 862
    DesignSize = (
      866
      38)
    object Label2: TLabel
      Left = 341
      Top = 14
      Width = 26
      Height = 13
      Caption = 'Size :'
    end
    object Button2: TButton
      Left = 11
      Top = 6
      Width = 55
      Height = 25
      Caption = 'HEX'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 72
      Top = 6
      Width = 55
      Height = 25
      Caption = 'Save'
      TabOrder = 1
      TabStop = False
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 799
      Top = 7
      Width = 55
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Picture'
      TabOrder = 2
      TabStop = False
      OnClick = Button3Click
      ExplicitLeft = 795
    end
    object Button4: TButton
      Left = 444
      Top = 7
      Width = 55
      Height = 25
      Caption = 'Calculate'
      TabOrder = 3
      TabStop = False
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 738
      Top = 7
      Width = 55
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save'
      TabOrder = 4
      TabStop = False
      OnClick = Button5Click
      ExplicitLeft = 734
    end
    object CheckBox1: TCheckBox
      Left = 289
      Top = 11
      Width = 42
      Height = 17
      TabStop = False
      Caption = 'Edit'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = CheckBox1Click
    end
    object Button6: TButton
      Left = 133
      Top = 7
      Width = 55
      Height = 25
      Caption = 'Calculate'
      TabOrder = 6
      TabStop = False
      OnClick = Button6Click
    end
    object CheckBox2: TCheckBox
      Left = 201
      Top = 11
      Width = 76
      Height = 17
      TabStop = False
      Caption = 'Automatixc'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object Button7: TButton
      Left = 677
      Top = 6
      Width = 55
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Clear'
      TabOrder = 8
      TabStop = False
      OnClick = Button7Click
    end
    object SpinEdit1: TSpinEdit
      Left = 375
      Top = 9
      Width = 50
      Height = 22
      TabStop = False
      Ctl3D = True
      MaxValue = 72
      MinValue = 1
      ParentCtl3D = False
      TabOrder = 9
      Value = 7
      OnChange = SpinEdit1Change
    end
    object CheckBox3: TCheckBox
      Left = 514
      Top = 11
      Width = 46
      Height = 17
      TabStop = False
      Caption = 'XOR'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 521
    Width = 866
    Height = 19
    Panels = <
      item
        Text = 'Picture :'
        Width = 50
      end
      item
        Width = 200
      end
      item
        Text = 'Size :'
        Width = 35
      end
      item
        Text = '0 bytes'
        Width = 120
      end
      item
        Text = 'Dimensions :'
        Width = 75
      end
      item
        Text = 'X0-Y0'
        Width = 100
      end
      item
        Text = 'Bit :'
        Width = 30
      end
      item
        Text = '0'
        Width = 30
      end
      item
        Text = 'Used :'
        Width = 45
      end
      item
        Text = '0'
        Width = 50
      end>
    ExplicitTop = 520
    ExplicitWidth = 862
  end
  object Panel3: TPanel
    Left = 0
    Top = 55
    Width = 438
    Height = 428
    Align = alLeft
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    ExplicitHeight = 427
    object Memo1: TMemo
      Left = 0
      Top = 17
      Width = 438
      Height = 411
      TabStop = False
      Align = alClient
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = Memo1Change
      ExplicitHeight = 410
    end
    object HeaderControl1: THeaderControl
      Left = 0
      Top = 0
      Width = 438
      Height = 17
      Sections = <
        item
          Alignment = taCenter
          ImageIndex = -1
          Text = 'HEX Lines :'
          Width = 70
        end
        item
          ImageIndex = -1
          Text = '0'
          Width = 100
        end>
    end
  end
  object Panel4: TPanel
    Left = 443
    Top = 55
    Width = 423
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    ExplicitWidth = 419
    ExplicitHeight = 427
    object ScrollBox1: TScrollBox
      Left = 0
      Top = 17
      Width = 423
      Height = 411
      HorzScrollBar.Smooth = True
      HorzScrollBar.Tracking = True
      VertScrollBar.Smooth = True
      VertScrollBar.Tracking = True
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      ExplicitWidth = 419
      ExplicitHeight = 410
      object Image2: TImage
        Left = 6
        Top = 6
        Width = 155
        Height = 186
        AutoSize = True
      end
    end
    object HeaderControl2: THeaderControl
      Left = 0
      Top = 0
      Width = 423
      Height = 17
      Sections = <
        item
          ImageIndex = -1
          Text = 'Image :'
          Width = 50
        end
        item
          ImageIndex = -1
          Width = 300
        end>
      ExplicitWidth = 419
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'Bitmap (*.BMP)|*.bmp|Portable Network Graphic )*.PNG)|*.png|Jpg/' +
      'Jpeg (*.JPG; JPEG)|*.jpg; *-jpeg|Graphics Interchange Format (*.' +
      'GIF)|*.gif'
    Left = 478
    Top = 65535
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Ini File (*.INI)|*.ini'
    Left = 395
    Top = 2
  end
  object OpenDialog2: TOpenDialog
    Left = 554
    Top = 1
  end
  object SaveDialog2: TSaveDialog
    Filter = 
      'Bitmap (*.BMP)|*.bmp|Jpg/Jpeg (*.JPG; *.JPEG)|*.jpg|Portable Net' +
      'work Graphic (*.PNG)|*.png|Graphics Interchange Format (*.GIF)|*' +
      '.gif'
    Left = 635
    Top = 2
  end
end
