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
                      //constructor create;
                      //destructor destroy;
                      procedure einlesen (datname: String);
     end;



implementation

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
    liste[aktuell].definieren (str);
    INC (aktuell);
  end;

  CloseFile(f);
  anzahl:=aktuell;
  aktuell:=0;

 end;
end.

