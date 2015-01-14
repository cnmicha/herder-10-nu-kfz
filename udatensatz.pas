unit uDatensatz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

TYPE TDatensatz = class
                kennzeichen: String;
                ort: String;
                bundesland: String;
                constructor create;
                destructor destroy;
                procedure definieren (datenstring: String);
     end;



implementation

constructor TDatensatz.create;
begin
     self.kennzeichen:= '';
     self.ort:= '';
     self.bundesland:= '';
end;

destructor TDatensatz.destroy;
begin

end;

procedure TDatensatz.definieren(datenstring: String);
var data:TStringList;
begin
     data:= TStringList.Create;
     data.Delimiter := ';';
     data.StrictDelimiter := True; //space is not a delimiter
     data.DelimitedText := datenstring;

     self.kennzeichen := data[0];
     self.ort := data[1];
     self.bundesland := data[2];
end;

end.

