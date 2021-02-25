unit Dock.Interfaces;

interface

  uses Classes, Controls, Graphics, Windows, Messages, Forms, SysUtils, StdCtrls,
       System.Generics.Collections;

  type
    TDirection = (dBottom, dTop, dLeft, dRight);
    TDirections = set of TDirection;

    IDockInterface = Interface
      function GetDragRect: TRect;
      function GetChildRect: TRect;
      procedure UpdateDragRect(Rect: TRect; Direction: TDirections);
    End;

implementation

end.
