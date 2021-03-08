unit BaseDock;

interface
   uses DragDock, Dock.Interfaces, Utils,
        Classes, Controls, System.Types, System.TypInfo, Vcl.AppEvnts,Vcl.Graphics, Vcl.Forms, VCL.Themes, Winapi.Windows, Winapi.Messages;

   type
     TDockState = (bsClick, bsUnClick);

     TDragDockProc = reference to procedure(DragDock: TDragDock);

     TBaseDock = class(TCustomControl, IDockInterface)
     private
       FDockState: TDockState;
       FDragRect: TRect; // DragArea
       FDragDock: TDragDock;
       FGridGap: Integer; // Grid Offset
       FEnabled: Boolean; // Dock상태값
       FApplicationEvents: TApplicationEvents; // MessageEvent

       procedure MessageReceivedHandler(var msg: tagMSG; var Handled: Boolean);
       procedure MouseDownHandler(var msg: tagMSG);

       function GetDragRect: TRect;
       function GetChildRect: TRect;
       procedure UpdateDragRect(Rect: TRect; Direction: TDirections);

       procedure ForEachDragHandle(Proc: TDragDockProc);
     public
       procedure Paint; override;

       constructor Create(AOwner: TComponent);
       destructor Destroy; override;

       property DockState: TDockState read FDockState write FDockState;
     end;

  const

  // DragControls
  DragDockClasses: array [0 .. 7] of TDragDockClass = (TUpDragHandle,
    TDownDragHandle, TLeftDragHandle, TRightDragHandle, TUpLeftDragHandle,
    TUpRightDragHandle, TDownLeftDragHandle, TDownRightDragHandle);

implementation

{ FDock }

constructor TBaseDock.Create(AOwner: TComponent);
var
  DragDockClass: TDragDockClass;
  DragDock: TDragDock;
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner);
  FDockState := bsUnClick;
  FGridGap := 8;
  SetBounds(100, 100, 100, 100);

  FDragRect := Rect(ClientRect.Left - FGridGap, ClientRect.Top - FGridGap, ClientRect.Width + FGridGap, ClientRect.Height + FGridGap);

  FApplicationEvents := TApplicationEvents.Create(nil);
  FApplicationEvents.OnMessage := MessageReceivedHandler; // 이벤트 핸들러 연결

  // DragHandle Create
  for DragDockClass in DragDockClasses do
  begin
    DragDock := DragDockClass.Create(Self);
    with DragDock  do
    begin
//      Size := 8;
      Color := RGB(178, 214, 243);
      DockInterface := Self;
    end;
    InsertComponent(DragDock);
  end;

  // DragHandle Size Setting
//  ForEachDragHandle(
//    procedure(DragDock: TDragDock)
//    begin
////      DragDock.SetSizingOrigin(Self.Left, Self.Top);
//      DragDock.UpdatePosition(Self);
//      DragDock.Parent := TWinControl(AOwner);
//      DragDock.BringToFront;
//      DragDock.Visible := True;
//    end);
end;

destructor TBaseDock.Destroy;
begin
  FApplicationEvents.Free;
  inherited Destroy;
end;

procedure TBaseDock.ForEachDragHandle(Proc: TDragDockProc);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    Proc(TDragDock(Components[i]));
end;

function TBaseDock.GetChildRect: TRect;
begin

end;

function TBaseDock.GetDragRect: TRect;
begin

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
  PT: TPoint;
begin
  Control := Vcl.Controls.FindControl(msg.hwnd);
  PT := MAKEPOINT(msg.lParam);

  if Control is TDragDock then
  begin
    TDragDock(Control).UpdatePosition(Control);
  end;


//  if msg.hwnd =  TForm(Owner).Handle then
//  begin
//    Control := Vcl.Controls.FindControl(msg.hwnd);
//    StartSizing(Control, MAKEPOINT(msg.lParam));
//  end;


end;

procedure TBaseDock.Paint;
begin

//  Canvas.Pen.Style := psClear;
//  Canvas.Pen.Color := clBlack;
//  Canvas.Pen.Width := 3;
  Canvas.Brush.Color := clRed;
  Canvas.Rectangle(ClientRect);
//
//  case FDockState of
//    bsClick : Canvas.DrawFocusRect(ClientRect);
//    bsUnClick :
//  end;
//
//  Canvas.DrawFocusRect(FDragRect);


end;

procedure TBaseDock.UpdateDragRect(Rect: TRect; Direction: TDirections);
begin

end;

end.
