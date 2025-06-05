program Project1;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {Form1},
  uProdutoForm in 'uProdutoForm.pas' {Form2},
  uProduto in 'uProduto.pas',
  uProdutoDAO in 'uProdutoDAO.pas',
  uProdutoController in 'uProdutoController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormProduto, FormProduto);
  Application.Run;
end.
