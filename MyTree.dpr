program MyTree;

uses
  Vcl.Forms,
  MainFormTree in 'MainFormTree.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
