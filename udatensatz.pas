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
                procedure setKennzeichen(kennzeichenStr: String);
                procedure setOrt(ortStr: String);
                procedure setBudesland(bundeslandStr: String);
                function getKennzeichen(): String;
                function getOrt(): String;
                function getBundesland(): String;

     end;



implementation

constructor TDatensatz.create;
begin

end;

destructor TDatensatz.destroy;
begin

end;

procedure TDatensatz.definieren(datenstring: String);
var data:TStringList;
begin
     data := TStringList.Create;
     data.Delimiter := ';';
     data.StrictDelimiter := True; //space is not a delimiter
     data.DelimitedText := datenstring;

     self.kennzeichen := data[0];
     self.ort := data[1];
     self.bundesland := data[2];
end;

procedure TDatensatz.setKennzeichen(kennzeichenStr: String);
begin
     self.kennzeichen := kennzeichenStr;
end;

procedure TDatensatz.setOrt(ortStr: String);
begin
     self.ort := ortStr;
end;

procedure TDatensatz.setBudesland(bundeslandStr: String);
begin
     self.bundesland := bundeslandStr;
end;

function TDatensatz.getKennzeichen(): String;
begin
     result := self.kennzeichen;
end;

function TDatensatz.getOrt(): String;
begin
     result := self.ort;
end;

function TDatensatz.getBundesland(): String;
begin
     result := self.bundesland;
end;

end.

