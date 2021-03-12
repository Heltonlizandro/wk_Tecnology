unit uFrmVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, uTVenda, uTProduto, uTCliente,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, uTVendaProdutos;

type
  TFrmVendas = class(TFormPadrao)
    Panel1: TPanel;
    PanelDetalhe: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Label3: TLabel;
    PanelTotalGeral: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    ImgFinalizaPedido: TImage;
    Image4: TImage;
    Label5: TLabel;
    EdtCodigoProduto: TEdit;
    Label6: TLabel;
    EdtDescricao: TEdit;
    Label7: TLabel;
    EdtQtdProduto: TEdit;
    EdtVlrUnitario: TEdit;
    Label9: TLabel;
    EdtVlrTotal: TEdit;
    GridProdutos: TDBGrid;
    Label2: TLabel;
    PedidosCliente: TClientDataSet;
    PedidosClienteCODIGO: TIntegerField;
    PedidosClienteDESCRICAO: TStringField;
    PedidosClienteQUANTIDADE: TIntegerField;
    PedidosClienteVLR_UNITARIO: TFloatField;
    PedidosClienteVLR_TOTAL: TFloatField;
    SqlPesqClientes: TFDQuery;
    SqlPesqClientesNOME: TStringField;
    SqlPesqClientesCODIGO: TFDAutoIncField;
    lbNomeCliente: TLabel;
    Label4: TLabel;
    EdtIdCliente: TEdit;
    dsPedidosCliente: TDataSource;
    btnConfirmarPedido: TBitBtn;
    PanelInsAltCliente: TPanel;
    ImgInsAltCliente: TImage;
    Panel2: TPanel;
    EdtNumPedido: TEdit;
    BtnBuscaPedido: TBitBtn;
    BtnExcluiPedido: TBitBtn;
    Label8: TLabel;
    procedure ImgFinalizaPedidoClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtCodigoProdutoChange(Sender: TObject);
    procedure lbNomeClienteClick(Sender: TObject);
    procedure EdtIdClienteClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure EdtCodigoProdutoExit(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure PedidosClienteTOTAL_GERALGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure GridProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarPedidoClick(Sender: TObject);
    procedure EdtQtdProdutoExit(Sender: TObject);
    procedure PedidosClienteCalcFields(DataSet: TDataSet);
    procedure GridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtVlrUnitarioExit(Sender: TObject);
    procedure ImgInsAltClienteClick(Sender: TObject);
    procedure BtnBuscaPedidoClick(Sender: TObject);
    procedure BtnExcluiPedidoClick(Sender: TObject);

  private
    { Private declarations }
    bEdit   : Boolean;
    oVenda  : TVenda;
    oCliente: TCliente;
    oProdutoPedido: TVendaProdutos;
    oProduto : TProduto;

    function  ValidaClientePedido(bMsg : boolean; bClick: boolean):Boolean;

    procedure LimpaDadosCliente();
    procedure LimpaDadosProduto();
    procedure CarregaDadosProduto();
    procedure CalculaValorProduto();
    function  ValidaDadosProduto(): Boolean;
    procedure AtualizaTotalGeral();
    procedure AtualizaDadosGrid();
    procedure AtualizaValoresProduto();

    procedure GravarProduto();
  public
    { Public declarations }
  end;

var
  FrmVendas: TFrmVendas;

implementation

{$R *.dfm}

uses uFrmCliente, uDM, uFrmPesquisa, uFuncoes;

procedure TFrmVendas.AtualizaDadosGrid;
var
  I: Integer;
begin
  PedidosCliente.EmptyDataSet;
  for I := 1 to oVenda.Count do
  begin
    oProdutoPedido := oVenda.ConsultarProd(I);
    PedidosCliente.Append;
    PedidosClienteCODIGO.AsInteger     := oProdutoPedido.CODIGO;
    PedidosClienteDESCRICAO.AsString   := oVenda.ConsultaProduto(oProdutoPedido.CODIGO_PRODUTO).DESCRICAO;
    PedidosClienteQUANTIDADE.AsFloat   := oProdutoPedido.QUANTIDADE;
    PedidosClienteVLR_UNITARIO.AsFloat := oProdutoPedido.VALOR_UNITARIO;
    PedidosClienteVLR_TOTAL.AsFloat    := oProdutoPedido.VALOR_TOTAL;
    PedidosCliente.Post;
  end;

  oCliente        := TCliente.Create(DM.SqlAuxiliar);
  oCliente.CODIGO := oVenda.CODIGO_CLIENTE;
  oCliente.Consultar();
  lbNomeCliente.Caption := oCliente.NOME;
  EdtIdCliente.Text := IntToStr(oCliente.CODIGO);
  AtualizaTotalGeral();
end;

procedure TFrmVendas.AtualizaTotalGeral;
begin
  PanelTotalGeral.Caption  := FloatToStr(oVenda.TotalProdutos);
end;

procedure TFrmVendas.BtnBuscaPedidoClick(Sender: TObject);
begin
  inherited;
  oVenda.CarregarPedido(Trim(EdtNumPedido.Text));
  AtualizaDadosGrid();
end;

procedure TFrmVendas.btnConfirmarPedidoClick(Sender: TObject);
begin
  inherited;
  GravarProduto;
end;

procedure TFrmVendas.BtnExcluiPedidoClick(Sender: TObject);
begin
  inherited;
  if oVenda.CarregarPedido(Trim(EdtNumPedido.Text)) then
    oVenda.Excluir;
end;

procedure TFrmVendas.AtualizaValoresProduto;
begin
  oProdutoPedido.VALOR_TOTAL    := oProdutoPedido.VALOR_UNITARIO * oProdutoPedido.QUANTIDADE;
  EdtVlrTotal.Text     := FloatToStr(oProdutoPedido.VALOR_TOTAL);
end;

procedure TFrmVendas.CalculaValorProduto;
begin
  if oProduto <> nil then
  begin
    if oProdutoPedido.QUANTIDADE = 0 then
      EdtQtdProduto.Text  := EmptyStr
    else
      EdtQtdProduto.Text  := FloatToStr(oProdutoPedido.QUANTIDADE);

    oProdutoPedido.VALOR_UNITARIO := oProduto.PRECO_VENDA;
    AtualizaValoresProduto();
  end
  else
  begin
    EdtDescricao.Text   := EmptyStr;
    EdtVlrUnitario.Text := '0';
    EdtQtdProduto.Text  := EmptyStr;
    EdtVlrTotal.Text    := '0';
  end;
end;

procedure TFrmVendas.CarregaDadosProduto;
begin
  if oProduto <> nil then
  begin
    oProdutoPedido.CODIGO_PRODUTO := oProduto.CODIGO;
    EdtDescricao.Text   := oProduto.DESCRICAO;
    EdtVlrUnitario.Text := FloatToStr(oProduto.PRECO_VENDA);
  end
  else
  begin
    EdtCodigoProduto.Text := EmptyStr;
    EdtDescricao.Text     := EmptyStr;
    EdtVlrUnitario.Text   := '0';
    EdtQtdProduto.Text    := '';
    EdtVlrTotal.Text      := '0';
    EdtCodigoProduto.SetFocus;
  end;
end;

procedure TFrmVendas.GridProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = vk_delete) and (oVenda.Count > 0) then
  begin
    //excluindo um produto da lista
    if MessageDlg('Confirma a Exclusão do Registro Selecionado?', mtConfirmation, mbOKCancel,0) = 1 then
    begin
      oVenda.Remover(PedidosCliente.RecNo);
      PedidosCliente.Delete;
      AtualizaTotalGeral();
    end;
  end;
end;

procedure TFrmVendas.GridProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    //Edita a quantidade do produto
    bEdit    := True;
    oProdutoPedido := oVenda.ConsultarProd(PedidosCliente.RecNo);
    oProduto := oVenda.ConsultaProduto(oProdutoPedido.CODIGO_PRODUTO);
    oProduto.PRECO_VENDA  := oProdutoPedido.VALOR_UNITARIO;

    PanelDetalhe.Enabled  := False;

    EdtCodigoProduto.Text := IntToStr(oProdutoPedido.CODIGO_PRODUTO);
    EdtDescricao.Text     := oProduto.DESCRICAO;
    EdtVlrUnitario.Text   := FloatToStr(oProdutoPedido.VALOR_UNITARIO);
    EdtQtdProduto.Text    := FloatToStr(oProdutoPedido.QUANTIDADE);
    EdtVlrTotal.Text      := FloatToStr(oProdutoPedido.VALOR_TOTAL);

    EdtVlrUnitario.Enabled   := True;
    EdtCodigoProduto.Enabled := False;
    EdtQtdProduto.SelectAll;
  end;
end;

procedure TFrmVendas.EdtCodigoProdutoChange(Sender: TObject);
begin
  inherited;
  ValidaClientePedido(True, False);
end;

procedure TFrmVendas.EdtCodigoProdutoExit(Sender: TObject);
begin
  inherited;
  if EdtCodigoProduto.Text <> EmptyStr then
  begin
    oProduto := oVenda.ConsultaProduto(StrToIntDef(EdtCodigoProduto.Text,0));
    CarregaDadosProduto();
  end;
end;

procedure TFrmVendas.EdtIdClienteClick(Sender: TObject);
begin
  inherited;
  ValidaClientePedido(False, True);
end;

procedure TFrmVendas.EdtQtdProdutoExit(Sender: TObject);
begin
  inherited;
  if (EdtCodigoProduto.Text = EmptyStr) then
  begin
    EdtCodigoProduto.SetFocus;
    Exit;
  end;

  if (oProdutoPedido <> nil) and (TValidacao.RetornaNumero(EdtQtdProduto.Text) > 0) then
  begin
    oProdutoPedido.QUANTIDADE := TValidacao.RetornaNumero(EdtQtdProduto.Text);
    CalculaValorProduto();
  end;
end;

procedure TFrmVendas.EdtVlrUnitarioExit(Sender: TObject);
begin
  inherited;
  oProdutoPedido.VALOR_UNITARIO := TValidacao.RetornaNumero(EdtVlrUnitario.Text);
  if TValidacao.RetornaNumero(EdtVlrUnitario.Text) > 0 then
    AtualizaValoresProduto();
end;

procedure TFrmVendas.FormCreate(Sender: TObject);
begin
  inherited;
  PedidosCliente.CreateDataSet;
end;

procedure TFrmVendas.FormShow(Sender: TObject);
begin
  inherited;
  oVenda         := TVenda.Create(DM.SqlAuxiliar);
  oProdutoPedido := TVendaProdutos.Create(DM.SqlAuxiliar);
end;

procedure TFrmVendas.GravarProduto;
begin
  if not ValidaDadosProduto() then
    Exit;

  if bEdit then
    oVenda.Alterar(PedidosCliente.RecNo, oProdutoPedido)
  else
    oVenda.Adicionar(oProdutoPedido);

  if (bEdit) then
    PedidosCliente.Edit
  else
    PedidosCliente.Append;

  PedidosClienteCODIGO.AsInteger     := oProdutoPedido.CODIGO_PRODUTO;
  PedidosClienteDESCRICAO.AsString   := oProduto.DESCRICAO;
  PedidosClienteQUANTIDADE.AsFloat   := oProdutoPedido.QUANTIDADE;
  PedidosClienteVLR_UNITARIO.AsFloat := oProdutoPedido.VALOR_UNITARIO;
  PedidosClienteVLR_TOTAL.AsFloat    := oProdutoPedido.VALOR_TOTAL;
  PedidosCliente.Post;

  EdtVlrUnitario.Enabled   := False;
  EdtCodigoProduto.Enabled := True;
  PanelDetalhe.Enabled     := True;
  bEdit := False;

  LimpaDadosProduto();

  AtualizaTotalGeral();
  oProdutoPedido := TVendaProdutos.Create(DM.SqlAuxiliar);
end;

procedure TFrmVendas.ImgFinalizaPedidoClick(Sender: TObject);
begin
  inherited;
  if oVenda.NUM_PEDIDO > 0 then
  begin
    MessageDlg('Pedido não pode ser Alterado!',mtWarning,[mbOK],0);
    Exit;
  end;

  oVenda.DATA_EMISSAO   := Now;
  oVenda.VALOR_TOTAL    := oVenda.TotalProdutos;
  oVenda.CODIGO_CLIENTE := oCliente.CODIGO;
  oVenda.SalvarPedido;

  //reseta o pedido já realizado
  PedidosCliente.EmptyDataSet;
  LimpaDadosProduto();

  FreeAndNil(oVenda);
  oVenda := TVenda.Create(DM.SqlAuxiliar);
  oProdutoPedido := TVendaProdutos.Create(DM.SqlAuxiliar);

  LimpaDadosCliente();
end;

procedure TFrmVendas.ImgInsAltClienteClick(Sender: TObject);
begin
  inherited;
  ValidaClientePedido(False, True);
end;

procedure TFrmVendas.Image4Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmVendas.Label1Click(Sender: TObject);
begin
  inherited;
  ValidaClientePedido(False, True);
end;

procedure TFrmVendas.Label4Click(Sender: TObject);
begin
  inherited;
  ValidaClientePedido(False, True);
end;

procedure TFrmVendas.lbNomeClienteClick(Sender: TObject);
begin
  inherited;
  ValidaClientePedido(False, True);
end;

procedure TFrmVendas.LimpaDadosCliente;
begin
  lbNomeCliente.Caption := EmptyStr;
  EdtIdCliente.Text     := EmptyStr;
  FreeAndNil(oCliente);
end;

procedure TFrmVendas.LimpaDadosProduto;
begin
  EdtCodigoProduto.Text := EmptyStr;
  EdtDescricao.Text     := EmptyStr;
  EdtVlrUnitario.Text   := '0';
  EdtQtdProduto.Text    := '';
  EdtVlrTotal.Text      := '0';
  EdtCodigoProduto.SetFocus;
end;

procedure TFrmVendas.PedidosClienteCalcFields(DataSet: TDataSet);
begin
  inherited;
  PedidosClienteVLR_TOTAL.AsFloat := PedidosClienteQUANTIDADE.AsFloat * PedidosClienteVLR_UNITARIO.AsFloat;
end;

procedure TFrmVendas.PedidosClienteTOTAL_GERALGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := FloatToStr(PedidosClienteVLR_UNITARIO.AsFloat * PedidosClienteQUANTIDADE.AsFloat);
end;

function TFrmVendas.ValidaClientePedido(bMsg : boolean; bClick: boolean):Boolean;
begin
  if (oCliente = nil) or (bClick) then
  begin
    if bMsg then
      Application.MessageBox('Obrigatório escolher um cliente!', 'Cliente do Pedido', MB_OK);


    SqlPesqClientes.Close;
    repeat
      FrmPesquisa.Execute(SqlPesqClientes,
                          'Pesquisa dos Bancos.',
                          ['CODIGO','NOME'],
                          VarArrayOf([EdtIdCliente.Name,
                                      lbNomeCliente.Name]),
                          Self);
    until EdtIdCliente.Text <> EmptyStr;

    if bClick then
      FreeAndNil(oCliente);

    if oCliente = nil then
    begin
      oCliente := TCliente.Create(DM.SqlAuxiliar);
      oCliente.CODIGO := StrToInt(EdtIdCliente.Text);
      oCliente.Consultar;
    end;
    EdtCodigoProduto.SetFocus;
  end;
end;

function TFrmVendas.ValidaDadosProduto: Boolean;
begin
  if EdtCodigoProduto.Text = EmptyStr then
  begin
    Result := False;
    ShowMessage('Produto inválido!');
    Exit;
  end;

  if TValidacao.RetornaNumero(EdtQtdProduto.Text) = 0 then
  begin
    Result := False;
    ShowMessage('Quantidade do Produto inválida!');
    Exit;
  end;

  if TValidacao.RetornaNumero(EdtVlrUnitario.Text) = 0 then
  begin
    Result := False;
    ShowMessage('Valor unitário inválido!');
    Exit;
  end;

  Result := oVenda.ValidaProduto(oProdutoPedido);

end;

end.
