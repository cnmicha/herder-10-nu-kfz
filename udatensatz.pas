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
                procedure definieren (user_kennz,user_ort,user_bundesland: String);
                {*function getKennz: String;
                function getOrt: String;
                function getBL: String;*}
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

    {*procedure TDatensatz.definieren(datenstring: String);
var data:TStringList;
begin
     data:= TStringList.Create;
     data.Delimiter := ';';
     data.StrictDelimiter := True; //space is not a delimiter
     data.DelimitedText := datenstring;

     self.kennzeichen := data[0];
     self.ort := data[1];
     self.bundesland := data[2];
end;    *}

procedure TDatensatz.definieren (user_kennz,user_ort,user_bundesland: String);
begin
  self.kennzeichen := user_kennz;
  self.ort := user_ort;
  self.bundesland := user_bundesland
end;

{*function TDatensatz.getKennz: String;
begin
  result := kennzeichen;
end;

function TDatensatz.getOrt: String;
begin
  result := ort;
end;

function TDatensatz.getBL: String;
begin
  result := bundesland;
end; *}

end.

