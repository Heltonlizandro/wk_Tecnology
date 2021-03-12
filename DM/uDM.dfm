object DM: TDM
  OldCreateOrder = False
  Height = 369
  Width = 393
  object Banco: TFDConnection
    Params.Strings = (
      'Database=wk_db'
      'User_Name=root'
      'Password=1234'
      'Server=localhost'
      'DriverID=MySQL'
      'Compress=True'
      'ResultMode=Store'
      'UseSSL=False')
    FetchOptions.AssignedValues = [evAutoClose]
    Connected = True
    LoginPrompt = False
    Transaction = Transaction
    UpdateTransaction = Transaction
    Left = 72
    Top = 56
  end
  object Transaction: TFDTransaction
    Connection = Banco
    Left = 72
    Top = 120
  end
  object SqlAuxiliar: TFDQuery
    Connection = Banco
    Transaction = Transaction
    Left = 152
    Top = 56
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'F:\Producao\D_Seattle\WK_Tecnologia\Win32\Debug\libmysql.dll'
    Left = 80
    Top = 200
  end
end
