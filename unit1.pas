unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, Grids, uKfzListe;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    dbgKennz: TDBGrid;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.Button1Click(Sender: TObject);
var liste: TListe;
var i: CARDINAL;
begin
     liste := TListe.create;
     liste.einlesen('kfz.csv');

     for i:= 0 to liste.getAnz()-1 do
     begin
       //TODO
       //dbgKennz.Records.Add(...);
     end;
end;

end.

