unit uProduto;

interface

uses
  System.Classes, FireDAC.Comp.Client, Data.DB;

type
  TProduto = class
  private
    FId: Integer;
    FNome: string;
    FPreco: Double;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Preco: Double read FPreco write FPreco;

    class function CreateFromDataset(ADataset: TDataSet): TProduto;
  end;

implementation

{ TProduto }

class function TProduto.CreateFromDataset(ADataset: TDataSet): TProduto;
begin
  Result := TProduto.Create;
  Result.Id := ADataset.FieldByName('Id').AsInteger;
  Result.Nome := ADataset.FieldByName('Nome').AsString;
  Result.Preco := ADataset.FieldByName('Preco').AsFloat;
end;

end.

