unit uProdutoDAO;

interface

uses
  uProduto, FireDAC.Comp.Client, System.SysUtils, System.Classes;

type
  TProdutoDAO = class
  private
    FConexao: TFDConnection;
  public
    constructor Create(AConexao: TFDConnection);
    function ObterTodos: TFDQuery;
    procedure Inserir(AProduto: TProduto);
    procedure Atualizar(AProduto: TProduto);
    procedure Excluir(AId: Integer);
  end;

implementation

{ TProdutoDAO }

constructor TProdutoDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

procedure TProdutoDAO.Inserir(AProduto: TProduto);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConexao;
    Qry.SQL.Text := 'INSERT INTO Produtos (Nome, Preco) VALUES (:Nome, :Preco)';
    Qry.ParamByName('Nome').AsString := AProduto.Nome;
    Qry.ParamByName('Preco').AsFloat := AProduto.Preco;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TProdutoDAO.Atualizar(AProduto: TProduto);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConexao;
    Qry.SQL.Text := 'UPDATE Produtos SET Nome = :Nome, Preco = :Preco WHERE Id = :Id';
    Qry.ParamByName('Nome').AsString := AProduto.Nome;
    Qry.ParamByName('Preco').AsFloat := AProduto.Preco;
    Qry.ParamByName('Id').AsInteger := AProduto.Id;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TProdutoDAO.Excluir(AId: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConexao;
    Qry.SQL.Text := 'DELETE FROM Produtos WHERE Id = :Id';
    Qry.ParamByName('Id').AsInteger := AId;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TProdutoDAO.ObterTodos: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConexao;
  Result.SQL.Text := 'SELECT * FROM Produtos';
  Result.Open;
end;

end.

