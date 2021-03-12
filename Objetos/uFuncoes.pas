unit uFuncoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uDM;

type

  TValidacao = class
	  class function  RetornaNumero(Valor: string): Double;

  end;
  
  TMetodo = class
    class function  GetFormatar(Texto: string; TamanhoDesejado: integer; AcrescentarADireita: boolean = true; CaracterAcrescentar: char = ' '): string;
  end;
  
  
implementation

class function TValidacao.RetornaNumero(Valor: string): Double;
var
  I: Integer;
  Retorno : String;
begin
  try
    if Trim(Valor) <> EmptyStr then
    begin
      for I := 1 to length(Valor) do
        if Valor[I] <> '.' then
          Retorno := Retorno + Valor[I];
    end;
    Result := StrToFloat(Retorno);
  except
    Result := 0;
  end;
end;

class function TMetodo.GetFormatar(Texto: string; TamanhoDesejado: integer; AcrescentarADireita: boolean = true; CaracterAcrescentar: char = ' '): string;
{
   OBJETIVO: Eliminar caracteres inválidos e acrescentar caracteres à esquerda ou à direita do texto original para que a string resultante fique com o tamanho desejado

   Texto : Texto original
   TamanhoDesejado: Tamanho que a string resultante deverá ter
   AcrescentarADireita: Indica se o carácter será acrescentado à direita ou à esquerda
      TRUE - Se o tamanho do texto for MENOR que o desejado, acrescentar carácter à direita
             Se o tamanho do texto for MAIOR que o desejado, eliminar últimos caracteres do texto
      FALSE - Se o tamanho do texto for MENOR que o desejado, acrescentar carácter à esquerda
             Se o tamanho do texto for MAIOR que o desejado, eliminar primeiros caracteres do texto
   CaracterAcrescentar: Carácter que deverá ser acrescentado
}
var
  QuantidadeAcrescentar,
    TamanhoTexto,
    PosicaoInicial,
    i: integer;
begin
  case CaracterAcrescentar of
    '0'..'9', 'a'..'z', 'A'..'Z': ; {Não faz nada}
  else
    CaracterAcrescentar := ' ';
  end;

  Texto := Trim(AnsiUpperCase(Texto));
  TamanhoTexto := Length(Texto);
  for i := 1 to (TamanhoTexto) do
  begin
    if Pos(Texto[i], ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~''"!@#$%^&*()_-+=|/\{}[]:;,.<>') = 0 then
    begin
      case Texto[i] of
        'Á', 'À', 'Â', 'Ä', 'Ã': Texto[i] := 'A';
        'É', 'È', 'Ê', 'Ë': Texto[i] := 'E';
        'Í', 'Ì', 'Î', 'Ï': Texto[i] := 'I';
        'Ó', 'Ò', 'Ô', 'Ö', 'Õ': Texto[i] := 'O';
        'Ú', 'Ù', 'Û', 'Ü': Texto[i] := 'U';
        'Ç': Texto[i] := 'C';
        'Ñ': Texto[i] := 'N';
      else
        Texto[i] := ' ';
      end;
    end;
  end;

  QuantidadeAcrescentar := TamanhoDesejado - TamanhoTexto;
  if QuantidadeAcrescentar < 0 then
    QuantidadeAcrescentar := 0;
  if CaracterAcrescentar = '' then
    CaracterAcrescentar := ' ';
  if TamanhoTexto >= TamanhoDesejado then
    PosicaoInicial := TamanhoTexto - TamanhoDesejado + 1
  else
    PosicaoInicial := 1;

  if AcrescentarADireita then
    Texto := Copy(Texto, 1, TamanhoDesejado) + StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar)
  else
    Texto := StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar) + Copy(Texto, PosicaoInicial, TamanhoDesejado);

  Result := AnsiUpperCase(Texto);
end;

end.
