unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox,
  FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, FMX.Edit, FMX.Objects, FMX.Memo.Types;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItemSelectMatch: TTabItem;
    TabItemDisplayMatch: TTabItem;
    ComboBox1: TComboBox;
    Layout2: TLayout;
    ComboBox2: TComboBox;
    Layout3: TLayout;
    ComboBox3: TComboBox;
    Layout4: TLayout;
    Button1: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Edit1: TEdit;
    Layout5: TLayout;
    Layout6: TLayout;
    Edit2: TEdit;
    Label3: TLabel;
    Layout7: TLayout;
    Edit3: TEdit;
    Label4: TLabel;
    Layout8: TLayout;
    Label5: TLabel;
    Layout9: TLayout;
    Label6: TLabel;
    Button2: TButton;
    Layout10: TLayout;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Layout11: TLayout;
    Label7: TLabel;
    Edit6: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    RESTClient2: TRESTClient;
    RESTResponse2: TRESTResponse;
    RESTRequest2: TRESTRequest;
    RESTClient3: TRESTClient;
    RESTClient4: TRESTClient;
    RESTRequest3: TRESTRequest;
    RESTRequest4: TRESTRequest;
    RESTResponse3: TRESTResponse;
    RESTResponse4: TRESTResponse;
    RESTClient5: TRESTClient;
    RESTRequest5: TRESTRequest;
    RESTResponse5: TRESTResponse;
    TabControl2: TTabControl;
    TabItemAccueil: TTabItem;
    TabItemMatchs: TTabItem;
    TabItemButeuses: TTabItem;
    Button3: TButton;
    Rectangle1: TRectangle;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    TabControl3: TTabControl;
    TabItemButeusesAccueil: TTabItem;
    TabItemNouvelleButeuse: TTabItem;
    TabItemModifierButeuse: TTabItem;
    TabItemSupprimerButeuse: TTabItem;
    ComboBoxNewButCompet: TComboBox;
    Layout12: TLayout;
    Layout13: TLayout;
    ComboBoxNewButClub: TComboBox;
    Layout14: TLayout;
    ComboBoxNewButButeuse: TComboBox;
    Layout15: TLayout;
    Edit4: TEdit;
    Button8: TButton;
    RESTClient6: TRESTClient;
    RESTRequest6: TRESTRequest;
    RESTResponse6: TRESTResponse;
    Layout17: TLayout;
    ComboBoxNewButJournee: TComboBox;
    Layout16: TLayout;
    Edit5: TEdit;
    SpeedButton1: TSpeedButton;
    RESTClient7: TRESTClient;
    RESTRequest7: TRESTRequest;
    RESTResponse7: TRESTResponse;
    RESTClient8: TRESTClient;
    RESTRequest8: TRESTRequest;
    RESTResponse8: TRESTResponse;
    RESTClient9: TRESTClient;
    RESTRequest9: TRESTRequest;
    RESTResponse9: TRESTResponse;
    RESTRequest10: TRESTRequest;
    RESTClient10: TRESTClient;
    RESTResponse10: TRESTResponse;
    Layout18: TLayout;
    ComboBoxModifierButeuseCompet: TComboBox;
    Layout19: TLayout;
    ComboBoxModifierButeuseClubs: TComboBox;
    Layout20: TLayout;
    ComboBoxModifierButeuseButeuse: TComboBox;
    Layout22: TLayout;
    Edit8: TEdit;
    Layout23: TLayout;
    ComboBoxModifierButeuseJournee: TComboBox;
    Button9: TButton;
    RESTClient11: TRESTClient;
    RESTRequest11: TRESTRequest;
    RESTResponse11: TRESTResponse;
    RESTClient12: TRESTClient;
    RESTRequest12: TRESTRequest;
    RESTResponse12: TRESTResponse;
    RESTClient13: TRESTClient;
    RESTRequest13: TRESTRequest;
    RESTResponse13: TRESTResponse;
    Layout21: TLayout;
    EditModifierButeuseNom: TEdit;
    RESTClient14: TRESTClient;
    RESTRequest14: TRESTRequest;
    RESTResponse14: TRESTResponse;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBoxNewButCompetChange(Sender: TObject);
    procedure ComboBoxNewButClubChange(Sender: TObject);
    procedure ComboBoxNewButButeuseChange(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComboBoxModifierButeuseCompetChange(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ComboBoxModifierButeuseButeuseChange(Sender: TObject);
  private
    matchids: TStringList;
    clubsids: TStringList;
    buteusesids: TStringList;
    procedure RequestDate;
    procedure RequestCompet(date: string);
    procedure RequestMatch(date, compet: string);
    function RequestCompetButeuse: TStringList;
    function RequestJourneeButeuse(compet: string): TStringList;
    function RequestClubsButeuse(compet: string): TStringList;
    function RequestButeusesClub(club: Integer): TStringList;
    function RequestButeusesCompet(compet: string): TStringList;
    procedure UpdateMatch(Matchid: string; forfait1, forfait2: boolean;
      buteuses1, buteuses2, score: string);
    procedure AddBut(compet, journee: string; indexClub: Integer;
      buteuse: string; indexButeuse: Integer; buts: string;
      isNewButeuse: boolean);
    procedure EditBut(indexButeuse: Integer; nomButeuse: string;
      indexClub: Integer; journee: string; buts: string);
    function RequestNbButs(indexButeuse: Integer; journee: string): Integer;
    function RequestClubFromButeuse(idbuteuse: Integer): Integer;

  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  id: string;
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  if ComboBox3.Selected.Index < matchids.Count then
    id := matchids.Strings[ComboBox3.Selected.Index]
  else
    raise Exception.Create('Indice hors liste');

  RESTClient1.BaseURL := 'https://www.famfoot.fr/api/matchs/matchs/' + id;
  RESTRequest1.Execute;

  if RESTResponse1.Status.Success then
  begin
    jValue := RESTResponse1.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      Edit1.Text := ArrayElement.FindValue('competition')
        .ToString.Replace('"', '').Replace('&egrave;', 'è')
        .Replace('&eacute;', 'é').Replace('&agrave;', 'à');
      Edit3.Text := ArrayElement.FindValue('equipe1').ToString.Replace('"', '')
        + ' - ' + ArrayElement.FindValue('equipe2').ToString.Replace('"', '');
      if ArrayElement.FindValue('forfait_equipe1').ToString.Replace('"', '') = '1'
      then
        CheckBox1.IsChecked := true
      else
        CheckBox1.IsChecked := false;

      if ArrayElement.FindValue('forfait_equipe2').ToString.Replace('"', '') = '1'
      then
        CheckBox2.IsChecked := true
      else
        CheckBox2.IsChecked := false;

      if ArrayElement.FindValue('buteuses1').ToString.Replace('"', '') <> 'null'
      then
        Memo1.Text := ArrayElement.FindValue('buteuses1')
          .ToString.Replace('"', '').Replace('&eacute;', 'é')
          .Replace('&egrave;', 'è').Replace('&agrave;', 'à')
          .Replace('&ecirc;', 'ê').Replace('&euml;', 'ë').Replace('&iuml;', 'ï')
          .Replace('&ccedil;', 'ç')
      else
        Memo1.Text := '';

      if ArrayElement.FindValue('buteuses2').ToString.Replace('"', '') <> 'null'
      then
        Memo2.Text := ArrayElement.FindValue('buteuses2')
          .ToString.Replace('"', '').Replace('&eacute;', 'é')
          .Replace('&egrave;', 'è').Replace('&agrave;', 'à')
          .Replace('&ecirc;', 'ê').Replace('&euml;', 'ë').Replace('&iuml;', 'ï')
          .Replace('&ccedil;', 'ç')
      else
        Memo2.Text := '';

      Edit6.Text := ArrayElement.FindValue('id').ToString.Replace('"', '');
      Edit2.Text := ArrayElement.FindValue('score').ToString.Replace('"', '');

      TabControl1.ActiveTab := TabItemDisplayMatch;
    end
  end
  else
    raise Exception.Create(IntToStr(RESTResponse1.StatusCode) + ' - ' +
      RESTResponse1.StatusText);

end;

procedure TForm1.UpdateMatch(Matchid: string; forfait1, forfait2: boolean;
  buteuses1, buteuses2, score: string);
var
  jValue: TJSONObject;
  ArrayElement: TJSONValue;
begin
  RESTClient2.BaseURL := 'https://www.famfoot.fr/api/matchs/matchs/' + Matchid;

  jValue := TJSONObject.Create;
  try
    if forfait1 then
      jValue.AddPair('forfait_equipe1', '1')
    else
      jValue.AddPair('forfait_equipe1', '0');

    if forfait2 then
      jValue.AddPair('forfait_equipe2', '1')
    else
      jValue.AddPair('forfait_equipe2', '0');

    jValue.AddPair('buteuses1', buteuses1.Replace('é', '&eacute;').Replace('è',
      '&egrave;').Replace('à', '&agrave;').Replace('ê', '&ecirc;').Replace('ë',
      '&euml;').Replace('ï', '&iuml;').Replace('ç', '&ccedil;'));
    jValue.AddPair('buteuses2', buteuses2.Replace('é', '&eacute;').Replace('è',
      '&egrave;').Replace('à', '&agrave;').Replace('ê', '&ecirc;').Replace('ë',
      '&euml;').Replace('ï', '&iuml;').Replace('ç', '&ccedil;'));

    jValue.AddPair('score', score.Replace('é', '&eacute;').Replace('ê',
      '&ecirc;'));

    RESTRequest2.ClearBody;
    RESTRequest2.AddBody(jValue);
    RESTRequest2.Execute;
  finally
    jValue.Free;
  end;

  if RESTResponse2.Status.Success then
  begin
    ArrayElement := RESTResponse2.JSONValue;
    if StrToInt(ArrayElement.FindValue('status').ToString) = 1 then
      TabControl1.ActiveTab := TabItemSelectMatch
    else
      ShowMessage('error ' + ArrayElement.FindValue('status_message').ToString);
  end
  else
    raise Exception.Create(IntToStr(RESTResponse2.StatusCode) + ' - ' +
      RESTResponse2.StatusText);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  UpdateMatch(Edit6.Text, CheckBox1.IsChecked, CheckBox2.IsChecked, Memo1.Text,
    Memo2.Text, Edit2.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  TabControl2.ActiveTab := TabItemMatchs;
  SpeedButton1.Visible := true;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  TabControl2.ActiveTab := TabItemButeuses;
  TabControl3.ActiveTab := self.TabItemButeusesAccueil;
  SpeedButton1.Visible := true;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  TabControl3.ActiveTab := TabItemNouvelleButeuse;
  if Assigned(self.ComboBoxNewButCompet) then
    self.ComboBoxNewButCompet.ItemIndex := -1;
  if Assigned(self.ComboBoxNewButClub) then
    self.ComboBoxNewButClub.ItemIndex := -1;
  if Assigned(self.ComboBoxNewButButeuse) then
    self.ComboBoxNewButButeuse.ItemIndex := -1;
  if Assigned(self.ComboBoxNewButJournee) then
    self.ComboBoxNewButJournee.ItemIndex := -1;
  Edit5.Text := '';
  Edit4.Text := '';
  Layout15.Visible := false;
  SpeedButton1.Visible := true;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  TabControl3.ActiveTab := TabItemModifierButeuse;
  self.ComboBoxModifierButeuseCompet.ItemIndex := -1;
  self.ComboBoxModifierButeuseClubs.ItemIndex := -1;
  self.ComboBoxModifierButeuseButeuse.ItemIndex := -1;
  self.ComboBoxModifierButeuseJournee.ItemIndex := -1;
  self.EditModifierButeuseNom.Text := '';
  self.Edit8.Text := '';
  SpeedButton1.Visible := true;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  TabControl3.ActiveTab := TabItemSupprimerButeuse;
  SpeedButton1.Visible := true;
end;

procedure TForm1.AddBut(compet, journee: string; indexClub: Integer;
  buteuse: string; indexButeuse: Integer; buts: string; isNewButeuse: boolean);
var
  jValue: TJSONObject;
  ArrayElement: TJSONValue;
  clubID, buteuseID: string;
begin

  if isNewButeuse then
  begin
    clubID := clubsids.Strings[indexClub];

    RESTClient10.BaseURL := 'https://www.famfoot.fr/api/buteuse';
    // POST buteuse : id_club,  nom de la buteuse, nom du championnat
    jValue := TJSONObject.Create;
    try
      jValue.AddPair('club', clubID);
      jValue.AddPair('nom', buteuse);
      jValue.AddPair('championnat', compet);

      RESTRequest10.ClearBody;
      RESTRequest10.AddBody(jValue);
      RESTRequest10.Execute;
    finally
      jValue.Free;
    end;

    if RESTResponse10.Status.Success then
    begin
      ArrayElement := RESTResponse10.JSONValue;
      if StrToInt(ArrayElement.FindValue('status').ToString) = 0 then
        ShowMessage('error ' + ArrayElement.FindValue
          ('status_message').ToString)
      else
      begin
        buteuseID := ArrayElement.FindValue('id').ToString.Replace('"', '');
      end;
    end
    else
      raise Exception.Create(IntToStr(RESTResponse10.StatusCode) + ' - ' +
        RESTResponse10.StatusText);
  end
  else
    buteuseID := buteusesids.Strings[indexButeuse - 1];

  RESTClient10.BaseURL := 'https://www.famfoot.fr/api/but';
  // POST buteuse : id_club,  nom de la buteuse, nom du championnat
  jValue := TJSONObject.Create;
  try
    jValue.AddPair('journee', journee);
    jValue.AddPair('buteuse', buteuseID);
    jValue.AddPair('nbButs', buts);

    RESTRequest10.ClearBody;
    RESTRequest10.AddBody(jValue);
    RESTRequest10.Execute;
  finally
    jValue.Free;
  end;

  if RESTResponse10.Status.Success then
  begin
    ArrayElement := RESTResponse10.JSONValue;
    if StrToInt(ArrayElement.FindValue('status').ToString) = 0 then
      ShowMessage('error ' + ArrayElement.FindValue('status_message').ToString)
    else
      TabControl3.ActiveTab := TabItemButeusesAccueil;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse10.StatusCode) + ' - ' +
      RESTResponse10.StatusText);

end;

procedure TForm1.EditBut(indexButeuse: Integer; nomButeuse: string;
  indexClub: Integer; journee: string; buts: string);
var
  jValue: TJSONObject;
  ArrayElement: TJSONValue;
  clubID, buteuseID: string;
begin

  clubID := clubsids.Strings[indexClub];
  buteuseID := buteusesids.Strings[indexButeuse];

  if nomButeuse <> '' then
  begin
    RESTClient11.BaseURL := 'https://www.famfoot.fr/api/buteuse/buteuse/' +
      buteuseID;
    jValue := TJSONObject.Create;
    try
      jValue.AddPair('club', clubID);
      jValue.AddPair('nom', nomButeuse);

      RESTRequest11.ClearBody;
      RESTRequest11.AddBody(jValue);
      RESTRequest11.Execute;
    finally
      jValue.Free;
    end;

    if RESTResponse11.Status.Success then
    begin
      ArrayElement := RESTResponse11.JSONValue;
      if StrToInt(ArrayElement.FindValue('status').ToString) = 0 then
        ShowMessage('error ' + ArrayElement.FindValue
          ('status_message').ToString)
    end
    else
      raise Exception.Create(IntToStr(RESTResponse11.StatusCode) + ' - ' +
        RESTResponse11.StatusText);
  end;

  if journee <> '' then
  begin
    RESTClient10.BaseURL := 'https://www.famfoot.fr/api/but';
    // POST buteuse : id_club,  nom de la buteuse, nom du championnat
    jValue := TJSONObject.Create;
    try
      jValue.AddPair('journee', journee);
      jValue.AddPair('buteuse', buteuseID);
      jValue.AddPair('nbButs', buts);

      RESTRequest10.ClearBody;
      RESTRequest10.AddBody(jValue);
      RESTRequest10.Execute;
    finally
      jValue.Free;
    end;

    if RESTResponse10.Status.Success then
    begin
      ArrayElement := RESTResponse10.JSONValue;
      if StrToInt(ArrayElement.FindValue('status').ToString) = 0 then
        ShowMessage('error ' + ArrayElement.FindValue
          ('status_message').ToString)
      else
        TabControl3.ActiveTab := TabItemButeusesAccueil;
    end
    else
      raise Exception.Create(IntToStr(RESTResponse10.StatusCode) + ' - ' +
        RESTResponse10.StatusText);
  end
  else
    TabControl3.ActiveTab := TabItemButeusesAccueil;

end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if ComboBoxNewButButeuse.Selected.Text <> 'Nouvelle' then
    AddBut(ComboBoxNewButCompet.Selected.Text,
      ComboBoxNewButJournee.Selected.Text, ComboBoxNewButClub.Selected.Index,
      ComboBoxNewButButeuse.Selected.Text, ComboBoxNewButButeuse.Selected.Index,
      Edit5.Text, false)
  else
    AddBut(ComboBoxNewButCompet.Selected.Text,
      ComboBoxNewButJournee.Selected.Text, ComboBoxNewButClub.Selected.Index,
      Edit4.Text, 0, Edit5.Text, true);
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  selectedbuteuse: string;
begin
  selectedbuteuse := self.ComboBoxModifierButeuseButeuse.Selected.Text;
  if self.EditModifierButeuseNom.Text <> selectedbuteuse then
  begin
    if Assigned(ComboBoxModifierButeuseJournee.Selected) then
      EditBut(ComboBoxModifierButeuseButeuse.Selected.Index,
        EditModifierButeuseNom.Text, ComboBoxModifierButeuseClubs.ItemIndex,
        ComboBoxModifierButeuseJournee.Selected.Text, Edit8.Text)
    else
      EditBut(ComboBoxModifierButeuseButeuse.Selected.Index,
        EditModifierButeuseNom.Text,
        ComboBoxModifierButeuseClubs.ItemIndex, '', '');
  end
  else
  begin
    EditBut(ComboBoxModifierButeuseButeuse.Selected.Index, '',
      ComboBoxModifierButeuseClubs.Selected.Index,
      ComboBoxModifierButeuseJournee.Selected.Text, Edit8.Text);
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.Clear;
  ComboBox3.Clear;
  RequestCompet(ComboBox1.Selected.Text);
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  ComboBox3.Clear;
  RequestMatch(ComboBox1.Selected.Text, ComboBox2.Selected.Text);
end;

procedure TForm1.ComboBoxModifierButeuseCompetChange(Sender: TObject);
var
  journee, clubs, buteuses: TStringList;
  I: Integer;
begin
  if Assigned(ComboBoxModifierButeuseCompet.Selected) then
  begin
    buteuses := RequestButeusesCompet
      (ComboBoxModifierButeuseCompet.Selected.Text);
    try
      if Assigned(ComboBoxModifierButeuseButeuse) then
        ComboBoxModifierButeuseButeuse.Clear;
      for I := 0 to buteuses.Count - 1 do
        ComboBoxModifierButeuseButeuse.Items.Add(buteuses.Strings[I]);
    finally
      buteuses.Free;
    end;

    journee := RequestJourneeButeuse
      (ComboBoxModifierButeuseCompet.Selected.Text);
    try
      ComboBoxModifierButeuseJournee.Clear;
      for I := 0 to journee.Count - 1 do
        ComboBoxModifierButeuseJournee.Items.Add(journee.Strings[I]);
    finally
      journee.Free;
    end;

    clubs := RequestClubsButeuse(ComboBoxModifierButeuseCompet.Selected.Text);
    try
      if Assigned(ComboBoxModifierButeuseClubs) then
        ComboBoxModifierButeuseClubs.Clear;
      for I := 0 to clubs.Count - 1 do
        ComboBoxModifierButeuseClubs.Items.Add(clubs.Strings[I]);
    finally
      clubs.Free;
    end;
  end;
end;

procedure TForm1.ComboBoxModifierButeuseButeuseChange(Sender: TObject);
begin
  if Assigned(ComboBoxModifierButeuseButeuse.Selected) and
    not Assigned(ComboBoxModifierButeuseJournee.Selected) then
  begin
    EditModifierButeuseNom.Text := ComboBoxModifierButeuseButeuse.Selected.Text;
    ComboBoxModifierButeuseClubs.ItemIndex :=
      RequestClubFromButeuse
      (StrToInt(buteusesids.Strings
      [ComboBoxModifierButeuseButeuse.Selected.Index]));
  end;
  if Assigned(ComboBoxModifierButeuseButeuse.Selected) and
    Assigned(ComboBoxModifierButeuseJournee.Selected) then
    if (ComboBoxModifierButeuseButeuse.Selected.Text <> '') and
      (ComboBoxModifierButeuseJournee.Selected.Text <> '') then
      Edit8.Text :=
        IntToStr(RequestNbButs(ComboBoxModifierButeuseButeuse.Selected.Index,
        ComboBoxModifierButeuseJournee.Selected.Text));
end;

function TForm1.RequestClubFromButeuse(idbuteuse: Integer): Integer;
var
  jValue: TJSONValue;
  clubID: string;
  I: Integer;
begin
  Result := 0;

  RESTClient14.BaseURL := 'https://www.famfoot.fr/api/club/club/buteuse/' +
    IntToStr(idbuteuse);

  RESTRequest14.Execute;

  if RESTResponse14.Status.Success then
  begin
    jValue := RESTResponse14.JSONValue;
    clubID := jValue.FindValue('club').ToString.Replace('"', '');
    for I := 0 to clubsids.Count do
      if clubsids.Strings[I] = clubID then
      begin
        Result := I;
        exit;
      end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse14.StatusCode) + ' - ' +
      RESTResponse14.StatusText);
end;

function TForm1.RequestNbButs(indexButeuse: Integer; journee: string): Integer;
var
  buteuseID: string;
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  Result := 0;
  buteuseID := buteusesids.Strings[indexButeuse];

  RESTClient12.BaseURL := 'https://www.famfoot.fr/api/buts/buts/buteuse/' +
    buteuseID + '/journee/' + journee;

  RESTRequest12.Execute;

  if RESTResponse12.Status.Success then
  begin
    jValue := RESTResponse12.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      Result := StrToInt(ArrayElement.FindValue('nbButs')
        .ToString.Replace('"', ''));
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse12.StatusCode) + ' - ' +
      RESTResponse12.StatusText);
end;

procedure TForm1.ComboBoxNewButButeuseChange(Sender: TObject);
begin
  if Assigned(ComboBoxNewButButeuse.Selected) then
    if ComboBoxNewButButeuse.Selected.Text = 'Nouvelle' then
      Layout15.Visible := true
    else
      Layout15.Visible := false;
end;

procedure TForm1.ComboBoxNewButClubChange(Sender: TObject);
var
  buteuses: TStringList;
  I: Integer;
begin
  ComboBoxNewButButeuse.Items.Clear;

  ComboBoxNewButButeuse.Items.Add('Nouvelle');

  if Assigned(ComboBoxNewButClub.Selected) then
  begin
    buteuses := RequestButeusesClub
      (StrToInt(clubsids.Strings[ComboBoxNewButClub.Selected.Index]));
    try
      for I := 0 to buteuses.Count - 1 do
        ComboBoxNewButButeuse.Items.Add(buteuses.Strings[I]);
    finally
      buteuses.Free;
    end;
  end;

end;

procedure TForm1.ComboBoxNewButCompetChange(Sender: TObject);
var
  journee, clubs: TStringList;
  I: Integer;
begin
  if Assigned(ComboBoxNewButCompet.Selected) then
  begin
    journee := RequestJourneeButeuse(ComboBoxNewButCompet.Selected.Text);
    try
      ComboBoxNewButJournee.Clear;
      for I := 0 to journee.Count - 1 do
        ComboBoxNewButJournee.Items.Add(journee.Strings[I]);
    finally
      journee.Free;
    end;

    clubs := RequestClubsButeuse(ComboBoxNewButCompet.Selected.Text);
    try
      ComboBoxNewButClub.Clear;
      for I := 0 to clubs.Count - 1 do
        ComboBoxNewButClub.Items.Add(clubs.Strings[I]);
    finally
      clubs.Free;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  matchids := TStringList.Create;
  clubsids := TStringList.Create;
  buteusesids := TStringList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  matchids.Free;
  clubsids.Free;
  buteusesids.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  compets: TStringList;
  I: Integer;
begin
  TabControl2.ActiveTab := TabItemAccueil;
  SpeedButton1.Visible := false;
  TabControl1.ActiveTab := TabItemSelectMatch;
  RequestDate;
  compets := RequestCompetButeuse;
  try
    for I := 0 to compets.Count - 1 do
    begin
      ComboBoxNewButCompet.Items.Add(compets.Strings[I]);
      ComboBoxModifierButeuseCompet.Items.Add(compets.Strings[I]);
    end;
  finally
    compets.Free;
  end;
end;

function TForm1.RequestCompetButeuse: TStringList;
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  RESTClient6.BaseURL := 'https://www.famfoot.fr/api/compet/';

  RESTRequest6.Execute;

  Result := TStringList.Create;

  if RESTResponse6.Status.Success then
  begin
    jValue := RESTResponse6.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      Result.Add(ArrayElement.FindValue('competition').ToString.Replace('"', '')
        .Replace('%C3%A9', 'é'));
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse6.StatusCode) + ' - ' +
      RESTResponse6.StatusText);
end;

function TForm1.RequestJourneeButeuse(compet: string): TStringList;
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  Result := TStringList.Create;
  ComboBoxNewButJournee.Items.Clear;
  compet := compet.Replace('é', '%C3%A9');

  RESTClient7.BaseURL := 'https://www.famfoot.fr/api/journee/journee/' + compet;

  RESTRequest7.Execute;

  if RESTResponse7.Status.Success then
  begin
    jValue := RESTResponse7.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      Result.Add(ArrayElement.ToString);
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse7.StatusCode) + ' - ' +
      RESTResponse7.StatusText);
end;

function TForm1.RequestClubsButeuse(compet: string): TStringList;
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  Result := TStringList.Create;
  if Assigned(clubsids) then
    clubsids.Clear;

  compet := compet.Replace('é', '%C3%A9');

  RESTClient8.BaseURL := 'https://www.famfoot.fr/api/clubs/clubs/' + compet;

  RESTRequest8.Execute;

  if RESTResponse8.Status.Success then
  begin
    jValue := RESTResponse8.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      Result.Add(ArrayElement.FindValue('club').ToString.Replace('"', '').Replace('%C3%A9', 'é'));
      clubsids.Add(ArrayElement.FindValue('contact').ToString.Replace('"', ''))
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse8.StatusCode) + ' - ' +
      RESTResponse8.StatusText);
end;

function TForm1.RequestButeusesClub(club: Integer): TStringList;
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  Result := TStringList.Create;
  if Assigned(buteusesids) then
    buteusesids.Clear;
  RESTClient9.BaseURL := 'https://www.famfoot.fr/api/buteuses/buteuses/club/' +
    IntToStr(club);

  RESTRequest9.Execute;

  if RESTResponse9.Status.Success then
  begin
    jValue := RESTResponse9.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      Result.Add(ArrayElement.FindValue('nom').ToString.Replace('"', ''));
      buteusesids.Add(ArrayElement.FindValue('id').ToString.Replace('"', ''))
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse9.StatusCode) + ' - ' +
      RESTResponse9.StatusText);
end;

function TForm1.RequestButeusesCompet(compet: string): TStringList;
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  Result := TStringList.Create;

  if Assigned(buteusesids) then
    buteusesids.Clear;
  RESTClient13.BaseURL := 'https://www.famfoot.fr/api/buteuses/buteuses/compet/'
    + compet.Replace('é', '%C3%A9');

  RESTRequest13.Execute;

  if RESTResponse13.Status.Success then
  begin
    jValue := RESTResponse13.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      Result.Add(ArrayElement.FindValue('nom').ToString.Replace('"', ''));
      buteusesids.Add(ArrayElement.FindValue('id').ToString.Replace('"', ''))
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse13.StatusCode) + ' - ' +
      RESTResponse13.StatusText);
end;

procedure TForm1.RequestDate;
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  RESTRequest3.Method := rmGET;
  RESTClient3.BaseURL := 'http://www.famfoot.fr/api/dates';
  RESTRequest3.Execute;

  if RESTResponse3.Status.Success then
  begin
    jValue := RESTResponse3.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      ComboBox1.Items.Add(ArrayElement.FindValue('date')
        .ToString.Replace('"', ''));
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse3.StatusCode) + ' - ' +
      RESTResponse3.StatusText);
end;

procedure TForm1.RequestCompet(date: string);
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  RESTClient4.BaseURL := 'https://www.famfoot.fr/api/compet/compet/' + date;

  RESTRequest4.Execute;

  if RESTResponse4.Status.Success then
  begin
    jValue := RESTResponse4.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      ComboBox2.Items.Add(ArrayElement.FindValue('competition')
        .ToString.Replace('"', ''));
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse4.StatusCode) + ' - ' +
      RESTResponse4.StatusText);
end;

procedure TForm1.RequestMatch(date, compet: string);
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  if Assigned(matchids) then
    matchids.Clear;

  RESTClient5.BaseURL := 'https://www.famfoot.fr/api/matchs/matchs/date/' + date
    + '/compet/' + compet;

  RESTRequest5.Execute;

  if RESTResponse5.Status.Success then
  begin
    jValue := RESTResponse5.JSONValue;
    jsonarray := jValue as TJSONArray;
    for ArrayElement in jsonarray do
    begin
      ComboBox3.Items.Add(ArrayElement.FindValue('equipe1')
        .ToString.Replace('"', '') + ' - ' + ArrayElement.FindValue('equipe2')
        .ToString.Replace('"', ''));
      matchids.Add(ArrayElement.FindValue('id').ToString.Replace('"', ''))
    end;
  end
  else
    raise Exception.Create(IntToStr(RESTResponse5.StatusCode) + ' - ' +
      RESTResponse5.StatusText);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  TabControl2.ActiveTab := TabItemAccueil;
  SpeedButton1.Visible := false;
end;

end.
