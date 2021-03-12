unit uTCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Provider, DBClient, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  uTController, FireDAC.Comp.Client;

type
  TCliente = Class(TController)
  private
    FUF: String;
    FCODIGO: Integer;
    FNOME: String;
    FCIDADE: String;
    procedure SetCIDADE(const Value: String);
    procedure SetCODIGO(const Value: Integer);
    procedure SetNOME(const Value: String);
    procedure SetUF(const Value: String);

    procedure AtualizaDados(); override;
    function  TABELA           : String; override;
    function  ValidaCadastro() : boolean; override;
    function  ChavePk          : String; override;

  public
    property CODIGO : Integer read FCODIGO write SetCODIGO;
    property NOME   : String read FNOME write SetNOME;
    property CIDADE : String read FCIDADE write SetCIDADE;
    property UF     : String read FUF write SetUF;

    function  Consultar(): boolean; override;
    Constructor Create(Sql : TFDQuery); override;


  End;

implementation

{ TCliente }

procedure TCliente.AtualizaDados;
begin
  inherited;
  Campos[0] := 'CODIGO';
  Campos[1] := 'NOME';
  Campos[2] := 'CIDADE';
  Campos[3] := 'UF';

  Valores[0] := FCODIGO;
  Valores[1] := FNOME;
  Valores[2] := FCIDADE;
  Valores[3] := FUF;
end;

function TCliente.ChavePk: String;
begin
  Result := 'CODIGO';
end;

function TCliente.Consultar: boolean;
begin
  With SqlAuxiliar do
  begin
    SQL.Text := 'SELECT * FROM CLIENTES '+
                ' WHERE CODIGO = '+IntToStr(FCODIGO);
    Open();

    if not IsEmpty then
    begin
      FNOME   := FieldByName('NOME').AsString;
      FCIDADE := FieldByName('CIDADE').AsString;
      FUF     := FieldByName('UF').AsString;
      Result  := True;
    end
    else
      Result := False;
  end;
end;

constructor TCliente.Create(Sql: TFDQuery);
begin
  inherited Create(Sql);

end;

procedure TCliente.SetCIDADE(const Value: String);
begin
  FCIDADE := Value;
end;

procedure TCliente.SetCODIGO(const Value: Integer);
begin
  FCODIGO := Value;
end;

procedure TCliente.SetNOME(const Value: String);
begin
  FNOME := Value;
end;

procedure TCliente.SetUF(const Value: String);
begin
  FUF := Value;
end;

function TCliente.TABELA: String;
begin
  Result := 'CLIENTES';
end;

function TCliente.ValidaCadastro: boolean;
begin
  Result := True;
end;

end.

