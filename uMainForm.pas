unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Data.DB, FireDAC.Comp.Client, uProdutoController, uProduto, uProdutoDAO, uProdutoForm;

type
  TFormMain = class(TForm)
    DBGridProdutos: TDBGrid;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnExcluir: TButton;
    DataSourceProdutos: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    FConexao: TFDConnection;
    FController: TProdutoController;
    FDataset: TFDQuery;
    procedure AtualizarGrid;
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FConexao := TFDConnection.Create(nil);
  // configure a conexão aqui, exemplo:
  FConexao.Params.DriverID := 'MSSQL';
  FConexao.Params.Database := 'SeuBanco';
  FConexao.Params.UserName := 'sa';
  FConexao.Params.Password := 'sua_senha';
  FConexao.Params.Add('Server=localhost');
  FConexao.LoginPrompt := False;
  FConexao.Connected := True;

  FController := TProdutoController.Create(FConexao);
  AtualizarGrid;
end;

procedure TFormMain.AtualizarGrid;
begin
  if Assigned(FDataset) then
    FreeAndNil(FDataset);

  FDataset := FController.ListarProdutos;
  DataSourceProdutos.DataSet := FDataset;
end;

procedure TFormMain.BtnNovoClick(Sender: TObject);
var
  Produto: TProduto;
  FormProduto: TFormProduto;
begin
  Produto := TProduto.Create;
  FormProduto := TFormProduto.Create(Self, Produto);
  try
    if FormProduto.ShowModal = mrOk then
    begin
      FController.SalvarProduto(Produto);
      AtualizarGrid;
    end;
  finally
    Produto.Free;
    FormProduto.Free;
  end;
end;

procedure TFormMain.BtnEditarClick(Sender: TObject);
var
  Produto: TProduto;
  FormProduto: TFormProduto;
begin
  if FDataset.IsEmpty then Exit;
  Produto := TProduto.CreateFromDataset(FDataset);
  FormProduto := TFormProduto.Create(Self, Produto);
  try
    if FormProduto.ShowModal = mrOk then
    begin
      FController.SalvarProduto(Produto);
      AtualizarGrid;
    end;
  finally
    Produto.Free;
    FormProduto.Free;
  end;
end;

procedure TFormMain.BtnExcluirClick(Sender: TObject);
begin
  if FDataset.IsEmpty then Exit;
  if MessageDlg('Deseja excluir este produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FController.ExcluirProduto(FDataset.FieldByName('Id').AsInteger);
    AtualizarGrid;
  end;
end;

end.

