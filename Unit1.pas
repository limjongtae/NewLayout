unit Unit1;

interface

uses
  DragHandle, BaseDock,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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
  BaseDock: TBaseDock;
  DrageHanler: TDrageHandle;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  BaseDock := TBaseDock.Create(Self);
  DrageHanler := TDrageHandle.Create(Self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DrageHanler.Free;
  BaseDock.Free;
end;

end.
