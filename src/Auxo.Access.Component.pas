unit Auxo.Access.Component;

interface

uses
  System.Classes, System.Generics.Collections;

type
  IComponentAccess = interface
    function GetName(AObj: TComponent): string;
    function IsEmpty(AObj: TComponent): Boolean;
    function GetValue(AObj: TComponent): Variant;
    procedure SetValue(AObj: TComponent; Value: Variant);
  end;

  TComponentAccess<T: TComponent> = class(TInterfacedObject, IComponentAccess)
  private
    FProperty: string;
    function GetName(AObj: TComponent): string; overload;
    function IsEmpty(AObj: TComponent): Boolean; overload;
    function GetValue(AObj: TComponent): Variant; overload;
    procedure SetValue(AObj: TComponent; Value: Variant); overload;
  protected
    function GetName(AObj: T): string; overload; virtual;
    function IsEmpty(AObj: T): Boolean; overload; virtual;
    function GetValue(AObj: T): Variant; overload; virtual;
    procedure SetValue(AObj: T; Value: Variant); overload; virtual;
    constructor Create(AProperty: string);
    class procedure Register(AProperty: string = '');
  end;

  TAccess = class
  private
    class var ObjectAccess: TDictionary<TComponentClass, IComponentAccess>;
    class constructor Create;
    class destructor Destroy;
    class function Get(AObj: TComponent): IComponentAccess; static;
  public
    class function GetName(AObj: TComponent): string;
    class function IsEmpty(AObj: TComponent): Boolean;
    class function GetValue(AObj: TComponent): Variant;
    class procedure SetValue(AObj: TComponent; Value: Variant);
    class function Registered(Component: TComponentClass): Boolean;
  end;

implementation

uses
  Auxo.Reflection.Core, System.Rtti;

{ TComponentAcessValue<T> }

function TComponentAccess<T>.GetName(AObj: TComponent): string;
begin
  Result := GetName(T(AObj));
end;

function TComponentAccess<T>.GetValue(AObj: TComponent): Variant;
begin
  Result := GetValue(T(AObj));
end;

function TComponentAccess<T>.IsEmpty(AObj: TComponent): Boolean;
begin
  Result := IsEmpty(T(AObj));
end;

procedure TComponentAccess<T>.SetValue(AObj: TComponent; Value: Variant);
begin
  SetValue(T(AObj), Value);
end;

constructor TComponentAccess<T>.Create(AProperty: string);
begin
  FProperty := AProperty;
end;

function TComponentAccess<T>.GetName(AObj: T): string;
begin
  Result := '';
  if AObj is TComponent then
    Result := TComponent(AObj).Name;
end;

function TComponentAccess<T>.GetValue(AObj: T): Variant;
begin
  if FProperty <> '' then
    Result := TReflection.GetProperty(AObj, FProperty).AsVariant;
end;

function TComponentAccess<T>.IsEmpty(AObj: T): Boolean;
begin
  Result := GetValue(AObj) = '';
end;

class procedure TComponentAccess<T>.Register(AProperty: string);
begin
  TAccess.ObjectAccess.Add(T, Self.Create(AProperty));
end;

procedure TComponentAccess<T>.SetValue(AObj: T; Value: Variant);
begin
  if FProperty <> '' then
    TReflection.SetProperty(AObj, FProperty, TValue.FromVariant(Value));
end;

{ TAccessList }

class constructor TAccess.Create;
begin
  ObjectAccess := TDictionary<TComponentClass, IComponentAccess>.Create;
end;

class destructor TAccess.Destroy;
begin
  ObjectAccess.Free;
end;

class function TAccess.Get(AObj: TComponent): IComponentAccess;
begin
  Result := ObjectAccess[TComponentClass(AObj.ClassType)];
end;

class function TAccess.GetName(AObj: TComponent): string;
begin
  Result := Get(AObj).GetName(AObj);
end;

class function TAccess.GetValue(AObj: TComponent): Variant;
begin
  Result := Get(AObj).GetValue(AObj);
end;

class function TAccess.IsEmpty(AObj: TComponent): Boolean;
begin
  Result := Get(AObj).IsEmpty(AObj);
end;

class function TAccess.Registered(Component: TComponentClass): Boolean;
begin
  Result := ObjectAccess.ContainsKey(Component);

end;

class procedure TAccess.SetValue(AObj: TComponent; Value: Variant);
begin
  Get(AObj).SetValue(AObj, Value);
end;

end.
