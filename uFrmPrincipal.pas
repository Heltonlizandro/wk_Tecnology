unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    Menu: TMainMenu;
    Processos1: TMenuItem;
    mnuVendas: TMenuItem;
    procedure mnuVendasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uFrmVendas;

procedure TFrmPrincipal.mnuVendasClick(Sender: TObject);
begin
  Application.CreateForm(TFrmVendas, FrmVendas);
  FrmVendas.ShowModal;
  FrmVendas.Free;
end;

end.
