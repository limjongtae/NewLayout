unit DockList;

interface

   uses BaseDock, Dock.Interfaces,
        System.Generics.Collections, Classes;

   type
     TDockList = class(TBaseDock, IDockInterface)
     private
       FList: TList<TBaseDock>;
       procedure AddDock(Dock: TBaseDock);
       procedure DeleteDock(Dock: TBaseDock);
     public
       constructor Create;
       destructor Destroy; override;
     end;

implementation

{ TDockList }
procedure TDockList.AddDock(Dock: TBaseDock);
begin

end;

constructor TDockList.Create;
begin

end;



procedure TDockList.DeleteDock(Dock: TBaseDock);
begin

end;

destructor TDockList.Destroy;
begin

  inherited;
end;

end.
