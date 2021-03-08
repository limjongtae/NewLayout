unit DragDock;

interface

uses Dock.Interfaces,
     Classes, Controls, Graphics, Windows, Messages, Forms, SysUtils, StdCtrls,
     RTTI, System.Generics.Collections;

type
  TDragDockClass = class of TDragDock;

  /// Base class for drag handles
  TDragDock = class(TCustomControl)
  protected
    FClickOrigin: TPoint;
    FHorizontalFix: TDirection;
    FVerticalFix: TDirection;
    FDockInterface: IDockInterface;
    FSize: Byte;
    FBorderColor: TColor;
    function GetRectSide(const Rect: TRect; Direction: TDirection) : Integer;
    procedure SetSize(const Value: Byte);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;

    procedure UpdateChildSize(Sender: TControl; X, Y: Integer); virtual; abstract;
    procedure SetSizingOrigin(const X, Y: Integer);
    procedure UpdatePosition(Control: TControl); virtual; abstract;



    property Color;
    property BorderColor : TColor read FBorderColor write FBorderColor;
    property DockInterface: IDockInterface read FDockInterface write FDockInterface;
    property Size: Byte read FSize write SetSize;
  end;

  // DotHandle
  TDotDrageHandle = class(TDragDock)
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  end;

  // LineHandle
  TLineDragHandle = class(TDragDock)
    constructor Create(AOwner: TComponent); override;
  end;

  THorizontalDragHandle = class(TLineDragHandle) // 가로
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  end;

  TVerticalDragHandle = class(TLineDragHandle)  // 세로
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
  end;

  TMultiDirectionalDragHandle = class(TDragDock)
    procedure UpdateChildSize(Sender: TControl; X, Y: Integer); override;
  end;

  // Line Handle
  TUpDragHandle = class(THorizontalDragHandle)
  public
    procedure UpdatePosition(Control: TControl); override;
    constructor Create(AOwner: TComponent); override;
  end;

  TDownDragHandle = class(THorizontalDragHandle)
  public
    procedure UpdatePosition(Control: TControl); override;
    constructor Create(AOwner: TComponent); override;
  end;

  TLeftDragHandle = class(TVerticalDragHandle)
  public
    procedure UpdatePosition(Control: TControl); override;
    constructor Create(AOwner: TComponent); override;
  end;

  TRightDragHandle = class(TVerticalDragHandle)
  public
    procedure UpdatePosition(Control: TControl); override;
    constructor Create(AOwner: TComponent); override;
  end;


  // Dot Handle
  TUpLeftDragHandle = class(TDotDrageHandle)
  public
    procedure UpdatePosition(Control: TControl); override;
    constructor Create(AOwner: TComponent); override;
  end;

  TUpRightDragHandle = class(TDotDrageHandle)
  public
    procedure UpdatePosition(Control: TControl); override;
    constructor Create(AOwner: TComponent); override;
  end;

  TDownLeftDragHandle = class(TDotDrageHandle)
  public
    procedure UpdatePosition(Control: TControl); override;
    constructor Create(AOwner: TComponent); override;
  end;

  TDownRightDragHandle = class(TDotDrageHandle)
  public
    procedure UpdatePosition(Control: TControl); override;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

procedure TDragDock.SetSize(const Value: Byte);
begin
  FSize := Value;
  Width := Value;
  Height := Value;
end;

procedure TDragDock.SetSizingOrigin(const X, Y: Integer);
var
  HalfWidth: Integer;
begin
  inherited;
  HalfWidth := Width div 2;
  if (X <> HalfWidth) then
  begin
    if (X > HalfWidth) then
      FClickOrigin.X := -(X mod HalfWidth)
    else
      FClickOrigin.X := HalfWidth - X;
  end;

  if (Y <> HalfWidth) then
  begin
    if (Y > HalfWidth) then
      FClickOrigin.Y := -(Y mod HalfWidth)
    else
      FClickOrigin.Y := HalfWidth - Y;
  end;
end;

constructor TUpDragHandle.Create;
begin
  inherited Create(AOwner);
  Cursor := crSizeNS;
  FVerticalFix := dBottom;
end;

constructor TDownDragHandle.Create;
begin
  inherited Create(AOwner);
  Cursor := crSizeNS;
  FVerticalFix := dTop;
end;

constructor TLeftDragHandle.Create;
begin
  inherited Create(AOwner);
  Cursor := crSizeWE;
  FHorizontalFix := dRight;
end;

constructor TRightDragHandle.Create;
begin
  inherited Create(AOwner);
  Cursor := crSizeWE;
  FHorizontalFix := dLeft;
end;

constructor TUpLeftDragHandle.Create;
begin
  inherited Create(AOwner);
  Cursor := crSizeNWSE;
  FHorizontalFix := dRight;
  FVerticalFix := dBottom;
end;

constructor TUpRightDragHandle.Create;
begin
  inherited Create(AOwner);
  Cursor := crSizeNESW;
  FHorizontalFix := dLeft;
  FVerticalFix := dBottom;
end;

constructor TDownLeftDragHandle.Create;
begin
  inherited Create(AOwner);
  Cursor := crSizeNESW;
  FHorizontalFix := dRight;
  FVerticalFix := dTop;
end;

constructor TDownRightDragHandle.Create;
begin
  inherited Create(AOwner);
  Cursor := crSizeNWSE;
  FHorizontalFix := dLeft;
  FVerticalFix := dTop;
end;

procedure TUpDragHandle.UpdatePosition(Control: TControl);
begin
  // 상단
  Width := Control.Width;
  Height := 2;

  Left := Control.Left;
  Top := Control.Top - (Height * 2);
end;

procedure TDownDragHandle.UpdatePosition(Control: TControl);
begin
  // 하단
  Width := Control.Width;
  Height := 2;

  Left := Control.Left;
  Top := Control.Top + Control.Height + (Height * 2);
end;

procedure TLeftDragHandle.UpdatePosition(Control: TControl);
begin
  // 좌측
//  Left := Control.Left - (Width div 2);
//  Top := Control.Top + ((Control.Height - Height) div 2);

  Width := 2;
  Height := Control.Height;

  Left := Control.Left - (Width * 2);
  Top := Control.Top;
end;

procedure TRightDragHandle.UpdatePosition(Control: TControl);
begin
  // 우측
  Left := Control.Left + Control.Width - (Width div 2);
  Top := Control.Top + ((Control.Height - Height) div 2);
end;

procedure TUpLeftDragHandle.UpdatePosition(Control: TControl);
begin
  // 좌측상단
  Left := Control.Left - Width;
  Top := Control.Top - Height;
end;

procedure TDownLeftDragHandle.UpdatePosition(Control: TControl);
begin
  // 좌측하단
  Left := Control.Left - Width;
  Top := Control.Top + Control.Height;
end;

procedure TUpRightDragHandle.UpdatePosition(Control: TControl);
begin
  // 우측상단
  Left := Control.BoundsRect.Right;
  Top := Control.Top - Height;
end;

procedure TDownRightDragHandle.UpdatePosition(Control: TControl);
begin
  // 우측하단
  Left := Control.BoundsRect.Right;
  Top := Control.Top + Control.Height;
end;

constructor TVerticalDragHandle.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TVerticalDragHandle.Paint;
begin
  inherited;

end;

constructor THorizontalDragHandle.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure THorizontalDragHandle.Paint;
begin
  inherited;

  Canvas.Pen.Color := FBorderColor;
  Canvas.FillRect(ClientRect);
  Canvas.Brush.Color := Color;
  Canvas.Rectangle(0, 0, BoundsRect.Width, BoundsRect.Height);
end;

procedure TMultiDirectionalDragHandle.UpdateChildSize(Sender: TControl; X, Y: Integer);
var
  DragRect: TRect;
  ChildRect: TRect;
  HorizontalFix, VerticalFix: Integer;
begin
  DragRect := FDockInterface.GetDragRect();
  ChildRect := FDockInterface.GetChildRect();
  HorizontalFix := GetRectSide(ChildRect, FHorizontalFix);
  VerticalFix := GetRectSide(ChildRect, FVerticalFix);
  with DragRect do
  begin
    if (X > HorizontalFix) and (Y > VerticalFix) then
    begin
      Left := HorizontalFix;
      Top := VerticalFix;
      Right := X + FClickOrigin.X;
      Bottom := Y + FClickOrigin.Y;
      FDockInterface.UpdateDragRect(DragRect, [dRight, dBottom]);
    end;
    if (X < HorizontalFix) and (Y > VerticalFix) then
    begin
      Left := X + FClickOrigin.X;
      Top := VerticalFix;
      Right := HorizontalFix;
      Bottom := Y + FClickOrigin.Y;
      FDockInterface.UpdateDragRect(DragRect, [dLeft, dBottom]);
    end;
    if (X > HorizontalFix) and (Y < VerticalFix) then
    begin
      Left := HorizontalFix;
      Top := Y + FClickOrigin.Y;
      Right := X + FClickOrigin.X;
      Bottom := VerticalFix;
      FDockInterface.UpdateDragRect(DragRect, [dRight, dTop]);
    end;
    if (X < HorizontalFix) and (Y < VerticalFix) then
    begin
      Left := X + FClickOrigin.X;
      Top := Y + FClickOrigin.Y;
      Right := HorizontalFix;
      Bottom := VerticalFix;
      FDockInterface.UpdateDragRect(DragRect, [dLeft, dTop]);
    end;
  end;
end;

constructor TDragDock.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Visible := False;
  FClickOrigin := TPoint.Zero;
  FBorderColor := RGB(0, 120, 215);
  Color := RGB(178, 214, 243);
end;

function TDragDock.GetRectSide(const Rect: TRect; Direction: TDirection): Integer;
var
  RectType: TRttiType;
  Field: TRttiField;
  DirectionStr: String;
begin
  DirectionStr := TRttiEnumerationType.GetName(Direction);
  Assert(DirectionStr.StartsWith('d'));
  DirectionStr := DirectionStr.Remove(0, 1);
  RectType := TRTTIContext.Create.GetType(TypeInfo(TRect));
  Field := RectType.GetField(DirectionStr);
  Result := Field.GetValue(@Rect).AsInteger;
end;

procedure TDragDock.Paint;
begin
  inherited;
  Canvas.Pen.Color := FBorderColor;
  Canvas.FillRect(ClientRect);
  Canvas.Brush.Color := Color;
  Canvas.Rectangle(0, 0, BoundsRect.Width, BoundsRect.Height);
end;

{ TDotDrageHandle }

constructor TDotDrageHandle.Create(AOwner: TComponent);
begin
  inherited;
  Size := 8;
end;

procedure TDotDrageHandle.Paint;
begin
  inherited;
  Canvas.Pen.Color := FBorderColor;
  Canvas.FillRect(ClientRect);
  Canvas.Brush.Color := Color;
  Canvas.Rectangle(0, 0, BoundsRect.Width, BoundsRect.Height);
end;

{ TLineDragHandle }

constructor TLineDragHandle.Create(AOwner: TComponent);
begin
  inherited;
end;

end.
