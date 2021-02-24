unit Utils;

interface
  uses Winapi.Windows;

function MAKEPOINT(lParam: lParam) : TPoint;

implementation

function MAKEPOINT(lParam: lParam) : TPoint;
begin
  Result := TPoint.Create(Smallint(LoWord(lParam)), Smallint(HiWord(lParam)));
end;

end.
