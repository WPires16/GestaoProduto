unit uProdutoForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uProduto;

type
  TFormProduto = class(TForm)
    LabelNome: TLabel;
    LabelPreco: TLabel;
    EditNome: TEdit;
    EditPreco: TEdit;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    FProduto: TProduto;
    procedure CarregarDados;
    procedure SalvarDados;
  public
    constructor Create(AOwner: TComponent; AProduto: TProduto); reintroduce;
  end;

var
  FormProduto: TFormProduto;

implementation

{$R *.dfm}

constructor TFormProduto.Create(AOwner: TComponent; AProduto: TProduto);
begin
  inherited Create(AOwner);
  FProduto := AProduto;
  CarregarDados;
end;

procedure TFormProduto.CarregarDados;
begin
  EditNome.Text := FProduto.Nome;
  EditPreco.Text := FormatFloat('0.00', FProduto.Preco);
end;

procedure TFormProduto.SalvarDados;
begin
  FProduto.Nome := EditNome.Text;
  FProduto.Preco := StrToFloatDef(EditPreco.Text, 0);
end;

procedure TFormProduto.BtnSalvarClick(Sender: TObject);
begin
  SalvarDados;
  ModalResult := mrOk;
end;

procedure TFormProduto.BtnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.

