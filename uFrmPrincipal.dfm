object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'WK PDV'
  ClientHeight = 325
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Menu: TMainMenu
    Left = 352
    Top = 168
    object Processos1: TMenuItem
      Caption = 'Processos'
      object mnuVendas: TMenuItem
        Caption = 'Vendas'
        OnClick = mnuVendasClick
      end
    end
  end
end
