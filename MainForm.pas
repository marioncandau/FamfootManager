unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox,
  FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, FMX.Edit;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
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
    Label2: TLabel;
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
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    matchids: TStringList;
    procedure RequestDate;
    procedure RequestCompet(date: string);
    procedure RequestMatch(date, compet: string);
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

  RESTClient1.BaseURL := 'http://www.famfoot.fr/api/matchs/id/' + id;
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

      TabControl1.ActiveTab := TabItem2;
    end
  end
  else
    raise Exception.Create(IntToStr(RESTResponse1.StatusCode) + ' - ' +
      RESTResponse1.StatusText);

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  jValue: TJSONObject;
  ArrayElement: TJSONValue;
begin
  RESTClient2.BaseURL := 'http://www.famfoot.fr/api/matchs/id/' + Edit6.Text;

  jValue := TJSONObject.Create;
  try
    if CheckBox1.IsChecked = true then
      jValue.AddPair('forfait_equipe1', '1')
    else
      jValue.AddPair('forfait_equipe1', '0');

    if CheckBox2.IsChecked = true then
      jValue.AddPair('forfait_equipe2', '1')
    else
      jValue.AddPair('forfait_equipe2', '0');

    jValue.AddPair('buteuses1', Memo1.Text.Replace('é', '&eacute;').Replace('è',
      '&egrave;').Replace('à', '&agrave;').Replace('ê', '&ecirc;').Replace('ë',
      '&euml;').Replace('ï', '&iuml;').Replace('ç', '&ccedil;'));
    jValue.AddPair('buteuses2', Memo2.Text.Replace('é', '&eacute;').Replace('è',
      '&egrave;').Replace('à', '&agrave;').Replace('ê', '&ecirc;').Replace('ë',
      '&euml;').Replace('ï', '&iuml;').Replace('ç', '&ccedil;'));

    jValue.AddPair('score', Edit2.Text.Replace('é', '&eacute;').Replace('ê',
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
      TabControl1.ActiveTab := TabItem1
    else
      ShowMessage('error ' + ArrayElement.FindValue('status_message').ToString);
  end
  else
    raise Exception.Create(IntToStr(RESTResponse2.StatusCode) + ' - ' +
      RESTResponse2.StatusText);
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  matchids := TStringList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  matchids.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItem1;
  RequestDate;
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
  RESTClient4.BaseURL := 'http://www.famfoot.fr/api/compet/' + date;

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
  if assigned(matchids) then
    matchids.Clear;


  RESTClient5.BaseURL := 'http://www.famfoot.fr/api/matchs/date/' + date +
    '/compet/' + compet;

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

end.
