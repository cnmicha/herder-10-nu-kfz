unit uDatensatz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

TYPE TDatensatz = class
                kennzeichen: String;
                ort: String;
                bundesland: String;
                //constructor create;
                //destructor destroy;
                procedure definieren (datenstring: String);
     end;



implementation

procedure TDatensatz.definieren(datenstring: String);
begin

end;

end.

