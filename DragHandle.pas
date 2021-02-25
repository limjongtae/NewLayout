unit DragHandle;

interface
  uses Utils, BaseDock,
  VCL.Forms, VCL.Controls, VCL.Graphics, VCL.AppEvnts, Winapi.Windows, Winapi.Messages, System.Classes;

  type
    TDragState = (dsStart, dsMove, dsEnd); // 움직이는중,

    TDrageHandle = class(TCustomControl)
    private
      FOriginPoint: TPoint; // 처음 클릭한 포인트
      FDragEvents: TApplicationEvents;
      FDragState: TDragState;

      procedure MessageReceivedHandler(var msg: tagMSG; var Handled: Boolean);
      procedure LeftDown(var msg: tagMSG);
      procedure LeftUp(var msg: tagMSG);
      procedure Move(var msg: tagMSG);
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure Paint; override;
    end;

implementation

{ FDrageHandle }

constructor TDrageHandle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Parent := TWinControl(AOwner);
  FOriginPoint := TPoint.Zero;
  DoubleBuffered := True;

  if not (csDesigning in ComponentState) then
  begin
    FDragEvents := TApplicationEvents.Create(nil);
    FDragEvents.OnMessage := MessageReceivedHandler;
  end;

  SendToBack;
end;

destructor TDrageHandle.Destroy;
begin
  FDragEvents.Free;
  inherited;
end;

procedure TDrageHandle.LeftDown(var msg: tagMSG);
begin
  Visible := True;
  FOriginPoint := MAKEPOINT(msg.lParam);
  FDragState := dsStart;
end;

procedure TDrageHandle.LeftUp(var msg: tagMSG);
var
  Control: TControl;
begin
  Visible := False;
  FOriginPoint := TPoint.Zero;
  FDragState := dsEnd;
end;

procedure TDrageHandle.MessageReceivedHandler(var msg: tagMSG;
  var Handled: Boolean);
begin
   case msg.message of
     WM_LBUTTONDOWN : LeftDown(msg);
     WM_MOUSEMOVE : Move(msg);
     WM_LBUTTONUP : LeftUp(msg);
//     WM_MOUSEMOVE :
   end;
end;

procedure TDrageHandle.Move(var msg: tagMSG);
var
  Shift: TShiftState;
  PT: TPoint;
  Control: TControl;
begin
  Shift := KeyboardStateToShiftState;

  if ssLeft in Shift then
  begin
    PT := MAKEPOINT(msg.lParam);
    Control := FindVCLWindow(PT);

    if Control is TBaseDock then
    begin
      TBaseDock(Control).DockState := bsClick;
      TBaseDock(Control).Paint;
    end;
//      TCustomControl(Control).

    BoundsRect := Rect(FOriginPoint.X, FOriginPoint.Y, PT.X, PT.Y);
  end;
end;

procedure TDrageHandle.Paint;
begin
  Canvas.Pen.Style := psDot;
  Canvas.Pen.Color := clBlack;
  Canvas.Brush.Style := bsClear;
  Canvas.Rectangle(ClientRect);
end;

end.
