object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 355
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image: TImage
    Left = 32
    Top = 24
    Width = 449
    Height = 320
  end
  object MyPicture: TImage
    Left = 72
    Top = 89
    Width = 313
    Height = 153
  end
  object BnAddNum: TButton
    Left = 487
    Top = 55
    Width = 92
    Height = 25
    Caption = 'Add (number)'
    TabOrder = 0
    OnClick = BnAddNumClick
  end
  object BnCreate: TButton
    Left = 487
    Top = 24
    Width = 92
    Height = 25
    Caption = 'Create'
    TabOrder = 1
    OnClick = BnCreateClick
  end
  object BnDeteleNum: TButton
    Left = 487
    Top = 86
    Width = 92
    Height = 25
    Caption = 'Delete (number)'
    TabOrder = 2
    OnClick = BnDeteleNumClick
  end
  object MemoTemp: TMemo
    Left = 487
    Top = 294
    Width = 81
    Height = 53
    Lines.Strings = (
      'MemoTemp')
    TabOrder = 3
  end
  object BnLeftRootRight: TButton
    Left = 487
    Top = 117
    Width = 92
    Height = 25
    Caption = 'LeftRootRight'
    TabOrder = 4
    OnClick = BnLeftRootRightClick
  end
  object BnTask: TButton
    Left = 389
    Top = 322
    Width = 92
    Height = 25
    Caption = 'Task'
    TabOrder = 5
    OnClick = BnTaskClick
  end
  object BnLeftRightRoot: TButton
    Left = 487
    Top = 179
    Width = 92
    Height = 25
    Caption = 'LeftRightRoot'
    TabOrder = 6
    OnClick = BnLeftRightRootClick
  end
  object BnRootLeftRight: TButton
    Left = 487
    Top = 148
    Width = 92
    Height = 25
    Caption = 'RootLeftRight'
    TabOrder = 7
    OnClick = BnRootLeftRightClick
  end
  object BnRightSew: TButton
    Left = 487
    Top = 210
    Width = 92
    Height = 25
    Caption = 'RightSew'
    TabOrder = 8
    OnClick = BnRightSewClick
  end
  object OpenD: TOpenDialog
    Left = 24
    Top = 304
  end
end
