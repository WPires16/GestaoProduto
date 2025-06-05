unit uProdutoController;

interface

uses
  uProduto, uProdutoDAO, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TProdutoController = class
  private
    FDAO: TProdutoDAO;
  public
    constructor Create(AConexao: TFDConnection);
    function ListarProdutos: TFDQuery;
    procedure SalvarProduto(AProduto: TProduto);
    procedure ExcluirProduto(AId: Integer);
  end;

implementation

{ TProdutoController }

constructor TProdutoController.Create(AConexao: TFDConnection);
begin
  FDAO := TProdutoDAO.Create(AConexao);
end;

procedure TProdutoController.ExcluirProduto(AId: Integer);
begin
  FDAO.Excluir(AId);
end;

function TProdutoController.ListarProdutos: TFDQuery;
begin
  Result := FDAO.ObterTodos;
end;

procedure TProdutoController.SalvarProduto(AProduto: TProduto);
begin
  if AProduto.Id = 0 then
    FDAO.Inserir(AProduto)
  else
    FDAO.Atualizar(AProduto);
end;

end.

