unit uKfzListe;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, strutils, uDatensatz, Dialogs;

const maxAnz= 600; //array length

TYPE TListe = class
                private
                       liste: ARRAY [0..maxAnz-1] OF TDatensatz;
                       anzahl: CARDINAL;
                public
                      constructor create;
                      destructor destroy;
                      procedure einlesen (datname: String);
                      procedure einlesenFilterKennzeichen (datname,query: String);
                      procedure einlesenFilterOrt (datname,query: String);
                      function binsuche (query: String):INTEGER;
                      procedure einlesenFilterBundesland (datname,query: String);
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
aktuell: CARDINAL;
str : string;
data:TStringList;
begin
  AssignFile(f,datname);
  reset(f); //lock file
  aktuell:=0;

  while not EOF (f) do
  begin
    readln(f,str);

    data:= NIL; //truncate array
    data:= TStringList.Create;
    data.Delimiter := ';';
    data.StrictDelimiter := True; //space is not a delimiter
    data.DelimitedText := str;

    //BEGIN insertion sort

    // ...

    liste[aktuell]:= TDatensatz.create;
    liste[aktuell].definieren(data[0],data[1],data[2]);

    //END insertion sort

    INC(aktuell);
  end;

  CloseFile(f);
  anzahl:= aktuell;
end;

procedure TListe.einlesenFilterKennzeichen (datname,query: String);
var f : TextFile;
aktuell: CARDINAL;
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
      liste[aktuell].definieren(data[0],data[1],data[2]);

      INC(aktuell);
    end;
  end;

  CloseFile(f);
  anzahl:= aktuell;
  aktuell:= 0;

end;

procedure TListe.einlesenFilterOrt (datname,query: String);
var f : TextFile;
aktuell: CARDINAL;
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
      liste[aktuell].definieren(data[0],data[1],data[2]);

      INC(aktuell);
    end;
  end;

  CloseFile(f);
  anzahl:= aktuell;
  aktuell:= 0;

end;

function TListe.binsuche (query: String):INTEGER;
function mid(u,d:cardinal):CARDINAL;
begin
  result:=(u+d) div 2;
end;

var f : TextFile;
aktuell: CARDINAL;
str : string;
low, up, splitCount : cardinal;

begin

  low := 0;
  up := aktuell-1; //max anzahl
  splitCount:=1;

  while not (LowerCase(liste[mid(up,low)].ort) = LowerCase(query)) do
  begin
    if up-low = 0 then
    begin
      ShowMessage('str not found');
      exit;
    end;


    if LowerCase(liste[mid(up,low)].ort) > LowerCase(query) then
    begin
      up:=mid(up,low);
      if up-low = 1 then dec(up);
    end
    else
    begin
      low:=mid(up,low);
      if up-low = 1 then inc(up);
    end;

    inc(splitCount);
  end;

  ShowMessage('found string "' + query + '" using ' + IntToStr(splitCount) + ' splits');

  anzahl:= 1;
  aktuell:= 0;
end;

procedure TListe.einlesenFilterBundesland (datname,query: String);
var f : TextFile;
aktuell: CARDINAL;
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
      liste[aktuell].definieren(data[0],data[1],data[2]);

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

