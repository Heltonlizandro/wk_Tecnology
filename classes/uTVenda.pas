unit uTVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Provider, DBClient, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  uTController, FireDAC.Comp.Client, uTCliente, System.Generics.Defaults,
  System.Generics.Collections, uTVendaProdutos, uTProduto;

type
  TVenda = Class(TController)
  private
    FListaProdutos : TObjectList<TVendaProdutos>;

    FCODIGO_CLIENTE: Integer;
    FNUM_PEDIDO: Integer;
    FVALOR_TOTAL: Double;
    FDATA_EMISSAO: TDateTime;
    procedure SetNUM_PEDIDO(const Value: Integer);
    procedure SetCODIGO_CLIENTE(const Value: Integer);
    procedure SetDATA_EMISSAO(const Value: TDateTime);
    procedure SetVALOR_TOTAL(const Value: Double);

    procedure AtualizaDados(); override;
    function  TABELA           : String; override;
    function  ValidaCadastro() : boolean; override;
    function  ChavePk   : String; override;
  public
    property NUM_PEDIDO    : Integer   read FNUM_PEDIDO     write setNUM_PEDIDO;
    property CODIGO_CLIENTE: Integer   read FCODIGO_CLIENTE write SetCODIGO_CLIENTE;
    property DATA_EMISSAO  : TDateTime read FDATA_EMISSAO   write SetDATA_EMISSAO;
    property VALOR_TOTAL   : Double    read FVALOR_TOTAL    write SetVALOR_TOTAL;

    //------ processos dos produtos da lista -------------
    procedure Adicionar(produto : TVendaProdutos);
    procedure Remover(Index: Integer);
    procedure Alterar(Index: Integer; produto : TVendaProdutos);
    function  ConsultarProd(Index: Integer) : TVendaProdutos;
    function  Count: Integer;
    function  TotalProdutos : Double;
    function  ValidaProduto(produto : TVendaProdutos): boolean;
    //---------------------- fim --------------------

    function  ConsultaProduto(idProduto : integer) : TProduto;
    function  ConsultarItemPedido(idCodigo : Integer): TVendaProdutos;
    function  CarregarPedido(idPedido : String): Boolean;

    function  SalvarPedido(): boolean;
    procedure Excluir();
    procedure Commit;

    Constructor Create(Sql : TFDQuery); override;
  End;

implementation

{ TVenda }

procedure TVenda.Adicionar(produto: TVendaProdutos);
begin
  FListaProdutos.Add(Produto);
end;

procedure TVenda.Alterar(Index: Integer; produto : TVendaProdutos);
begin
  if Index <= Count then
  begin
    FListaProdutos.Items[Index-1].VALOR_UNITARIO := produto.VALOR_UNITARIO;
    FListaProdutos.Items[Index-1].QUANTIDADE     := produto.QUANTIDADE;
  end
  else
    ShowMessage('Item n�o encontrado!');
end;

procedure TVenda.AtualizaDados;
begin
  inherited;
  Campos[0] := 'NUM_PEDIDO';
  Campos[1] := 'DATA_EMISSAO';
  Campos[2] := 'CODIGO_CLIENTE';
  Campos[3] := 'VALOR_TOTAL';

  Valores[0] := FNUM_PEDIDO;
  Valores[1] := FDATA_EMISSAO;
  Valores[2] := FCODIGO_CLIENTE;
  Valores[3] := FVALOR_TOTAL;
end;

function TVenda.ChavePk: String;
begin
  result := 'NUM_PEDIDO';
end;

procedure TVenda.Commit;
begin
  if SqlAuxiliar.Transaction.Active then
    SqlAuxiliar.Transaction.Commit;
end;

function TVenda.CarregarPedido(idPedido: String): Boolean;
begin
  with SqlAuxiliar do
  begin
    SQL.Text := 'SELECT * FROM PEDIDOS WHERE NUM_PEDIDO = '+ idPedido;
    Open();

    if RecordCount > 0  then
    begin
      FNUM_PEDIDO    := FieldByName('NUM_PEDIDO').AsInteger;
      CODIGO_CLIENTE := FieldByName('CODIGO_CLIENTE').AsInteger;
      DATA_EMISSAO   := FieldByName('DATA_EMISSAO').AsDateTime;
      VALOR_TOTAL    := FieldByName('VALOR_TOTAL').AsFloat;

      SQL.Text := 'SELECT * FROM PEDIDOS_PRODUTOS WHERE NUM_PEDIDO = '+ idPedido;
      Open();

      FListaProdutos.Clear;
      while not eof do
      begin
        Adicionar(ConsultarItemPedido(FieldByName('CODIGO').AsInteger));
        Next;
      end;
      Result := True;
    end
    else
    begin
      Result := False;
      ShowMessage('Pedido Inesistente!');
    end;
  end;
end;

function TVenda.ConsultaProduto(idProduto: integer): TProduto;
var
  oProduto : TProduto;
begin
  oProduto := TProduto.Create(SqlAuxiliar);
  oProduto.CODIGO := idProduto;

  if oProduto.Consultar() then
    Result := oProduto
  else
  begin
    FreeAndNil(oProduto);
    Result := nil;
  end;
end;

function TVenda.ConsultarItemPedido(idCodigo: Integer): TVendaProdutos;
var
  oProduto : TVendaProdutos;
begin
  oProduto := TVendaProdutos.Create(SqlAuxiliar);
  oProduto.CODIGO := idCodigo;

  if oProduto.Consultar() then
    Result := oProduto
  else
  begin
    FreeAndNil(oProduto);
    Result := nil;
  end;
end;

function TVenda.ConsultarProd(Index: Integer): TVendaProdutos;
begin
  if Index <= Count then
  begin
    result := FListaProdutos.Items[Index-1];
  end
  else
    ShowMessage('Item n�o encontrado!');
end;

function TVenda.Count: Integer;
begin
  Result := FListaProdutos.Count;
end;

constructor TVenda.Create(Sql: TFDQuery);
begin
  inherited Create(Sql);
  FListaProdutos := TObjectList<TVendaProdutos>.Create;
  SetLength(Campos , 4);
  SetLength(Valores, 4);
end;

procedure TVenda.Excluir;
var
  I: Integer;
begin
  if MessageDlg('Confirma a Exclus�o do Pedido?', mtConfirmation, mbOKCancel,0) = 1 then
  begin
    AtualizaDados;

    for I := 0 to Count-1 do
    begin
      FListaProdutos.Items[I].Excluir;
    end;

    Delete(Self, IntToStr(FNUM_PEDIDO), False);
    Commit;
    ShowMessage('Pedido Exclu�do com Sucesso!');
  end;
end;

procedure TVenda.Remover(Index: Integer);
begin
  if Index <= Count then
     FListaProdutos.Delete(Index-1)
  else
    ShowMessage('Item n�o encontrado!');
end;

function TVenda.SalvarPedido: boolean;
var
  I: Integer;
begin
  if NUM_PEDIDO = 0 then
    NUM_PEDIDO := GetSequence;

  AtualizaDados;

  Insert(Self, Campos, Valores, False);

  for I := 0 to FListaProdutos.Count-1 do
  begin
    FListaProdutos.Items[I].NUM_PEDIDO := FNUM_PEDIDO;
    FListaProdutos.Items[I].InserirProduto();
  end;

  Commit;

  ShowMessage('Pedido: '+IntToStr(FNUM_PEDIDO)+' inserido com Sucesso!');
end;

function TVenda.TABELA: String;
begin
  Result := 'PEDIDOS';
end;

function TVenda.TotalProdutos: Double;
var
  I: Integer;
  SomaTotal : Double;
begin
  SomaTotal := 0;

  for I := 0 to Count-1 do
  begin
    SomaTotal := SomaTotal + (FListaProdutos.Items[I].QUANTIDADE * FListaProdutos.Items[I].VALOR_UNITARIO);
  end;

  Result := SomaTotal;
end;

function TVenda.ValidaCadastro: boolean;
begin
  Result := True;
end;

function TVenda.ValidaProduto(produto: TVendaProdutos): boolean;
begin
  if produto.VALOR_TOTAL = 0 then
  begin
    MessageDlg('Quantidade do produto n�o � um valor v�lido!',mtWarning,[mbOK],0);
    Result := False;
    Exit;
  end;

  Result := True;
end;

procedure TVenda.SetCODIGO_CLIENTE(const Value: Integer);
begin
  FCODIGO_CLIENTE := Value;
end;

procedure TVenda.SetDATA_EMISSAO(const Value: TDateTime);
begin
  FDATA_EMISSAO := Value;
end;

procedure TVenda.setNUM_PEDIDO(const Value: Integer);
begin
  FNUM_PEDIDO := Value;
end;

procedure TVenda.SetVALOR_TOTAL(const Value: Double);
begin
  FVALOR_TOTAL := Value;
end;


end.
