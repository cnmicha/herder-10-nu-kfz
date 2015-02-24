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
                      procedure einlesenFilterOrtBinaer (datname,query: String);
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

    liste[aktuell]:= TDatensatz.create;
    liste[aktuell].definieren(data[0],data[1],data[2]);

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

procedure TListe.einlesenFilterOrtBinaer (datname,query: String);
function mid(u,d:cardinal):CARDINAL;
begin
  result:=Round((u+d)/2); //returns upper mid value
end;

var f : TextFile;
aktuell: CARDINAL;
str : string;
low, up, splitCount : cardinal;
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


    liste[aktuell]:= TDatensatz.create;
    liste[aktuell].definieren(data[0],data[1],data[2]); //set instance vars

    INC(aktuell);
  end;

  CloseFile(f);

  low := 0;
  up := aktuell-1; //max anzahl
  splitCount:=1;

  while not (LowerCase(liste[mid(up,low)].ort) = LowerCase(query)) do
  begin
    //ShowMessage('###');
    //ShowMessage(IntToStr(low) + '|' + IntToStr(up));

    if up-low = 0 then
    begin
      ShowMessage('str not found');
      exit;
    end;

    //ShowMessage('get:' + IntToStr(mid(up,low)) + ' ' + LowerCase(liste[mid(up,low)].ort));


    if LowerCase(liste[mid(up,low)].ort) > LowerCase(query) then
    begin
      //ShowMessage(LowerCase(liste[mid(up,low)].ort) + ' is bigger than ' + LowerCase(query));

      up:=mid(up,low);
      if up-low = 1 then dec(up);
    end
    else
    begin
      //ShowMessage(LowerCase(liste[mid(up,low)].ort) + ' is smaller than ' + LowerCase(query));

      low:=mid(up,low);
      if up-low = 1 then inc(up);

    end;

    inc(splitCount);
  end;

  //ShowMessage('###');
  //ShowMessage(IntToStr(low) + '|' + IntToStr(up));
  //ShowMessage('get:' + IntToStr(mid(up,low)) + ' ' + LowerCase(liste[mid(up,low)].ort));
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

