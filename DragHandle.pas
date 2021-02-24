unit DragHandle;

interface
  uses Utils,
  VCL.Forms, VCL.Controls, VCL.Graphics, VCL.AppEvnts, Winapi.Windows, Winapi.Messages, System.Classes;

  type
    TDragState = (dsStart, dsMove, dsEnd); // 움직이는중,

    FDrageHandle = class(TCustomControl)
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

      procedure Paint;
    end;

implementation

{ FDrageHandle }

constructor FDrageHandle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Parent := TWinControl(AOwner);
  FOriginPoint := TPoint.Zero;

  if not (csDesigning in ComponentState) then
  begin
    FDragEvents := TApplicationEvents.Create(nil);
    FDragEvents.OnMessage := MessageReceivedHandler;
  end;
end;

destructor FDrageHandle.Destroy;
begin

  inherited;
end;

procedure FDrageHandle.LeftDown(var msg: tagMSG);
begin
  FOriginPoint := MAKEPOINT(msg.lParam);
  FDragState := dsStart;
  Visible := True;
end;

procedure FDrageHandle.LeftUp(var msg: tagMSG);
begin
  FOriginPoint := TPoint.Zero;
  FDragState := dsEnd;
  Visible := False;
end;

procedure FDrageHandle.MessageReceivedHandler(var msg: tagMSG;
  var Handled: Boolean);
begin
   case msg.message of
     WM_LBUTTONDOWN : LeftDown(msg);
     WM_MOUSEMOVE : Move(msg);
     WM_LBUTTONUP : LeftUp(msg);
//     WM_MOUSEMOVE :
   end;
end;

procedure FDrageHandle.Move(var msg: tagMSG);
var
  Shift: TShiftState;
  PT: TPoint;
begin
  Shift := KeyboardStateToShiftState;

  if ssLeft in Shift then
  begin
    PT := MAKEPOINT(msg.lParam);
    BoundsRect := Rect(FOriginPoint.X, FOriginPoint.Y, PT.X + FOriginPoint.X, PT.Y + FOriginPoint.Y);
    Canvas.DrawFocusRect(ClientRect);
  end;
end;

procedure FDrageHandle.Paint;
begin
  inherited;
//  Canvas.Pen.Color := clRed;
//  Canvas.FillRect(ClientRect);
//  Canvas.Brush.Color := clGray;
//  Canvas.Rectangle(0, 0, BoundsRect.Width, BoundsRect.Height);
end;

end.
