inherited FrmAberturaCaixa: TFrmAberturaCaixa
  Caption = 'ABERTURA DE CAIXA'
  ClientWidth = 534
  ExplicitWidth = 550
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 534
    Height = 343
    Align = alClient
    Color = 16514043
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 32
      Width = 411
      Height = 19
      Caption = 'Informe os valores dispon'#237'veis para iniciar suas opera'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 208
      Top = 192
      Width = 110
      Height = 13
      Caption = 'DISPON'#205'VEL EM CAIXA'
    end
    object CurrencyEdit1: TCurrencyEdit
      Left = 152
      Top = 157
      Width = 217
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Panel2: TPanel
      Tag = 1
      Left = 120
      Top = 232
      Width = 297
      Height = 41
      Caption = 'CONFIRMAR ABERTURA DO CAIXA'
      Color = 5614080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 295
        Height = 39
        Align = alClient
        OnMouseDown = ImgMouseDown
        OnMouseLeave = ImgMouseLeave
        OnMouseMove = ImgMouseMove
        ExplicitLeft = 96
        ExplicitTop = -32
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
end
