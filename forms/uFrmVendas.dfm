inherited FrmVendas: TFrmVendas
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FrmVendas'
  ClientHeight = 458
  ClientWidth = 794
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 794
  ExplicitHeight = 458
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 794
    Height = 458
    Align = alClient
    BorderStyle = bsSingle
    Color = 16514043
    ParentBackground = False
    TabOrder = 0
    object Label5: TLabel
      Left = 48
      Top = 51
      Width = 153
      Height = 19
      Caption = 'C'#211'DIGO PRODUTO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9803157
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 48
      Top = 131
      Width = 112
      Height = 19
      Caption = 'QUANTIDADE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9803157
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 48
      Top = 171
      Width = 146
      Height = 19
      Caption = 'VALOR UNIT'#193'RIO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9803157
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 48
      Top = 211
      Width = 116
      Height = 19
      Caption = 'VALOR TOTAL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9803157
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 48
      Top = 91
      Width = 97
      Height = 19
      Caption = 'DESCRI'#199#195'O'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9803157
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PanelDetalhe: TPanel
      Left = 456
      Top = 1
      Width = 333
      Height = 452
      Align = alRight
      TabOrder = 6
      object Shape1: TShape
        Left = 8
        Top = 8
        Width = 321
        Height = 41
        Brush.Color = 5614080
        Pen.Color = 5614080
      end
      object Label1: TLabel
        Left = 14
        Top = 13
        Width = 50
        Height = 14
        AutoSize = False
        Caption = 'Cliente:'
        Color = 16514043
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16514043
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        OnClick = Label1Click
      end
      object Label3: TLabel
        Left = 16
        Top = 288
        Width = 100
        Height = 13
        Caption = 'TOTAL DO PEDIDO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbNomeCliente: TLabel
        Left = 64
        Top = 13
        Width = 257
        Height = 31
        AutoSize = False
        Color = 16514043
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16514043
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        WordWrap = True
        OnClick = lbNomeClienteClick
      end
      object Label4: TLabel
        Left = 14
        Top = 29
        Width = 123
        Height = 14
        AutoSize = False
        Caption = 'C'#243'digo do Cliente:'
        Color = 16514043
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16514043
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Visible = False
        OnClick = Label4Click
      end
      object PanelTotalGeral: TPanel
        Left = 8
        Top = 304
        Width = 321
        Height = 34
        Caption = '0,0'
        Color = 5614080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object Panel4: TPanel
        Tag = 1
        Left = 8
        Top = 344
        Width = 321
        Height = 34
        Caption = 'GRAVAR PEDIDO'
        Color = 5614080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object ImgFinalizaPedido: TImage
          Left = 1
          Top = 1
          Width = 319
          Height = 32
          Align = alClient
          OnClick = ImgFinalizaPedidoClick
          OnMouseDown = ImgMouseDown
          OnMouseLeave = ImgMouseLeave
          OnMouseMove = ImgMouseMove
          ExplicitLeft = 96
          ExplicitTop = 16
          ExplicitWidth = 105
          ExplicitHeight = 105
        end
      end
      object Panel5: TPanel
        Tag = 3
        Left = 8
        Top = 384
        Width = 97
        Height = 34
        Caption = 'SAIR'
        Color = 1782223
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        object Image4: TImage
          Left = 1
          Top = 1
          Width = 95
          Height = 32
          Align = alClient
          OnClick = Image4Click
          OnMouseDown = ImgMouseDown
          OnMouseLeave = ImgMouseLeave
          OnMouseMove = ImgMouseMove
          ExplicitTop = 3
          ExplicitWidth = 191
        end
      end
      object GridProdutos: TDBGrid
        Left = 8
        Top = 50
        Width = 321
        Height = 231
        BorderStyle = bsNone
        DataSource = dsPedidosCliente
        DrawingStyle = gdsGradient
        Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = GridProdutosKeyDown
        OnKeyPress = GridProdutosKeyPress
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo'
            Width = 39
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'Descri'#231#227'o'
            Width = 113
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANTIDADE'
            Title.Caption = 'Qtd'
            Width = 29
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VLR_UNITARIO'
            Title.Caption = 'vlr Unit'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VLR_TOTAL'
            Visible = True
          end>
      end
      object EdtIdCliente: TEdit
        Left = 136
        Top = 29
        Width = 185
        Height = 18
        Color = 5614080
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16514043
        Font.Height = -8
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        Visible = False
        OnClick = EdtIdClienteClick
      end
      object PanelInsAltCliente: TPanel
        Tag = 3
        Left = 120
        Top = 384
        Width = 209
        Height = 34
        Caption = 'Inserir/Alterar Cliente'
        Color = 1782223
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
        object ImgInsAltCliente: TImage
          Left = 1
          Top = 1
          Width = 207
          Height = 32
          Align = alClient
          OnClick = ImgInsAltClienteClick
          OnMouseDown = ImgMouseDown
          OnMouseLeave = ImgMouseLeave
          OnMouseMove = ImgMouseMove
          ExplicitTop = 3
          ExplicitWidth = 191
        end
      end
    end
    object EdtCodigoProduto: TEdit
      Left = 208
      Top = 48
      Width = 214
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = EdtCodigoProdutoChange
      OnExit = EdtCodigoProdutoExit
    end
    object EdtDescricao: TEdit
      Left = 208
      Top = 88
      Width = 214
      Height = 27
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object EdtQtdProduto: TEdit
      Left = 208
      Top = 128
      Width = 214
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnExit = EdtQtdProdutoExit
    end
    object EdtVlrUnitario: TEdit
      Left = 208
      Top = 168
      Width = 214
      Height = 27
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnExit = EdtVlrUnitarioExit
    end
    object EdtVlrTotal: TEdit
      Left = 208
      Top = 208
      Width = 214
      Height = 27
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object btnConfirmarPedido: TBitBtn
      Left = 208
      Top = 248
      Width = 214
      Height = 34
      Caption = 'Confirmar Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnConfirmarPedidoClick
    end
    object Panel2: TPanel
      Left = 16
      Top = 345
      Width = 406
      Height = 96
      TabOrder = 7
      object Label8: TLabel
        Left = 200
        Top = 32
        Width = 87
        Height = 13
        Caption = 'N'#250'mero do Pedido'
      end
      object EdtNumPedido: TEdit
        Left = 192
        Top = 50
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object BtnBuscaPedido: TBitBtn
        Left = 48
        Top = 24
        Width = 96
        Height = 25
        Caption = 'Buscar Pedido'
        TabOrder = 1
        OnClick = BtnBuscaPedidoClick
      end
      object BtnExcluiPedido: TBitBtn
        Left = 48
        Top = 56
        Width = 96
        Height = 25
        Caption = 'Cancelar Pedido'
        TabOrder = 2
        OnClick = BtnExcluiPedidoClick
      end
    end
  end
  object PedidosCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    OnCalcFields = PedidosClienteCalcFields
    Left = 480
    Top = 120
    object PedidosClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object PedidosClienteDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object PedidosClienteQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object PedidosClienteVLR_UNITARIO: TFloatField
      FieldName = 'VLR_UNITARIO'
    end
    object PedidosClienteVLR_TOTAL: TFloatField
      DisplayLabel = 'Vlr Total'
      FieldName = 'VLR_TOTAL'
    end
  end
  object SqlPesqClientes: TFDQuery
    Connection = DM.Banco
    SQL.Strings = (
      'SELECT NOME, CODIGO FROM CLIENTES')
    Left = 576
    Top = 120
    object SqlPesqClientesNOME: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object SqlPesqClientesCODIGO: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      EditFormat = '000000'
    end
  end
  object dsPedidosCliente: TDataSource
    DataSet = PedidosCliente
    Left = 480
    Top = 168
  end
end
