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
    bnFilterOrtBinaer: TButton;
    lbIndex: TEdit;
    lbSucheKennz: TEdit;
    lbSucheOrt: TEdit;
    lbSucheBundesland: TEdit;
    lbAnzahl: TLabel;
    dgvKfz: TStringGrid;
    procedure bnIndexClick(Sender: TObject);
    procedure bnLesenClick(Sender: TObject);
    procedure bnFilterBundeslandClick(Sender: TObject);
    procedure bnFilterOrtClick(Sender: TObject);
    procedure bnFilterOrtBinaerClick(Sender: TObject);
    procedure display(dgv: TStringGrid; anzLabel: TLabel; liste: TListe);
    procedure displayIndex(dgv: TStringGrid; anzLabel: TLabel;
      liste: TListe; index: cardinal);
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
var
  liste: TListe;
begin
  liste := TListe.Create;
  liste.einlesen('kfz.csv');

  display(dgvKfz, lbAnzahl, liste);
end;

procedure TForm1.bnIndexClick(Sender: TObject);
var
  liste: TListe;
begin
  liste := TListe.Create;
  liste.einlesen('kfz.csv');

  displayIndex(dgvKfz, lbAnzahl, liste, StrToInt(lbIndex.Text));
end;

procedure TForm1.bnFilterBundeslandClick(Sender: TObject);
var
  liste: TListe;
begin
  liste := TListe.Create;
  liste.einlesenFilterBundesland('kfz.csv', lbSucheBundesland.Text);

  display(dgvKfz, lbAnzahl, liste);
end;

procedure TForm1.bnFilterOrtClick(Sender: TObject);
var
  liste: TListe;
begin
  liste := TListe.Create;
  liste.einlesenFilterOrt('kfz.csv', lbSucheOrt.Text);

  display(dgvKfz, lbAnzahl, liste);
end;

procedure TForm1.bnFilterOrtBinaerClick(Sender: TObject);
var
  liste: TListe;
begin
  liste := TListe.Create;
  liste.einlesen('kfz.csv');
  ShowMessage(IntToStr(liste.binsuche(lbSucheKennz.Text)));

  //display(lstKennz, lbAnzahl, liste);
end;

procedure TForm1.display(dgv: TStringGrid; anzLabel: TLabel; liste: TListe);
var
  i, C, newRow: cardinal;
begin

  for i := 1 to dgv.RowCount - 1 do //clear rows
    dgv.DeleteRow(1);

  if (liste.getAnz > 0) then
  begin
    for i := 0 to liste.getAnz - 1 do
    begin
      //add row
      //todo
      //dgv.InsertRowWithValues(i+1, [IntToStr(i), liste.getKennzeichen(i), liste.getOrt(i), liste.getBundesland(i)]);

      newRow := dgv.RowCount;
      dgv.RowCount := dgv.RowCount + 1;

      dgv.Cells[0, newRow] := IntToStr(i + 1);
      dgv.Cells[1, newRow] := liste.getKennzeichen(i);
      dgv.Cells[2, newRow] := liste.getOrt(i);
      dgv.Cells[3, newRow] := liste.getBundesland(i);
    end;
  end;

  anzLabel.Caption := 'Gesamt: ' + IntToStr(liste.getAnz);
end;

procedure TForm1.displayIndex(dgv: TStringGrid; anzLabel: TLabel;
  liste: TListe; index: cardinal);
var
  i: cardinal;
begin
  for i := 1 to dgv.RowCount - 1 do //clear rows
    dgv.DeleteRow(1);

  //add row
  //todo //dgv.InsertRowWithValues(1, [IntToStr(index),liste.getKennzeichen(index), liste.getOrt(index), liste.getBundesland(index)]);

  anzLabel.Caption := 'Gesamt: 1';
end;

procedure TForm1.bnFilterKennzClick(Sender: TObject);
var
  liste: TListe;
begin

  liste := TListe.Create;
  liste.einlesenFilterKennzeichen('kfz.csv', lbSucheKennz.Text);

  display(dgvKfz, lbAnzahl, liste);
end;

end.
