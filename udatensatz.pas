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

procedure TDatensatz.definieren (datenstring: String);
  var p: Cardinal;
begin
  p := pos(';', datenstring);
  Kennzeichen := copy(datenstring, 1, p-1);
  delete(datenstring, 1, p);

  p := pos(';', datenstring);
  Ort := copy(datenstring, 1, p-1);
  delete(datenstring, 1, p);

  p := pos(';', datenstring);

  Bundesland := datenstring
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

