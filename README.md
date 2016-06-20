# Access Libary 1.0.0-prealpha

* Suports
  * Delphi Object
  * Delphi Generic Lists
  * XSuperObject
  * Coming Soon (XML Native, SuperObject, Json Natives....)

```Delphi
procedure Sample(APerson: IRecord);
begin
  ShowMessage(APerson['Name'].S);           //Allan Gomes
  ShowMessage(APerson['Age'].I);            //24
  ShowMessage(APerson['Contact.Number'].S); //8588888888
end;
```
------
######Delphi Object Sample
```delphi
type
  TContact = class
    Number: string;
  end;
  
  TPerson = class
  {...}
    property Name: string read FName write FName;
    property Age: Integer read FAge write FAge;
    property Contact: TContact read FContact write FContact;
    constructor Create(AName: string; AAge: Integer; AContactNumber: string);
  end;

begin
  person := TPerson.Create('Allan Gomes', 24, '8588888888');
  Sample(TObjectAccess.Create(person));
end;
```
------
######XSuper Object Sample
```json
{
  "Name": "Allan Gomes",
  "Age": 24,
  "Contact": {
    "Number": "8588888888"
  }
}
```
```delphi
var
  json: string;
begin
  Sample(TXSuperObject.Create(SO(json)));
end;
```
