unit uTController;

interface

uses uTConexao, FireDAC.Comp.Client;

type
  TController = class(TConexao)
  protected
    SqlAuxiliar : TFDQuery;

    Campos  : Array of string;
    Valores : Array of Variant;
    function ValidaCadastro() : boolean; virtual; abstract;
    function GetSequence() : Integer;
  public
    procedure Insert(Objeto: TConexao; vCampos : Array of String; vValores : Array of Variant; bCommit : Boolean);
    procedure Update(Objeto: TConexao; vCampos : Array of String; vValores : Array of Variant; vChave, vValor: String);
    procedure Delete(Objeto: TConexao; vValor : String; bPergunta : Boolean = True);

    Constructor Create(Sql : TFDQuery); Virtual;
    Destructor Destroy; override;
  end;

implementation

{ Controlerr }

uses System.TypInfo, uDM, System.SysUtils, Vcl.Dialogs;

function TController.GetSequence: Integer;
var
  iSeq : Integer;
begin
  with DM.SqlAuxiliar do
  begin
    Close;
    SQL.Text := ' SELECT AUTO_INCREMENT '+
                '   FROM information_schema.tables '+
                '  WHERE upper(table_name) = '+QuotedStr(TABELA);
    Open();

    iSeq := FieldByName('AUTO_INCREMENT').AsInteger;

    //GARANTINDO QUE A PROXIMA SEQUENCE É VÁLIDA
    Close;
    SQL.Text := 'SELECT MAX('+ChavePk+')+1 CODIGO' +
                '  FROM '+TABELA;
    Open();

    if (iSeq <> FieldByName('CODIGO').AsInteger) and (FieldByName('CODIGO').AsInteger > 0) then
      iSeq := FieldByName('CODIGO').AsInteger;

    Result := iSeq;
  end;
end;

procedure TController.Insert(Objeto: TConexao; vCampos : Array of String; vValores : Array of Variant; bCommit : Boolean);
var
  Script, Campos, Valores : String;
  I: Integer;
  propInfo: PPropInfo;
begin
  Script := 'INSERT INTO '+Objeto.TABELA;

  for i := Low(vCampos) to High(vCampos) do
  begin
    Campos  := Campos  + vCampos[i]+',';
    Valores := Valores + ':'+vCampos[i]+',';
  end;

  Campos  := copy(Campos,  1, length(Campos)-1);
  Valores := copy(Valores, 1, length(Valores)-1);

  try

    with DM.SqlAuxiliar do
    begin
      if not DM.Banco.InTransaction then
        DM.Banco.StartTransaction;

      Close;
      SQL.Text := Script +'('+Campos+') values ('+valores+')';

      for i := Low(vValores) to High(vValores) do
      begin
        Params[i].Value := vValores[i];
      end;

      ExecSQL;

      if ValidaCadastro() then
      begin
        if bCommit then
          DM.Banco.Commit();
      end
      ELSE
        DM.Banco.Rollback();
    end;
  except
    on E:Exception do
      ShowMessage('Erro de Inclusão: '+E.Message);
  end;
end;

procedure TController.Update (Objeto: TConexao; vCampos : Array of String; vValores : Array of Variant; vChave, vValor : String);
var
  i: Integer;
begin
  try
    with DM.SqlAuxiliar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE '+TABELA+' SET ');

      for i := Low(vCampos) to High(vCampos) do
      begin
        if i > 0 then
          SQL.Add(',');

        SQL.Add(vCampos[i]+'= :'+vCampos[i]);
      end;

      SQL.Add('  WHERE '+vChave+' ='+ vValor);

      for i := Low(vValores) to High(vValores) do
      begin
        Params[i].Value := vValores[i];
      end;

      ExecSQL;

      MessageDlg('Dados Alterados com Sucesso.', mtInformation, [mbOk],0);
    end;
  except
    MessageDlg('Erro na Alteração dos Dados.'+#13+msgErroAdm, mtInformation, [mbOk],0);
  end;
end;

constructor TController.Create(Sql: TFDQuery);
begin
  try
    SqlAuxiliar             := TFDQuery.Create(nil);
    SqlAuxiliar.Connection  := Sql.Connection;
    SqlAuxiliar.Transaction := Sql.Transaction;

    if not SqlAuxiliar.Transaction.Active then
      SqlAuxiliar.Transaction.StartTransaction;
  except
    FreeAndNil(SqlAuxiliar)
  end;
end;

procedure TController.Delete (Objeto: TConexao; vValor : String; bPergunta : Boolean);
var
  Sair : Word;
begin
  begin
    try
      with DM.SqlAuxiliar do
      begin
        if not Transaction.Active then
          Transaction.StartTransaction;


        if bPergunta then
        begin
          Sair := MessageDlg('Confirma a Exclusão do Registro Selecionado?', mtConfirmation, mbOKCancel,0);
          if Sair = 1 then
          begin
            Close;
            SQL.Text := 'DELETE FROM ' +TABELA+
                        ' WHERE '+ChavePk+' = '+vValor;
            ExecSQL;

            Transaction.Commit;
            MessageDlg('Dados Alterados com Sucesso.', mtInformation, [mbOk],0);
          end;
        end
        else
        begin
          Close;
          SQL.Text := 'DELETE FROM ' +TABELA+
                      ' WHERE '+ChavePk+' = '+vValor;
          ExecSQL;
        end;
      end;
    except
      DM.SqlAuxiliar.Transaction.Rollback;
      MessageDlg('Erro na Exclusão dos Dados.'+#13+msgErroAdm, mtInformation, [mbOk],0);
    end;
  end;
end;

destructor TController.Destroy;
begin
  FreeAndNil(SqlAuxiliar);
  inherited;
end;

end.
