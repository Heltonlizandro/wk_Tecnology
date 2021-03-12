unit uFrmPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, ExtCtrls, DB, StdCtrls, Buttons, DBClient, Grids, DBGrids, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Menus;

type
  TFrmPesquisa = class(TForm)
    PanelPesquisa: TPanel;
    PanelGrid: TPanel;
    PanelSaida: TPanel;
    GridDados: TDBGrid;
    dsDados: TDataSource;
    BitBtn_Cancelar: TBitBtn;
    Label1: TLabel;
    cbTipoPesq: TComboBox;
    Label2: TLabel;
    Edit_Pesquisa: TEdit;
    sqlDados: TFDQuery;
    Label3: TLabel;
    cbPesquisa: TComboBox;
    BtnFiltrar: TBitBtn;
    BitBtn_OK: TBitBtn;
    cbRefreshGrid: TCheckBox;
    BtnCadastrar: TBitBtn;
    Transaction: TFDTransaction;
    procedure BtnFiltrarEnter(Sender: TObject);
    procedure BitBtn_OKClick(Sender: TObject);
    procedure Edit_PesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFiltrarClick(Sender: TObject);
    procedure GridDadosDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn_CancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit_PesquisaChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbTipoPesqClick(Sender: TObject);
    procedure Edit_PesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCadastrarClick(Sender: TObject);
  private
    { Private declarations }
    sTipoPesq, sTipoOrdem, sRet,
    sRetField, sNomes, sTag, sFormat, sTamanho : TStrings;
    bOk, bOkFiltro : Boolean;
    SqlOrigem : TFDQuery;
    sRetorno : Variant;
    bRefreshGrid : Boolean;
    MenuAcesso : TMenuItem;
    procedure AtualizaCamposSql;
    procedure ZeroEsquerda(Sender: TObject; ObrigaZeroEsquerda : Boolean = False);

  public
    { Public declarations }
    ssql, SqlPrincipal, SqlRet : String;
    {usado na pesquisa}
    procedure Execute(sDataSet: TDataSet; sTitulo: String; sCampo: array of string; varRetorno : Variant; SelfForm : TObject; pFocar: TWinControl = nil; SqlComplement : String = ''; bContendo : Boolean = False; RefreshGrid : Boolean = False; MenuCadastro : TMenuItem = nil); overload;
    {usado na verifica��o dos campos ou valores}
    procedure Execute(sDataSet : TDataSet; sCampoLocate, sCampoRet, sTituloCampo: array of string; varRetorno : Variant; SelfForm : TObject; pFocar: TWinControl = nil; SqlComplement : String = ''); overload;

    //Antiga forma de consulta usada no botao
    procedure ExecuteOld(sDataSet: TDataSet; sTitulo: String; sCampo: array of string; varRetorno :  TStrings; MenuCadastro : TMenuItem = nil); overload;
    {usado na verifica��o dos campos ou valores}
    procedure ExecuteOld(sDataSet : TDataSet; sCampoLocate, sCampoRet, sTituloCampo: array of string; varRetorno : TStrings); overload;
    procedure PreencheDados;
    procedure PreencheTipoPesquisa;
  end;

var
  FrmPesquisa: TFrmPesquisa;

implementation

uses uDM, rxCurrEdit, uFrmPrincipal, uFuncoes;


{$R *.dfm}

procedure TFrmPesquisa.BitBtn_OKClick(Sender: TObject);
begin
  if not GridDados.DataSource.DataSet.IsEmpty then
    bOk := True;
  Close;
end;

procedure TFrmPesquisa.AtualizaCamposSql;
var
  x : Integer;
begin
  for x := 0 to sNomes.Count -1 do
  begin
    TFDQuery(dsDados.DataSet).Fields[x].Tag          := StrToInt(sTag[x]);
    TFDQuery(dsDados.DataSet).Fields[x].DisplayLabel := sNomes[x];
    TFDQuery(dsDados.DataSet).Fields[x].DisplayWidth := StrToIntDef(sTamanho[x],10);
    //sqlDados.Fields[x].DisplayText  := sFormat[x];
  end;
end;

procedure TFrmPesquisa.BitBtn_CancelarClick(Sender: TObject);
begin
  bOk := False;
  Close;
end;

procedure TFrmPesquisa.BtnCadastrarClick(Sender: TObject);
begin
  with FrmPrincipal do
  begin
    if TMenuItem(MenuAcesso).Enabled then
    begin
      if MenuAcesso <> nil then
      begin
        TMenuItem(MenuAcesso).Tag := 1;
        TMenuItem(MenuAcesso).Click;
        TMenuItem(MenuAcesso).Tag := 0;

        try
          TFDQuery(dsDados.DataSet).Close;
          //TFDQuery(dsDados.DataSet).SQL.Text := SqlPrincipal +' WHERE '+ sComplemento;
          TFDQuery(dsDados.DataSet).Open;
        except
        end;
      end;
    end;
  end;
end;

procedure TFrmPesquisa.BtnFiltrarClick(Sender: TObject);
var
  sqlAntes,
  sqlDepois,
  sComplemento,
  sOrdem : String;
  I : Integer;
begin
  if bOkFiltro = False then
  begin
    for I := 0 to SqlOrigem.FieldCount - 1 do
      TFDQuery(dsDados.DataSet).Fields[I].Origin := SqlOrigem.Fields[I].Origin;

    case cbPesquisa.ItemIndex of
      0: sComplemento := TFDQuery(dsDados.DataSet).FIELDS[StrToInt(sTipoOrdem[cbTipoPesq.ItemIndex])-1].Origin+' starting with '+QuotedStr(Trim(Edit_Pesquisa.Text));
      1: sComplemento := TFDQuery(dsDados.DataSet).FIELDS[StrToInt(sTipoOrdem[cbTipoPesq.ItemIndex])-1].Origin+' LIKE '+QuotedStr('%'+Trim(Edit_Pesquisa.Text)+'%');
    end;

    if Pos('WHERE',UpperCase(SqlPrincipal)) > 0 then
    begin
//      sqlAntes  := COPY(ssql, 1, Pos('WHERE', UpperCase(SqlPrincipal))+5);
//      sqlDepois := ' AND '+ COPY(ssql, Pos('WHERE', UpperCase(SqlPrincipal))+5, length(SqlPrincipal)); // - Pos('AND', UpperCase(SqlPrincipal))

      TFDQuery(dsDados.DataSet).Close;
//      TFDQuery(dsDados.DataSet).SQL.Text := sqlAntes + sComplemento + sqlDepois;
      TFDQuery(dsDados.DataSet).SQL.Text := SqlPrincipal + ' AND '+ sComplemento;
      TFDQuery(dsDados.DataSet).Open;
    end
    else
    begin
      TFDQuery(dsDados.DataSet).Close;
      TFDQuery(dsDados.DataSet).SQL.Text := SqlPrincipal +' WHERE '+ sComplemento;
      TFDQuery(dsDados.DataSet).Open;
    end;

    AtualizaCamposSql;

    bOkFiltro := True;
  end
  else
    BitBtn_OKClick(Self);
end;

procedure TFrmPesquisa.BtnFiltrarEnter(Sender: TObject);
begin
  bOkFiltro := False;
end;

procedure TFrmPesquisa.cbTipoPesqClick(Sender: TObject);
begin
  if ssql <> emptystr then
  begin
    try
      if Pos(' ORDER BY ', UpperCase(TFDQuery(dsDados.DataSet).SQL.Text)) > 0 then
        ssql := COPY(ssql, 1, Pos(' ORDER BY ', UpperCase(TFDQuery(dsDados.DataSet).SQL.Text)));
      TFDQuery(dsDados.DataSet).Close;
      TFDQuery(dsDados.DataSet).SQL.Text := ssql + ' ORDER BY '+sTipoOrdem[cbTipoPesq.ItemIndex];
      TFDQuery(dsDados.DataSet).Open;

      AtualizaCamposSql;
    except
      ssql := EmptyStr;
    end;
  end;

//  Edit_Pesquisa.SetFocus;
end;


procedure TFrmPesquisa.GridDadosDblClick(Sender: TObject);
begin
  BitBtn_OKClick(Self);
end;

procedure TFrmPesquisa.ZeroEsquerda(Sender: TObject;
  ObrigaZeroEsquerda: Boolean);
begin
  try
    {Se existir MaxLength independete de ser um TEdit
     Processa com o valo a esquerda}
    if TEdit(Sender).MaxLength > 0 then
      if TEdit(Sender).Text <> EmptyStr then
        TEdit(Sender).Text :=  TMetodo.GetFormatar(TEdit(Sender).Text, TEdit(Sender).MaxLength, False, '0');

    if (ObrigaZeroEsquerda) and (TEdit(Sender).Text = EmptyStr) then
      if TEdit(Sender).MaxLength > 0 then
        TEdit(Sender).Text := TMetodo.GetFormatar('0', TEdit(Sender).MaxLength, False, '0');
  except
  end;
end;

procedure TFrmPesquisa.Edit_PesquisaChange(Sender: TObject);
var
  sqlAntes,
  sqlDepois,
  sComplemento,
  sOrdem : String;
  I : Integer;
begin
  if bRefreshGrid or cbRefreshGrid.Checked then
  begin
    for I := 0 to SqlOrigem.FieldCount - 1 do
      TFDQuery(dsDados.DataSet).Fields[I].Origin := SqlOrigem.Fields[I].Origin;

    case cbPesquisa.ItemIndex of
      0: sComplemento := 'UPPER('+TFDQuery(dsDados.DataSet).FIELDS[StrToInt(sTipoOrdem[cbTipoPesq.ItemIndex])-1].Origin+') LIKE UPPER('+QuotedStr(Trim(Edit_Pesquisa.Text)+'%')+')';
      1: sComplemento := 'UPPER('+TFDQuery(dsDados.DataSet).FIELDS[StrToInt(sTipoOrdem[cbTipoPesq.ItemIndex])-1].Origin+') LIKE UPPER('+QuotedStr('%'+Trim(Edit_Pesquisa.Text)+'%')+')';
    end;

    if Pos('WHERE',UpperCase(SqlPrincipal)) > 0 then
    begin
//      sqlAntes  := COPY(ssql, 1, Pos('WHERE', UpperCase(SqlPrincipal))+5);
//      sqlDepois := ' AND '+ COPY(ssql, Pos('WHERE', UpperCase(SqlPrincipal))+5, length(SqlPrincipal)); // - Pos('AND', UpperCase(SqlPrincipal))

      TFDQuery(dsDados.DataSet).Close;
//      TFDQuery(dsDados.DataSet).SQL.Text := sqlAntes + sComplemento + sqlDepois;
      TFDQuery(dsDados.DataSet).SQL.Text := SqlPrincipal + ' AND '+ sComplemento;
      TFDQuery(dsDados.DataSet).Open;
    end
    else
    begin
      TFDQuery(dsDados.DataSet).Close;
      TFDQuery(dsDados.DataSet).SQL.Text := SqlPrincipal +' WHERE '+ sComplemento;
      TFDQuery(dsDados.DataSet).Open;
    end;

    AtualizaCamposSql;
  end;
end;

procedure TFrmPesquisa.Edit_PesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DOWN) and (not (GridDados.DataSource.DataSet.IsEmpty)) then
    GridDados.SetFocus;
end;

procedure TFrmPesquisa.Edit_PesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    BtnFiltrar.SetFocus;
end;

procedure TFrmPesquisa.ExecuteOld(sDataSet: TDataSet; sTitulo: String;
  sCampo: array of string; varRetorno: TStrings; MenuCadastro : TMenuItem = nil);
var
  FrmPesquisa : TFrmPesquisa;
  I, x : Integer;
  sParametros : TStrings;
begin
  try
    FrmPesquisa := TFrmPesquisa.Create(nil);
    //Application.CreateForm(TFrmPesquisa, FrmPesquisa);
    with FrmPesquisa do
    begin
      try
        {De cara limpa a variavel retorno}
        varRetorno.Clear;
        sRet := TStringList.Create;
        sParametros := TStringList.Create;
        sNomes      := TStringList.Create;
        sTag        := TStringList.Create;
        sFormat     := TStringList.Create;
        sTamanho    := TStringList.Create;

        for I := 0 to High(sCampo) do
          sRetField.Add(sCampo[I]);

        {t�tulo do formul�rio}
        Caption := sTitulo;

        //pegando os parametros passados para o sqlprincipal
        for x := 0 to TFDQuery(sDataSet).Params.Count -1 do
          sParametros.Add(TFDQuery(sDataSet).Params[x].AsString);

        for x := 0 to TFDQuery(sDataSet).FieldCount -1 do
        begin
          sNomes.Add(TFDQuery(sDataSet).Fields[x].DisplayLabel);
          sTamanho.Add(IntToStr(TFDQuery(sDataSet).Fields[x].DisplayWidth));
          sTag.Add(IntToStr(TFDQuery(sDataSet).Fields[x].Tag));
          sFormat.Add(TFDQuery(sDataSet).Fields[x].DisplayText);
        end;

        SqlOrigem := TFDQuery(sDataSet);
        sqlDados.Connection  := TFDQuery(sDataSet).Connection;
        sqlDados.Transaction := TFDQuery(sDataSet).Transaction;
        sqlDados.SQL.Text    := TFDQuery(sDataSet).SQL.Text;
        //------------fim doa rotina dos parametros ---------

        {comando sql}
        try
          ssql := sqlDados.SQL.Text;
        except
          ssql := EmptyStr;
        end;
        SqlPrincipal := ssql;

        for x := 0 to sParametros.Count -1 do
          sqlDados.Params[x].Value        := sParametros[x];

        if not sqlDados.Active then
          sqlDados.Open;

        for I := 0 to TFDQuery(sDataSet).FieldCount - 1 do
          sqlDados.Fields[I].Origin := TFDQuery(sDataSet).Fields[I].Origin;

        AtualizaCamposSql;

        MenuAcesso := MenuCadastro;
        BtnCadastrar.Enabled := MenuCadastro <> nil;

        if sqlDados.IsEmpty then
        begin
          if MenuAcesso <> nil then
          begin
            if MessageDlg('N�o existem dados para Consulta.Deseja Cadastrar um novo Registro?',mtConfirmation,[mbyes,mbno],0) = mrYes then
              BtnCadastrarClick(BtnCadastrar);
          end
          else
          begin
            MessageDlg('N�o existem dados para sua pesquisa.', mtInformation, [mbOk],0);
            Exit;
          end;
        end;

        //atualizando o grid com todas as altera��es ja executadas no sqlDados
        GridDados.DataSource := dsDados;

        PreencheDados;
        ShowModal;
      finally
        VarRetorno.Clear;

        for I := 0 to sRet.Count - 1 do
        begin
          varRetorno.Add(sRet[I]);
        end;
        FreeAndNil(sRet);
        FreeAndNil(sParametros);
        FreeAndNil(sNomes);
        FreeAndNil(sTag);
        FreeAndNil(sFormat);
        FreeAndNil(sTamanho);
        Free;
      end;
    end;
  except
    if FrmPesquisa <> nil then
      FrmPesquisa.Free;
  end;
end;

procedure TFrmPesquisa.Execute(sDataSet: TDataSet; sCampoLocate, sCampoRet,
  sTituloCampo: array of string; varRetorno : Variant; SelfForm : TObject; pFocar: TWinControl = nil; SqlComplement : String = '');
var
  FrmPesquisa : TFrmPesquisa;
  I, iCountVariant : Integer;
  sPesqLocate, sValorLocate : String;
  sComponent : String;
  sForm : TForm;
begin
  try
    FrmPesquisa := TFrmPesquisa.Create(nil);
    //Application.CreateForm(TFrmPesquisa, FrmPesquisa);
    with FrmPesquisa do
    begin
      try
        //utilizando o banco e a transacao do componente em que se faz o select
        sqlDados.Close;
        sqlDados.Connection  := TFDQuery(sDataSet).Connection;
        sqlDados.Transaction := TFDQuery(sDataSet).Transaction;
        sqlDados.SQL.Text    := TFDQuery(sDataSet).Sql.Text + SqlComplement;

        for I := 0 to sqlDados.ParamCount -1 do //TFDQuery(sDataSet).ParamCount -1 do
          sqlDados.ParamByName(sqlDados.Params[I].Name).Value := TFDQuery(sDataSet).ParamByName(TFDQuery(sDataSet).Params[I].Name).Value;

        sRet := TStringList.Create;
        sPesqLocate := EmptyStr;

        for I := 0 to High(sCampoRet) do
          sRetField.Add(sCampoRet[I]);

        for I := 0 to High(sCampoLocate) do
        begin
          if I = 0 then
          begin
            sPesqLocate  := sCampoLocate[I];
            try
              if sTituloCampo[I] <> EmptyStr then
                sValorLocate := FloatToStr(StrToFloat(sTituloCampo[I]))
              else
                sValorLocate := sTituloCampo[I];
            except
              on E:Exception do
              begin
                sValorLocate := sTituloCampo[I];
              end;
            end;
          end
          else
          if I > 0 then
          begin
            sPesqLocate  := sPesqLocate  + ';'+sCampoLocate[I];
            sValorLocate := sValorLocate + ','+sTituloCampo[I];
          end;
        end;

        if not dsDados.DataSet.Active then
          dsDados.DataSet.Open;

        if dsDados.DataSet.IsEmpty then
        begin
          //MessageDlg('N�o existem dados para sua pesquisa.', mtInformation, [mbOk],0);
          Exit;
        end;

        if sValorLocate <> Emptystr then
        begin
          if dsDados.DataSet.Locate(sPesqLocate,VarArrayOf([sValorLocate]),[loCaseInsensitive]) then
          begin
            for  I := 0 to sRetField.Count -1 do
            begin
              sRet.Add(dsDados.DataSet.FieldByName(sRetField[I]).AsString);
            end;
          end;
        end;
      finally
        sForm := TForm(SelfForm);
        iCountVariant := VarArrayHighBound(varRetorno, VarArrayDimCount(varRetorno));

        if sRet.Count <= 0 then
        begin
          for I := 0 to iCountVariant do
          begin
            sComponent := varRetorno[I];

            sRetField.Add(sCampoRet[I]);
            if Tcomponent(sForm.FindComponent(sComponent)) is TLabel then
              TLabel(sForm.FindComponent(varRetorno[I])).Caption := TLabel(sForm.FindComponent(varRetorno[I])).Hint
            else
            if Tcomponent(sForm.FindComponent(sComponent)) is TEdit then
            begin
              TEdit(sForm.FindComponent(varRetorno[I])).Text := EmptyStr;
            end
            else
            if Tcomponent(sForm.FindComponent(sComponent)) is TRxCalcEdit then
            begin
              TRxCalcEdit(sForm.FindComponent(varRetorno[I])).Text := EmptyStr;
            end;
          end;
        end;

        if sRet.Count > 0 then
        begin
          for I := 0 to iCountVariant do
          begin
            sComponent := varRetorno[I];

            if Tcomponent(sForm.FindComponent(sComponent)) is TLabel then
              TLabel(sForm.FindComponent(varRetorno[I])).Caption := sRet[I]
            else
            if Tcomponent(sForm.FindComponent(sComponent)) is TEdit then
            begin
              TEdit(sForm.FindComponent(varRetorno[I])).Text := sRet[I];
              ZeroEsquerda(sForm.FindComponent(sComponent));
            end
            else
            if Tcomponent(sForm.FindComponent(sComponent)) is TRxCalcEdit then
            begin
              TRxCalcEdit(sForm.FindComponent(varRetorno[I])).Text := sRet[I];
            end
            else
              varRetorno[I] := sRet[I];
          end;
        end;

        if sRet.Count > 0 then
        begin
          if pFocar <> nil then
            pFocar.SetFocus;
        end;

        FreeAndNIl(sRet);
        Free;
      end;
    end;
  except
//    if FrmPesquisa <> nil then
//      FrmPesquisa.Free;
  end;
end;

procedure TFrmPesquisa.ExecuteOld(sDataSet: TDataSet; sCampoLocate, sCampoRet, sTituloCampo: array of string; varRetorno: TStrings);
var
  FrmPesquisa : TFrmPesquisa;
  I : Integer;
  sPesqLocate, sValorLocate : String;
begin
  try
    FrmPesquisa := TFrmPesquisa.Create(nil);
    //Application.CreateForm(TFrmPesquisa, FrmPesquisa);
    with FrmPesquisa do
    begin
      try
        //utilizando o banco e a transacao do componente em que se faz o select
        SqlOrigem := TFDQuery(sDataSet);
        sqlDados.Close;
        sqlDados.Connection    := TFDQuery(sDataSet).Connection;
        sqlDados.Transaction := TFDQuery(sDataSet).Transaction;
        sqlDados.SQL.Text    := TFDQuery(sDataSet).Sql.Text;

        for I := 0 to TFDQuery(sDataSet).ParamCount -1 do
        begin
          sqlDados.Params[I].Value := TFDQuery(sDataSet).Params[I].Value;
        end;

        sRet := TStringList.Create;
        sPesqLocate := EmptyStr;
        for I := 0 to High(sCampoRet) do
        begin
          sRetField.Add(sCampoRet[I]);
        end;

        for I := 0 to High(sCampoLocate) do
        begin
          if I = 0 then
          begin
            sPesqLocate  := sCampoLocate[I];
            try
              if sTituloCampo[I] <> EmptyStr then
                sValorLocate := FloatToStr(StrToFloat(sTituloCampo[I]))
              else
                sValorLocate := sTituloCampo[I];
            except
              sValorLocate := sTituloCampo[I];
            end;
          end
          else
          if I > 0 then
          begin
            sPesqLocate  := sPesqLocate  + ';'+sCampoLocate[I];
            sValorLocate := sValorLocate + ','+sTituloCampo[I];
          end;
        end;

        //come�a com valores de retorno vazios
        varRetorno.Clear;

        if not dsDados.DataSet.Active then
          dsDados.DataSet.Open;

        if dsDados.DataSet.IsEmpty then
        begin
          MessageDlg('N�o existem dados para sua pesquisa.', mtInformation, [mbOk],0);
          Exit;
        end;

        if dsDados.DataSet.Locate(sPesqLocate,VarArrayOf([sValorLocate]),[loCaseInsensitive]) then
        begin
          for  I := 0 to sRetField.Count -1 do
          begin
            sRet.Add(dsDados.DataSet.FieldByName(sRetField[I]).AsString);
          end;
        end
        else
          varRetorno.Clear;
      finally
        if sRet.Count > 0 then
          VarRetorno.Clear;

        for I := 0 to sRet.Count - 1 do
          varRetorno.Add(sRet[I]);
        FreeAndNIl(sRet);
        Free;
      end;
    end;
  except
    if FrmPesquisa <> nil then
      FrmPesquisa.Free;
  end;
end;

procedure TFrmPesquisa.Execute(sDataSet: TDataSet; sTitulo : String; sCampo: array of string; varRetorno : Variant; SelfForm : TObject; pFocar: TWinControl = nil; SqlComplement : String = ''; bContendo : Boolean = False; RefreshGrid : Boolean = False; MenuCadastro : TMenuItem = nil);
var
  FrmPesquisa : TFrmPesquisa;
  I, x : Integer;
  sParametros : TStrings;
  sComponent : String;
  sForm : TForm;
begin
  try
    FrmPesquisa := TFrmPesquisa.Create(nil);
    //Application.CreateForm(TFrmPesquisa, FrmPesquisa);
    with FrmPesquisa do
    begin
      try
        sRet := TStringList.Create;
        sParametros  := TStringList.Create;
        sNomes       := TStringList.Create;
        sTag         := TStringList.Create;
        sFormat      := TStringList.Create;
        sTamanho     := TStringList.Create;
        bRefreshGrid := RefreshGrid;

        for I := 0 to High(sCampo) do
          sRetField.Add(sCampo[I]);

        {t�tulo do formul�rio}
        Caption := sTitulo;

        //pegando os parametros passados para o sqlprincipal
        for x := 0 to TFDQuery(sDataSet).Params.Count -1 do
          sParametros.Add(TFDQuery(sDataSet).Params[x].AsString);

        for x := 0 to TFDQuery(sDataSet).FieldCount -1 do
        begin
          sNomes.Add(TFDQuery(sDataSet).Fields[x].DisplayLabel);
          sTamanho.Add(IntToStr(TFDQuery(sDataSet).Fields[x].DisplayWidth));
          sTag.Add(IntToStr(TFDQuery(sDataSet).Fields[x].Tag));
          sFormat.Add(TFDQuery(sDataSet).Fields[x].DisplayText);
        end;

        SqlOrigem := TFDQuery(sDataSet);
  //      sqlDados.Connection     := TFDQuery(sDataSet).Connection;
  //      sqlDados.Transaction  := TFDQuery(sDataSet).Transaction;
  //      sqlDados.SQL.Text     := TFDQuery(sDataSet).SQL.Text + SqlComplement;
        dsDados.DataSet := sDataSet;
        //------------fim doa rotina dos parametros ---------

        {comando sql}
        try
  //        ssql := sqlDados.SQL.Text;
          ssql   := TFDQuery(sDataSet).SQL.Text + SqlComplement;
          SqlRet := TFDQuery(sDataSet).SQL.Text;
        except
          ssql := EmptyStr;
        end;
        SqlPrincipal := ssql;

        for x := 0 to sParametros.Count -1 do
          TFDQuery(dsDados.DataSet).Params[x].Value := sParametros[x];
  //        sqlDados.Params[x].Value := sParametros[x];

  //      if not sqlDados.Active then
  //        sqlDados.Open;

        if not TFDQuery(dsDados.DataSet).Active then
          TFDQuery(dsDados.DataSet).Open;

  //      for I := 0 to TFDQuery(sDataSet).FieldCount - 1 do
  //      begin
  //        sqlDados.Fields[I].Origin   := TFDQuery(sDataSet).Fields[I].Origin;
  //      end;

        AtualizaCamposSql;

        BtnCadastrar.Enabled := MenuCadastro <> nil;
        MenuAcesso := MenuCadastro;

  //      if sqlDados.IsEmpty then
        if TFDQuery(dsDados.DataSet).IsEmpty then
        begin
          if MenuAcesso <> nil then
          begin
            if MessageDlg('N�o existem dados para Consulta.Deseja Cadastrar um novo Registro?',mtConfirmation,[mbyes,mbno],0) = mrYes then
              BtnCadastrarClick(BtnCadastrar);
          end
          else
          begin
            MessageDlg('N�o existem dados para sua pesquisa.', mtInformation, [mbOk],0);
            Exit;
          end;
        end;

  //      for I := 0 to TFDQuery(sDataSet).FieldCount - 1 do
  //        sqlDados.Fields[I].Visible := TFDQuery(sDataSet).Fields[I].Visible;

        //atualizando o grid com todas as altera��es ja executadas no sqlDados
        GridDados.DataSource := dsDados;

        PreencheDados;

        if bContendo then
          cbPesquisa.ItemIndex := 1;

        ShowModal;
      finally
        if sRet.Count > 0 then
        begin
          //for I := 0 to sRet.Count - 1 do
          for I := 0 to VarArrayHighBound(varRetorno, VarArrayDimCount(varRetorno)) do
          begin
            sComponent := varRetorno[I];
            sForm := TForm(SelfForm);

            if Tcomponent(sForm.FindComponent(sComponent)) is TLabel then
              TLabel(sForm.FindComponent(varRetorno[I])).Caption := sRet[I]
            else
             if Tcomponent(sForm.FindComponent(sComponent)) is TEdit then
            begin
              TEdit(sForm.FindComponent(varRetorno[I])).Text := sRet[I];
              ZeroEsquerda(sForm.FindComponent(sComponent));
            end
            else
            if Tcomponent(sForm.FindComponent(sComponent)) is TRxCalcEdit then
            begin
              TRxCalcEdit(sForm.FindComponent(varRetorno[I])).Text := sRet[I];
            end
            else
              varRetorno[I] := sRet[I];
          end;

          if pFocar <> nil then
            pFocar.SetFocus;
        end;

        FreeAndNil(sRet);
        FreeAndNil(sParametros);
        FreeAndNil(sNomes);
        FreeAndNil(sTag);
        FreeAndNil(sFormat);
        FreeAndNil(sTamanho);
        Free;
      end;
    end;
  except
//    if FrmPesquisa <> nil then
//      FrmPesquisa.Free;
  end;
end;

procedure TFrmPesquisa.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  I : Integer;
begin
  if bOk then
  begin
    for  I := 0 to sRetField.Count -1 do
    begin
      sRet.Add(dsDados.DataSet.FieldByName(sRetField[I]).AsString);
    end;
  end;
  if SqlRet <> EmptyStr then
    TFDQuery(dsDados.dataset).SQL.Text := SqlRet;
end;

procedure TFrmPesquisa.FormCreate(Sender: TObject);
begin
  sTipoPesq  := TStringList.Create;
  sTipoOrdem := TStringList.Create;
  sRetField  := TStringList.Create;
  bOkFiltro  := False;
end;

procedure TFrmPesquisa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sTipoPesq);
  FreeAndNil(sTipoOrdem);
  FreeAndNil(sRetField);
end;

procedure TFrmPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    bOk := False;
    Close;
  end
  else if not(ActiveControl is TCustomGrid) then
  begin
    if (Key = VK_RETURN) or (Key = VK_NEXT) then
      PostMessage(Handle, WM_NEXTDLGCTL, 0, 0)
    else if Key = VK_PRIOR then
      PostMessage(Handle, WM_NEXTDLGCTL, 1, 0)
  end
  else if Key = VK_RETURN then
    PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TFrmPesquisa.PreencheDados;
begin
  PreencheTipoPesquisa;
end;

procedure TFrmPesquisa.PreencheTipoPesquisa;
var
  I: Integer;
begin
  cbTipoPesq.Items.Clear;
  sTipoPesq.Clear;
  sTipoOrdem.Clear;

  {para preencher o campo de tipo de pesquisa basta colocar um valor maior
   que zero no tag no field}
  for I := 0 to dsDados.DataSet.FieldCount - 1 do
  begin
    if dsDados.DataSet.Fields[I].Tag = 0 then
    begin
      cbTipoPesq.Items.Add(dsDados.DataSet.Fields[I].DisplayLabel);
      sTipoOrdem.Add(IntToStr(dsDados.DataSet.Fields[I].Index +1) {FieldName});
      sTipoPesq.Add(dsDados.DataSet.Fields[I].FieldName);
    end
    else
      dsDados.DataSet.Fields[I].Visible := False;    
    cbTipoPesq.ItemIndex := 0;
  end;

  if Pos(' ORDER BY ', UpperCase(TFDQuery(dsDados.DataSet).SQL.Text)) > 0 then
    ssql := COPY(ssql, 1, Pos(' ORDER BY ', UpperCase(TFDQuery(dsDados.DataSet).SQL.Text)));
  TFDQuery(dsDados.DataSet).Close;
  TFDQuery(dsDados.DataSet).SQL.Text := ssql + ' ORDER BY '+sTipoOrdem[cbTipoPesq.ItemIndex];
  TFDQuery(dsDados.DataSet).Open;

  AtualizaCamposSql;
end;

end.

