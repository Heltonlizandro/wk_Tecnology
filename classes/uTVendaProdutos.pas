unit uTVendaProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Provider, DBClient, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  uTController, FireDAC.Comp.Client;

type
  TVendaProdutos = Class(TController)
  private
    FVALOR_UNITARIO: Double;
    FNUM_PEDIDO: Integer;
    FVALOR_TOTAL: Double;
    FCODIGO: Integer;
    FQUANTIDADE: Double;
    FCODIGO_PRODUTO: Integer;
    procedure SetCODIGO(const Value: Integer);
    procedure SetCODIGO_PRODUTO(const Value: Integer);
    procedure SetNUM_PEDIDO(const Value: Integer);
    procedure SetQUANTIDADE(const Value: Double);
    procedure SetVALOR_TOTAL(const Value: Double);
    procedure SetVALOR_UNITARIO(const Value: Double);

    procedure AtualizaDados(); override;
    function  TABELA           : String; override;
    function  ValidaCadastro() : boolean; override;
    function  ChavePk          : String; override;

  public
    property CODIGO         : Integer read FCODIGO         write SetCODIGO;
    property NUM_PEDIDO     : Integer read FNUM_PEDIDO     write SetNUM_PEDIDO;
    property CODIGO_PRODUTO : Integer read FCODIGO_PRODUTO write SetCODIGO_PRODUTO;
    property QUANTIDADE     : Double  read FQUANTIDADE     write SetQUANTIDADE;
    property VALOR_UNITARIO : Double  read FVALOR_UNITARIO write SetVALOR_UNITARIO;
    property VALOR_TOTAL    : Double  read FVALOR_TOTAL    write SetVALOR_TOTAL;

    function  Consultar : boolean; override;
    procedure InserirProduto();
    procedure Excluir();


    Constructor Create(Sql : TFDQuery); override;

  End;

implementation

{ TVendaProdutos }

procedure TVendaProdutos.AtualizaDados;
begin
  inherited;
  Campos[0] := 'CODIGO';
  Campos[1] := 'NUM_PEDIDO';
  Campos[2] := 'CODIGO_PRODUTO';
  Campos[3] := 'QUANTIDADE';
  Campos[4] := 'VALOR_UNITARIO';
  Campos[5] := 'VALOR_TOTAL';

  Valores[0] := FCODIGO;
  Valores[1] := FNUM_PEDIDO;
  Valores[2] := FCODIGO_PRODUTO;
  Valores[3] := FQUANTIDADE;
  Valores[4] := FVALOR_UNITARIO;
  Valores[5] := FVALOR_TOTAL;
end;

function TVendaProdutos.ChavePk: String;
begin
  Result := 'CODIGO';
end;

function TVendaProdutos.Consultar: boolean;
begin
  with SqlAuxiliar do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM PEDIDOS_PRODUTOS '+
                ' WHERE 1=1 ');

    if FCODIGO > 0 then
      SQL.Add(' and CODIGO = '+IntToStr(FCODIGO));

    Open();

    if RecordCount > 0 then
    begin
      CODIGO         := FieldByName('CODIGO').AsInteger;
      NUM_PEDIDO     := FieldByName('NUM_PEDIDO').AsInteger;
      CODIGO_PRODUTO := FieldByName('CODIGO_PRODUTO').AsInteger;
      QUANTIDADE     := FieldByName('QUANTIDADE').AsFloat;
      VALOR_UNITARIO := FieldByName('VALOR_UNITARIO').AsFloat;
      VALOR_TOTAL    := FieldByName('VALOR_TOTAL').AsFloat;
      Result := True;
    end
    else
      Result := False;
  end;
end;

constructor TVendaProdutos.Create(Sql: TFDQuery);
begin
  inherited Create(Sql);
  try
    SetLength(Campos , 6);
    SetLength(Valores, 6);

    if not SqlAuxiliar.Transaction.Active then
      SqlAuxiliar.Transaction.StartTransaction;
  except
    FreeAndNil(SqlAuxiliar)
  end;

end;

procedure TVendaProdutos.Excluir;
begin
  AtualizaDados;
  Delete(Self, IntToStr(FCODIGO), False);
end;

procedure TVendaProdutos.InserirProduto;
begin
  if CODIGO = 0 then
    CODIGO := GetSequence;

  AtualizaDados;

  Insert(Self, Campos, Valores, False);
end;

procedure TVendaProdutos.SetCODIGO(const Value: Integer);
begin
  FCODIGO := Value;
end;

procedure TVendaProdutos.SetCODIGO_PRODUTO(const Value: Integer);
begin
  FCODIGO_PRODUTO := Value;
end;

procedure TVendaProdutos.SetNUM_PEDIDO(const Value: Integer);
begin
  FNUM_PEDIDO := Value;
end;

procedure TVendaProdutos.SetQUANTIDADE(const Value: Double);
begin
  FQUANTIDADE := Value;
end;

procedure TVendaProdutos.SetVALOR_TOTAL(const Value: Double);
begin
  FVALOR_TOTAL := Value;
end;

procedure TVendaProdutos.SetVALOR_UNITARIO(const Value: Double);
begin
  FVALOR_UNITARIO := Value;
end;

function TVendaProdutos.TABELA: String;
begin
  Result := 'PEDIDOS_PRODUTOS';
end;

function TVendaProdutos.ValidaCadastro: boolean;
begin
  Result := True;
end;

end.
