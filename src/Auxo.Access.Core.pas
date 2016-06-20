unit Auxo.Access.Core;

interface

type
  IRecordList = interface;
  IRecord = interface;

  IRecordList = interface(IEnumerable<IRecord>)
    function Count: Integer;
    function GetObject(AIndex: Integer): IRecord;
    procedure SetObject(AIndex: Integer; const Value: IRecord);
    procedure Add(Value: IRecord);
    procedure Delete(AIndex: Integer);
    property O[AIndex: Integer]: IRecord read GetObject write SetObject; default;
    function ToString: string;
  end;

  IRecord = interface
    function GetValue(Name: string): Variant; overload;
    procedure SetValue(Name: string; const AValue: Variant);
    function GetDateTime(Name: string): TDateTime;
    function GetFloat(Name: string): Extended;
    function GetInteger(Name: string): Int64;
    function GetList(Name: string): IRecordList;
    function GetObject(Name: string): IRecord;
    function GetString(Name: string): string;
    function GetBoolean(Name: string): Boolean;
    procedure SetDateTime(Name: string; const Value: TDateTime);
    procedure SetFloat(Name: string; const Value: Extended);
    procedure SetInteger(Name: string; const Value: Int64);
    procedure SetList(Name: string; const Value: IRecordList);
    procedure SetObject(Name: string; const Value: IRecord);
    procedure SetString(Name: string; const Value: string);
    procedure SetBoolean(Name: string; const Value: Boolean);

    function ToString: string;

    property V[Name: string]: Variant read GetValue write SetValue; default;
    property S[Name: string]: string read GetString write SetString;
    property D[Name: string]: TDateTime read GetDateTime write SetDateTime;
    property B[Name: string]: Boolean read GetBoolean write SetBoolean;
    property F[Name: string]: Extended read GetFloat write SetFloat;
    property I[Name: string]: Int64 read GetInteger write SetInteger;
    property O[Name: string]: IRecord read GetObject write SetObject;
    property L[Name: string]: IRecordList read GetList write SetList;
  end;

implementation


end.
