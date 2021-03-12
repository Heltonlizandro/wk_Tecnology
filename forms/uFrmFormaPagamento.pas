unit uFrmFormaPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls;

type
  TFrmFormaPagamento = class(TFormPadrao)
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFormaPagamento: TFrmFormaPagamento;

implementation

{$R *.dfm}

end.
