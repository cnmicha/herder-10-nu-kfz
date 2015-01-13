unit uKfzListe;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, uDatensatz;

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
    readln (f,str);

    liste[aktuell] := TDatensatz.create;
    liste[aktuell].definieren (str);

    INC (aktuell);
  end;

  CloseFile(f);
  anzahl:=aktuell + 1;
  aktuell:=0;
end;

function TListe.getAnz():CARDINAL;
begin
  result:= Length(liste);
end;

function TListe.getKennzeichen(Itemindex:CARDINAL):STRING;
begin
  result:= liste[ItemIndex].getKennzeichen;
end;

function TListe.getOrt(Itemindex:CARDINAL):STRING;
begin
  result:= liste[ItemIndex].getOrt;
end;

function TListe.getBundesland(Itemindex:CARDINAL):STRING;
begin
  result:= liste[ItemIndex].getBundesland;
end;

end.

