unit BaseDock;

interface
   uses  Utils,
         Classes, Controls, System.Types, Vcl.AppEvnts,Vcl.Graphics, Vcl.Forms, Winapi.Windows, Winapi.Messages;

   type
     TDockState = (bsClick, bsUnClick);

     TBaseDock = class(TCustomControl)
     private
       FDockState: TDockState;
       FEnabled: Boolean; // Dock상태값
       FApplicationEvents: TApplicationEvents; // MessageEvent
       procedure MessageReceivedHandler(var msg: tagMSG; var Handled: Boolean);
       procedure MouseDownHandler(var msg: tagMSG);
     public
       procedure Paint; override;

       constructor Create(AOwner: TComponent);
       destructor Destroy; override;

       property DockState: TDockState read FDockState write FDockState;
     end;

implementation

{ FDock }

constructor TBaseDock.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner);
  FDockState := bsUnClick;

  BorderWidth := 1;
  SetBounds(100, 100, 200, 200);

  FApplicationEvents := TApplicationEvents.Create(nil);
  FApplicationEvents.OnMessage := MessageReceivedHandler; // 이벤트 핸들러 연결
end;

destructor TBaseDock.Destroy;
begin
  FApplicationEvents.Free;
  inherited Destroy;
end;

procedure TBaseDock.MessageReceivedHandler(var msg: tagMSG; var Handled: Boolean);
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

procedure TBaseDock.MouseDownHandler(var msg: tagMSG);
var
  Control: TControl;
begin

//  if msg.hwnd =  TForm(Owner).Handle then
//  begin
//    Control := Vcl.Controls.FindControl(msg.hwnd);
//    StartSizing(Control, MAKEPOINT(msg.lParam));
//  end;


end;

procedure TBaseDock.Paint;
begin

  Canvas.Pen.Style := psClear;
  Canvas.Pen.Color := clBlack;
  Canvas.Pen.Width := 3;
  Canvas.Brush.Color := clRed;
  Canvas.Rectangle(ClientRect);

  case FDockState of
    bsClick : Canvas.DrawFocusRect(ClientRect);
    bsUnClick :
  end;


end;

end.
