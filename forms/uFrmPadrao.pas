unit uFrmPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TFormPadrao = class(TForm)
    procedure ImgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImgMouseLeave(Sender: TObject);
    procedure ImgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FormPadrao: TFormPadrao;

implementation

{$R *.dfm}

{ TFormPadrao }

procedure TFormPadrao.ImgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if TPanel(TImage(Sender).Parent).Enabled then
  begin
    if TPanel(TImage(Sender).Parent).Tag = 1 then //VERDE
    begin
      TPanel(TImage(Sender).Parent).Color := $0055AA00;
    end
    else
      TPanel(TImage(Sender).Parent).Color := $009F9F9F; //clAqua;
  end;
end;

procedure TFormPadrao.ImgMouseLeave(Sender: TObject);
begin
  if TPanel(TImage(Sender).Parent).Enabled then
  begin
    if TPanel(TImage(Sender).Parent).Tag = 1 then //VERDE
    begin
      TPanel(TImage(Sender).Parent).Color := $0055AA00;
    end
    else
    if TPanel(TImage(Sender).Parent).Tag = 2 then  //LARANJA
    begin
      TPanel(TImage(Sender).Parent).Color := $000079F2;
    end
    else
    if TPanel(TImage(Sender).Parent).Tag = 3 then  //VERMELHO
    begin
      TPanel(TImage(Sender).Parent).Color := $001B31CF;
    end
    else
    begin
      TPanel(TImage(Sender).Parent).Color := clBtnShadow;    //clLime;
    end;
  end
  else
  begin
    if TPanel(TImage(Sender).Parent).Tag = 1 then  //VERDE
    begin
      TPanel(TImage(Sender).Parent).Color := $0066CC00;
    end
    else
    if TPanel(TImage(Sender).Parent).Tag = 2 then  //LARANJA
    begin
      TPanel(TImage(Sender).Parent).Color := $002894FF;
    end
    else
    if TPanel(TImage(Sender).Parent).Tag = 3 then  //VERMELHO
    begin
      TPanel(TImage(Sender).Parent).Color := $002545FA;
    end
    else
    begin
      TPanel(TImage(Sender).Parent).Color := clBtnFace;
    end;
  end;
end;

procedure TFormPadrao.ImgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if TPanel(TImage(Sender).Parent).Enabled then
  begin
    if TPanel(TImage(Sender).Parent).Tag = 1 then  //VERDE
    begin
      TPanel(TImage(Sender).Parent).Color := $0066CC00;
    end
    else
    if TPanel(TImage(Sender).Parent).Tag = 2 then  //LARANJA
    begin
      TPanel(TImage(Sender).Parent).Color := $002894FF;
    end
    else
    if TPanel(TImage(Sender).Parent).Tag = 3 then  //VERMELHO
    begin
      TPanel(TImage(Sender).Parent).Color := $002545FA;
    end
    else
    begin
      TPanel(TImage(Sender).Parent).Color := $00CDCDCD; //clGreen;
    end;
  end;
end;

end.
