unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Unit2, DragHandle, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  BaseDock: FBaseDock;
  DrageHanler: FDrageHandle;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  BaseDock := FBaseDock.Create(Self);
  DrageHanler := FDrageHandle.Create(Self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DrageHanler.Free;
  BaseDock.Free;
end;

end.
