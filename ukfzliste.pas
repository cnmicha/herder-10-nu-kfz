unit uKfzListe;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, strutils, uDatensatz;

const maxAnz= 600;

TYPE TListe = class
                private
                       liste: ARRAY [0..maxAnz-1] OF TDatensatz;
                       anzahl: CARDINAL;
                       aktuell: CARDINAL;
                public
                      constructor create;
                      destructor destroy;
                      procedure einlesen (datname: String);
                      procedure einlesenSucheKennzeichen (datname,query: String);
                      procedure einlesenSucheOrt (datname,query: String);
                      procedure einlesenSucheBundesland (datname,query: String);
                      function getAnz():CARDINAL;
                      function getKennzeichen(Itemindex:CARDINAL):STRING;
                      function getOrt(ItemIndex:CARDINAL):STRING;
                      function getBundesland(ItemIndex:CARDINAL):STRING;
     end;



implementation

constructor TListe.create;
begin

end;

destructor TListe.destroy;
begin

end;

procedure TListe.einlesen(datname:string);
var f : TextFile;
str : string;
begin
  AssignFile(f,datname);
  reset(f);
  aktuell:=0;

  while not EOF (f) do
  begin
    readln(f,str);

    liste[aktuell]:= TDatensatz.create;
    liste[aktuell].definieren(str);

    INC(aktuell);
  end;

  CloseFile(f);
  anzahl:= aktuell;
  aktuell:= 0;
end;

procedure TListe.einlesenSucheKennzeichen (datname,query: String);
var f : TextFile;
str : string;
data:TStringList;
begin
  AssignFile(f,datname);
  reset(f);
  aktuell:=0;

  while not EOF (f) do
  begin
    readln(f,str);

    data:= NIL; //truncate array
    data:= TStringList.Create;
    data.Delimiter := ';';
    data.StrictDelimiter := True; //space is not a delimiter
    data.DelimitedText := str;

    if(AnsiContainsStr(LowerCase(data[0]), LowerCase(query))) then
    begin
      liste[aktuell]:= TDatensatz.create;
      liste[aktuell].definieren(str);

      INC(aktuell);
    end;
  end;

  CloseFile(f);
  anzahl:= aktuell;
  aktuell:= 0;

end;

procedure TListe.einlesenSucheOrt (datname,query: String);
var f : TextFile;
str : string;
var data:TStringList;
begin
  AssignFile(f,datname);
  reset(f);
  aktuell:=0;

  while not EOF (f) do
  begin
    readln(f,str);

    data:= NIL; //truncate array
    data:= TStringList.Create;
    data.Delimiter := ';';
    data.StrictDelimiter := True; //space is not a delimiter
    data.DelimitedText := str;

    if(AnsiContainsStr(LowerCase(data[1]), LowerCase(query))) then
    begin
      liste[aktuell]:= TDatensatz.create;
      liste[aktuell].definieren(str);

      INC(aktuell);
    end;
  end;

  CloseFile(f);
  anzahl:= aktuell;
  aktuell:= 0;

end;

procedure TListe.einlesenSucheBundesland (datname,query: String);
var f : TextFile;
str : string;
var data:TStringList;
begin
  AssignFile(f,datname);
  reset(f);
  aktuell:=0;

  while not EOF (f) do
  begin
    readln(f,str);

    data:= NIL; //truncate array
    data:= TStringList.Create;
    data.Delimiter := ';';
    data.StrictDelimiter := True; //space is not a delimiter
    data.DelimitedText := str;

    if(AnsiContainsStr(LowerCase(data[2]), LowerCase(query))) then
    begin
      liste[aktuell]:= TDatensatz.create;
      liste[aktuell].definieren(str);

      INC(aktuell);
    end;
  end;

  CloseFile(f);
  anzahl:= aktuell;
  aktuell:= 0;

end;

function TListe.getAnz():CARDINAL;
begin
  result:= self.anzahl;
end;

function TListe.getKennzeichen(Itemindex:CARDINAL):STRING;
begin
  result:= liste[ItemIndex].kennzeichen;
end;

function TListe.getOrt(Itemindex:CARDINAL):STRING;
begin
  result:= liste[ItemIndex].ort;
end;

function TListe.getBundesland(Itemindex:CARDINAL):STRING;
begin
  result:= liste[ItemIndex].bundesland;
end;

end.

