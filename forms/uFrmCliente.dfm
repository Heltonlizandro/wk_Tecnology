inherited FrmCliente: TFrmCliente
  BorderStyle = bsNone
  Caption = 'FrmCliente'
  ClientHeight = 382
  ClientWidth = 605
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 605
    Height = 382
    Align = alClient
    BorderStyle = bsSingle
    Color = 16514043
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 599
      Height = 376
      ActivePage = TabSheet2
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MultiLine = True
      ParentFont = False
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = ' - BUSCAR - '
        object Label4: TLabel
          Left = 16
          Top = 8
          Width = 165
          Height = 19
          Caption = 'LOCALIZE PELO NOME'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9803157
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 16
          Top = 72
          Width = 191
          Height = 19
          Caption = 'LOCALIZE PELO CPF/CNPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9803157
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Panel3: TPanel
          Left = 0
          Top = 281
          Width = 591
          Height = 61
          Align = alBottom
          Color = 15461355
          ParentBackground = False
          TabOrder = 0
          object Panel4: TPanel
            Tag = 1
            Left = 16
            Top = 13
            Width = 121
            Height = 34
            Caption = 'OK'
            Color = 5614080
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            object Image3: TImage
              Left = 1
              Top = 1
              Width = 119
              Height = 32
              Align = alClient
              OnMouseDown = ImgMouseDown
              OnMouseLeave = ImgMouseLeave
              OnMouseMove = ImgMouseMove
              ExplicitLeft = 16
              ExplicitTop = 16
              ExplicitWidth = 105
              ExplicitHeight = 105
            end
          end
          object Panel5: TPanel
            Tag = 3
            Left = 456
            Top = 13
            Width = 121
            Height = 34
            Caption = 'CANCELAR'
            Color = 1782223
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            object Image4: TImage
              Left = 1
              Top = 1
              Width = 119
              Height = 32
              Align = alClient
              OnClick = Image4Click
              OnMouseDown = ImgMouseDown
              OnMouseLeave = ImgMouseLeave
              OnMouseMove = ImgMouseMove
              ExplicitLeft = 40
              ExplicitTop = 16
              ExplicitWidth = 105
              ExplicitHeight = 105
            end
          end
        end
        object comboPesqProd: TComboBox
          Left = 16
          Top = 32
          Width = 473
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object ComboBox1: TComboBox
          Left = 16
          Top = 96
          Width = 273
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object TabSheet2: TTabSheet
        Caption = '  - NOVO CLIENTE - '
        ImageIndex = 1
        object Label2: TLabel
          Left = 24
          Top = 16
          Width = 48
          Height = 19
          Caption = 'NOME'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9803157
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 24
          Top = 80
          Width = 111
          Height = 19
          Caption = 'TIPO PESSOA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9803157
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 24
          Top = 160
          Width = 82
          Height = 19
          Caption = 'CPF/CNPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9803157
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 24
          Top = 224
          Width = 59
          Height = 19
          Caption = 'E-MAIL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 9803157
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Panel2: TPanel
          Left = 0
          Top = 281
          Width = 591
          Height = 61
          Align = alBottom
          Color = 15461355
          ParentBackground = False
          TabOrder = 0
          object Panel6: TPanel
            Tag = 1
            Left = 16
            Top = 13
            Width = 121
            Height = 34
            Caption = 'SALVAR'
            Color = 5614080
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            object Image1: TImage
              Left = 1
              Top = 1
              Width = 119
              Height = 32
              Align = alClient
              ExplicitLeft = 16
              ExplicitTop = 16
              ExplicitWidth = 105
              ExplicitHeight = 105
            end
          end
          object Panel7: TPanel
            Tag = 3
            Left = 456
            Top = 13
            Width = 121
            Height = 34
            Caption = 'CANCELAR'
            Color = 1782223
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            object Image2: TImage
              Left = 1
              Top = 1
              Width = 119
              Height = 32
              Align = alClient
              OnClick = Image2Click
              ExplicitLeft = 40
              ExplicitTop = 16
              ExplicitWidth = 105
              ExplicitHeight = 105
            end
          end
        end
        object Edit1: TEdit
          Left = 24
          Top = 40
          Width = 553
          Height = 27
          TabOrder = 1
        end
        object RadioGroup1: TRadioGroup
          Left = 24
          Top = 105
          Width = 377
          Height = 41
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'F'#205'SICA'
            'JUR'#205'DICA')
          TabOrder = 2
        end
        object Edit2: TEdit
          Left = 24
          Top = 184
          Width = 553
          Height = 27
          TabOrder = 3
        end
        object Edit3: TEdit
          Left = 24
          Top = 248
          Width = 553
          Height = 27
          TabOrder = 4
        end
      end
    end
  end
end
