program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  BaseDock in 'BaseDock.pas',
  Utils in 'Utils.pas',
  DragHandle in 'DragHandle.pas',
  DockList in 'DockList.pas',
  Dock.Interfaces in 'Dock.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
