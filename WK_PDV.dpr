program WK_PDV;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uFrmPadrao in 'forms\uFrmPadrao.pas' {FormPadrao},
  uFrmVendas in 'forms\uFrmVendas.pas' {FrmVendas},
  uFrmCliente in 'forms\uFrmCliente.pas' {FrmCliente},
  uFrmFormaPagamento in 'forms\uFrmFormaPagamento.pas' {FrmFormaPagamento},
  uTVenda in 'classes\uTVenda.pas',
  uDM in 'DM\uDM.pas' {DM: TDataModule},
  uTConexao in 'Objetos\uTConexao.pas',
  uTController in 'Objetos\uTController.pas',
  uTVendaProdutos in 'classes\uTVendaProdutos.pas',
  uTProduto in 'classes\uTProduto.pas',
  uTCliente in 'classes\uTCliente.pas',
  uFrmPesquisa in 'Objetos\uFrmPesquisa.pas' {FrmPesquisa},
  uFuncoes in 'Objetos\uFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
