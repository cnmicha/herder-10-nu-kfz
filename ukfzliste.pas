unit uKfzListe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, strutils, uDatensatz, Dialogs;

const
  maxAnz = 600; //array length

type
  TListe = class
  private
    liste: array [0..maxAnz - 1] of TDatensatz;
    anzahl: cardinal;
  public
    constructor Create;
    destructor Destroy;
    procedure einlesen(datname: string);
    procedure einlesenFilterKennzeichen(datname, query: string);
    procedure einlesenFilterOrt(datname, query: string);
    function binsuche(query: string): integer;
    procedure einlesenFilterBundesland(datname, query: string);
    function getAnz(): cardinal;
    function getKennzeichen(ItemIndex: cardinal): string;
    function getOrt(ItemIndex: cardinal): string;
    function getBundesland(ItemIndex: cardinal): string;
  end;



implementation

constructor TListe.Create;
begin

end;

destructor TListe.Destroy;
begin

end;

procedure TListe.einlesen(datname: string);
var
  f: TextFile;
  aktuell, j: cardinal;
  str: string;
  Data: TStringList;
begin
  AssignFile(f, datname);
  reset(f); //lock file
  aktuell := 0;

  while not EOF(f) do
  begin
    readln(f, str);

    //split str into array seperated by ";"
    Data := nil; //truncate array
    Data := TStringList.Create;
    Data.Delimiter := ';';
    Data.StrictDelimiter := True; //space is not a delimiter
    Data.DelimitedText := str;


    //BEGIN insertion sort

    j := aktuell;
    if length(liste) > 0 then
    begin
      while (j > 1) and (liste[j - 1].ort > Data[1]) do
      begin
        liste[j] := liste[j - 1];
        Dec(j);
      end;
      liste[j] := TDatensatz.Create;
      liste[j].definieren(Data[0], Data[1], Data[2]);
    end
    else
    begin
      liste[0] := TDatensatz.Create;
      liste[0].definieren(Data[0], Data[1], Data[2]);
    end;

    //END insertion sort


    Inc(aktuell);
  end;

  CloseFile(f);
  anzahl := aktuell;
end;

procedure TListe.einlesenFilterKennzeichen(datname, query: string);
var
  f: TextFile;
  aktuell: cardinal;
  str: string;
  Data: TStringList;
begin
  AssignFile(f, datname);
  reset(f);
  aktuell := 0;

  while not EOF(f) do
  begin
    readln(f, str);

    Data := nil; //truncate array
    Data := TStringList.Create;
    Data.Delimiter := ';';
    Data.StrictDelimiter := True; //space is not a delimiter
    Data.DelimitedText := str;

    if (AnsiContainsStr(LowerCase(Data[0]), LowerCase(query))) then
    begin
      liste[aktuell] := TDatensatz.Create;
      liste[aktuell].definieren(Data[0], Data[1], Data[2]);

      Inc(aktuell);
    end;
  end;

  CloseFile(f);
  anzahl := aktuell;
  aktuell := 0;

end;

procedure TListe.einlesenFilterOrt(datname, query: string);
var
  f: TextFile;
  aktuell: cardinal;
  str: string;
var
  Data: TStringList;
begin
  AssignFile(f, datname);
  reset(f);
  aktuell := 0;

  while not EOF(f) do
  begin
    readln(f, str);

    Data := nil; //truncate array
    Data := TStringList.Create;
    Data.Delimiter := ';';
    Data.StrictDelimiter := True; //space is not a delimiter
    Data.DelimitedText := str;

    if (AnsiContainsStr(LowerCase(Data[1]), LowerCase(query))) then
    begin
      liste[aktuell] := TDatensatz.Create;
      liste[aktuell].definieren(Data[0], Data[1], Data[2]);

      Inc(aktuell);
    end;
  end;

  CloseFile(f);
  anzahl := aktuell;
  aktuell := 0;

end;

function TListe.binsuche(query: string): integer;

  function mid(u, d: cardinal): cardinal;
  begin
    Result := (u + d) div 2;
  end;

var
  f: TextFile;
  aktuell: cardinal;
  str: string;
  low, up, splitCount: cardinal;

begin

  low := 0;
  up := aktuell - 1; //max anzahl
  splitCount := 1;

  while not (LowerCase(liste[mid(up, low)].ort) = LowerCase(query)) do
  begin
    if up - low = 0 then
    begin
      ShowMessage('str not found');
      exit;
    end;


    if LowerCase(liste[mid(up, low)].ort) > LowerCase(query) then
    begin
      up := mid(up, low);
      if up - low = 1 then
        Dec(up);
    end
    else
    begin
      low := mid(up, low);
      if up - low = 1 then
        Inc(up);
    end;

    Inc(splitCount);
  end;

  ShowMessage('found string "' + query + '" using ' + IntToStr(splitCount) + ' splits');

  anzahl := 1;
  aktuell := 0;
end;

procedure TListe.einlesenFilterBundesland(datname, query: string);
var
  f: TextFile;
  aktuell: cardinal;
  str: string;
var
  Data: TStringList;
begin
  AssignFile(f, datname);
  reset(f);
  aktuell := 0;

  while not EOF(f) do
  begin
    readln(f, str);

    Data := nil; //truncate array
    Data := TStringList.Create;
    Data.Delimiter := ';';
    Data.StrictDelimiter := True; //space is not a delimiter
    Data.DelimitedText := str;

    if (AnsiContainsStr(LowerCase(Data[2]), LowerCase(query))) then
    begin
      liste[aktuell] := TDatensatz.Create;
      liste[aktuell].definieren(Data[0], Data[1], Data[2]);

      Inc(aktuell);
    end;
  end;

  CloseFile(f);
  anzahl := aktuell;
  aktuell := 0;

end;

function TListe.getAnz(): cardinal;
begin
  Result := self.anzahl;
end;

function TListe.getKennzeichen(ItemIndex: cardinal): string;
begin
  Result := liste[ItemIndex].kennzeichen;
end;

function TListe.getOrt(ItemIndex: cardinal): string;
begin
  Result := liste[ItemIndex].ort;
end;

function TListe.getBundesland(ItemIndex: cardinal): string;
begin
  Result := liste[ItemIndex].bundesland;
end;

end.
