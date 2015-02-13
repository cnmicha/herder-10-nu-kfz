unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, Grids, Buttons, uKfzListe;

type

  { TForm1 }

  TForm1 = class(TForm)
    bnIndex: TButton;
    bnLesen: TButton;
    bnFilterKennz: TButton;
    bnFilterOrt: TButton;
    bnFilterBundesland: TButton;
    bnFilterOrtIntelli: TButton;
    lbIndex: TEdit;
    lbSucheKennz: TEdit;
    lbSucheOrt: TEdit;
    lbSucheBundesland: TEdit;
    Label1: TLabel;
    lbAnzahl: TLabel;
    lstKennz: TListBox;
    procedure bnIndexClick(Sender: TObject);
    procedure bnLesenClick(Sender: TObject);
    procedure bnFilterBundeslandClick(Sender: TObject);
    procedure bnFilterOrtClick(Sender: TObject);
    procedure bnFilterOrtIntelliClick(Sender: TObject);
    procedure display(listbox: TListBox; anzLabel: TLabel; liste: TListe);
    procedure displayIndex(listbox: TListBox; anzLabel: TLabel; liste: TListe; index: CARDINAL);
    procedure bnFilterKennzClick(Sender: TObject);
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

procedure TForm1.bnIndexClick(Sender: TObject);
var liste: TListe;
begin
     liste:= TListe.create;
     liste.einlesen('kfz.csv');

     displayIndex(lstKennz, lbAnzahl, liste, StrToInt(lbIndex.Text));
end;

procedure TForm1.bnFilterBundeslandClick(Sender: TObject);
var liste: TListe;
begin
     liste:= TListe.create;
     liste.einlesenFilterBundesland('kfz.csv', lbSucheBundesland.text);

     display(lstKennz, lbAnzahl, liste);
end;

procedure TForm1.bnFilterOrtClick(Sender: TObject);
var liste: TListe;
begin
     liste:= TListe.create;
     liste.einlesenFilterOrt('kfz.csv', lbSucheOrt.Text);

     display(lstKennz, lbAnzahl, liste);
end;

procedure TForm1.bnFilterOrtIntelliClick(Sender: TObject);
var liste: TListe;
begin
     liste:= TListe.create;
     liste.einlesenFilterOrtIntelli('kfz.csv', lbSucheOrt.Text);

     //display(lstKennz, lbAnzahl, liste);
end;

procedure TForm1.display(listbox: TListBox; anzLabel: TLabel; liste: TListe);
var i: CARDINAL;
begin
     listbox.items.Clear;

     if(liste.getAnz > 0) then
     begin
       for i:= 0 to liste.getAnz-1 do
       begin
         listbox.Items.Add(IntToStr(i) + ' | ' + liste.getKennzeichen(i) + ' | ' + liste.getOrt(i) + ' | ' + liste.getBundesland(i));
       end;
     end;

     anzLabel.caption:= 'Gesamt: ' + intToStr(liste.getAnz);
end;

procedure TForm1.displayIndex(listbox: TListBox; anzLabel: TLabel; liste: TListe; index: CARDINAL);
var i: CARDINAL;
begin
     listbox.items.Clear;
     listbox.Items.Add(liste.getKennzeichen(index) + ' | ' + liste.getOrt(index) + ' | ' + liste.getBundesland(index));

     anzLabel.caption:= 'Gesamt: 1';
end;

procedure TForm1.bnFilterKennzClick(Sender: TObject);
var liste: TListe;
begin

     liste:= TListe.create;
     liste.einlesenFilterKennzeichen('kfz.csv', lbSucheKennz.text);

     display(lstKennz, lbAnzahl, liste);
end;

end.

