unit uFrmCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  TFrmCliente = class(TFormPadrao)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    Label4: TLabel;
    comboPesqProd: TComboBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Panel4: TPanel;
    Image3: TImage;
    Panel5: TPanel;
    Image4: TImage;
    Panel2: TPanel;
    Panel6: TPanel;
    Image1: TImage;
    Panel7: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCliente: TFrmCliente;

implementation

{$R *.dfm}

procedure TFrmCliente.FormShow(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage := TabSheet1;
end;

procedure TFrmCliente.Image2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCliente.Image4Click(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
