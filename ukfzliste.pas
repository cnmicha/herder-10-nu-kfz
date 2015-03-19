unit uKfzListe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, strutils, uDatensatz, Dialogs;

type
  TListe = class
  private
    liste: array of TDatensatz;
    anzahl: cardinal;
  public
    constructor Create;
    destructor Destroy;
    procedure einlesen(datname: string);
    procedure einlesenFilterKennzeichen(datname, query: string);
    procedure einlesenFilterOrt(datname, query: string);
    procedure einlesenFilterBundesland(datname, query: string);
    function getAnz(): cardinal;
    function getKennzeichen(ItemIndex: cardinal): string;
    function getOrt(ItemIndex: cardinal): string;
    function getBundesland(ItemIndex: cardinal): string;
    function KFZ_suchen(query: string): integer;
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

    SetLength(liste, length(liste) + 1);

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
      SetLength(liste, 1);
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

function TListe.KFZ_suchen(query: string): integer;

  function binsuche(ug, og: cardinal): integer;
  var
    mitte: cardinal;
  begin
    if ug <= og then
    begin
      mitte := (ug + og) div 2;
      //ShowMessage(liste[mitte].ort);

      if LowerCase(Liste[mitte].ort) > LowerCase(query) then
        Result := binsuche(ug, mitte - 1)
      else if LowerCase(liste[mitte].ort) < LowerCase(query) then
        Result := binsuche(mitte + 1, og)
      else
        Result := mitte;
    end
    else
      Result := -1; //no matching item found
  end;

begin
  Result := binsuche(0, self.anzahl - 1);
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
