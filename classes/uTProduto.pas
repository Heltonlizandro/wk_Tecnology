unit uTProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Provider, DBClient, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  uTController, FireDAC.Comp.Client;

type
  TProduto = Class(TController)
  private
    FPRECO_VENDA: Double;
    FDESCRICAO: String;
    FCODIGO: Integer;
    FQTD_VENDA: Double;
    FVLR_TOTAL: Double;
    procedure SetCODIGO(const Value: Integer);
    procedure SetDESCRICAO(const Value: String);
    procedure SetPRECO_VENDA(const Value: Double);
    procedure SetQTD_VENDA(const Value: Double);
    procedure SetVLR_TOTAL(const Value: Double);

    procedure AtualizaDados(); override;
    function  TABELA           : String; override;
    function  ValidaCadastro() : boolean; override;
    function  Consultar()      : boolean; override;

  public
    property CODIGO     : Integer read FCODIGO      write SetCODIGO;
    property DESCRICAO  : String  read FDESCRICAO   write SetDESCRICAO;
    property PRECO_VENDA: Double  read FPRECO_VENDA write SetPRECO_VENDA;
    property QTD_VENDA  : Double  read FQTD_VENDA   write SetQTD_VENDA;
    property VLR_TOTAL  : Double  read FVLR_TOTAL   write SetVLR_TOTAL;

    Constructor Create(Sql : TFDQuery); override;
  End;
implementation

{ TProduto }

procedure TProduto.AtualizaDados;
begin
  inherited;
  Campos[0] := 'CODIGO';
  Campos[1] := 'DESCRICAO';
  Campos[2] := 'PRECO_VENDA';

  Valores[0] := FCODIGO;
  Valores[1] := FDESCRICAO;
  Valores[2] := FPRECO_VENDA;
end;

function TProduto.Consultar(): boolean;
begin
  inherited;
  With SqlAuxiliar do
  begin
    SQL.Text := 'SELECT * FROM PRODUTOS ' +
                ' WHERE CODIGO = '+IntToStr(FCODIGO);
    Open();

    if not IsEmpty then
    begin
      FDESCRICAO   := FieldByName('DESCRICAO').AsString;
      FPRECO_VENDA := FieldByName('PRECO_VENDA').AsFloat;
      Result := True;
    end
    else
      Result := False;
  end;
end;

constructor TProduto.Create(Sql: TFDQuery);
begin
  inherited Create(Sql);
end;

procedure TProduto.SetCODIGO(const Value: Integer);
begin
  FCODIGO := Value;
end;

procedure TProduto.SetDESCRICAO(const Value: String);
begin
  FDESCRICAO := Value;
end;

procedure TProduto.SetPRECO_VENDA(const Value: Double);
begin
  FPRECO_VENDA := Value;
end;

procedure TProduto.SetQTD_VENDA(const Value: Double);
begin
  FQTD_VENDA := Value;
end;

procedure TProduto.SetVLR_TOTAL(const Value: Double);
begin
  FVLR_TOTAL := Value;
end;

function TProduto.TABELA: String;
begin
  Result := 'PRODUTOS';
end;

function TProduto.ValidaCadastro: boolean;
begin
  Result := True;
end;

end.
