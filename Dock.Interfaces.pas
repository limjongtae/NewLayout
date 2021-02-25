unit Dock.Interfaces;

interface

  uses BaseDock, Classes, Controls, Graphics, Windows, Messages, Forms, SysUtils, StdCtrls,
       System.Generics.Collections;

  type
    IDockInterface = Interface
      procedure AddDock(Dock: TBaseDock);
      procedure DeleteDock(Dock: TBaseDock);
    End;

implementation

end.
