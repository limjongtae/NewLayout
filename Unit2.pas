unit Unit2;

interface
   uses  Utils,
         Classes, Controls, System.Types, Vcl.AppEvnts,Vcl.Graphics, Vcl.Forms, Winapi.Windows, Winapi.Messages;

   type
     FBaseDock = class(TCustomControl)
     private
       FEnabled: Boolean; // Dock상태값
       FApplicationEvents: TApplicationEvents; // MessageEvent
       procedure MessageReceivedHandler(var msg: tagMSG; var Handled: Boolean);
       procedure MouseDownHandler(var msg: tagMSG);
     public
       procedure Paint; override;

       constructor Create(AOwner: TComponent);
       destructor Destroy; override;
     end;

implementation

{ FDock }

constructor FBaseDock.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner);

  BorderWidth := 1;
  SetBounds(100, 100, 200, 200);

  FApplicationEvents := TApplicationEvents.Create(nil);
  FApplicationEvents.OnMessage := MessageReceivedHandler; // 이벤트 핸들러 연결
end;

destructor FBaseDock.Destroy;
begin
  FApplicationEvents.Free;
  inherited Destroy;
end;

procedure FBaseDock.MessageReceivedHandler(var msg: tagMSG; var Handled: Boolean);
begin
  if not FEnabled then
  begin
    case msg.message of
//      WM_MOUSEMOVE:
//        MouseMoveHandler(msg);

      WM_LBUTTONDOWN:
        MouseDownHandler(msg);

//      WM_LBUTTONUP:
//        MouseUpHandler(msg, True);

//      WM_KEYDOWN:
//        KeyDownHandler(msg);
    end;
  end;
end;

procedure FBaseDock.MouseDownHandler(var msg: tagMSG);
var
  Control: TControl;
begin

//  if msg.hwnd =  TForm(Owner).Handle then
//  begin
    Control := Vcl.Controls.FindControl(msg.hwnd);
//    StartSizing(Control, MAKEPOINT(msg.lParam));
//  end;


end;

procedure FBaseDock.Paint;
begin
  inherited;

  Canvas.Brush.Color := clRed;
end;

end.
