unit uFrmAberturaCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TFrmAberturaCaixa = class(TFormPadrao)
    Panel1: TPanel;
    Label1: TLabel;
    CurrencyEdit1: TCurrencyEdit;
    Label2: TLabel;
    Panel2: TPanel;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAberturaCaixa: TFrmAberturaCaixa;

implementation

{$R *.dfm}

uses uFrmVendas;

end.
