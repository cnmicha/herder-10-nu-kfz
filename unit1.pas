unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, Grids, Buttons, uKfzListe;

type

  { TForm1 }

  TForm1 = class(TForm)
    bnLesen: TButton;
    bnSucheKennz: TButton;
    bnSucheOrt: TButton;
    bnSucheBundesland: TButton;
    lbSucheKennz: TEdit;
    lbSucheOrt: TEdit;
    lbSucheBundesland: TEdit;
    Label1: TLabel;
    lbAnzahl: TLabel;
    lstKennz: TListBox;
    procedure bnLesenClick(Sender: TObject);
    procedure bnSucheBundeslandClick(Sender: TObject);
    procedure bnSucheOrtClick(Sender: TObject);
    procedure display(listbox: TListBox; anzLabel: TLabel; liste: TListe);
    procedure bnSucheKennzClick(Sender: TObject);
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


procedure TForm1.bnLesenClick(Sender: TObject);
var liste: TListe;
begin
     liste:= TListe.create;
     liste.einlesen('kfz.csv');

     display(lstKennz, lbAnzahl, liste);
end;

procedure TForm1.bnSucheBundeslandClick(Sender: TObject);
var liste: TListe;
begin
     liste:= TListe.create;
     liste.einlesenSucheBundesland('kfz.csv', lbSucheBundesland.text);

     display(lstKennz, lbAnzahl, liste);
end;

procedure TForm1.bnSucheOrtClick(Sender: TObject);
var liste: TListe;
begin
     liste:= TListe.create;
     liste.einlesenSucheOrt('kfz.csv', lbSucheOrt.Text);

     display(lstKennz, lbAnzahl, liste);
end;

procedure TForm1.display(listbox: TListBox; anzLabel: TLabel; liste: TListe);
var i: CARDINAL;
begin
     listbox.items.Clear;

     if(liste.getAnz > 0) then
     begin
       for i:= 0 to liste.getAnz-1 do
       begin
         listbox.Items.Add(liste.getKennzeichen(i) + ' | ' + liste.getOrt(i) + ' | ' + liste.getBundesland(i));
       end;
     end;

     anzLabel.caption:= 'Gesamt: ' + intToStr(liste.getAnz);
end;

procedure TForm1.bnSucheKennzClick(Sender: TObject);
var liste: TListe;
begin

     liste:= TListe.create;
     liste.einlesenSucheKennzeichen('kfz.csv', lbSucheKennz.text);

     display(lstKennz, lbAnzahl, liste);
end;

end.

