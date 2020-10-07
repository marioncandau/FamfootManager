unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox,
  FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

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
    Memo1: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
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

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  RequestCompet(ComboBox1.Selected.Text);
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  RequestMatch(ComboBox1.Selected.Text, ComboBox2.Selected.Text);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  RequestDate;
end;

procedure TForm1.RequestDate;
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  RESTRequest1.Method := TRESTRequestMethod.rmGET;
  RESTClient1.BaseURL := 'http://www.famfoot.fr/api/dates';

  RESTRequest1.Execute;

  jValue := RESTResponse1.JSONValue;
  jsonarray := jValue as TJSONArray;
  for ArrayElement in jsonarray do
  begin
    ComboBox1.Items.Add(ArrayElement.FindValue('date')
      .ToString.Replace('"', ''));
  end;
end;

procedure TForm1.RequestCompet(date: string);
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  RESTRequest1.Method := TRESTRequestMethod.rmGET;
  RESTClient1.BaseURL := 'http://www.famfoot.fr/api/compet/' + date;

  RESTRequest1.Execute;

  jValue := RESTResponse1.JSONValue;
  jsonarray := jValue as TJSONArray;
  for ArrayElement in jsonarray do
  begin
    ComboBox2.Items.Add(ArrayElement.FindValue('competition')
      .ToString.Replace('"', ''));
  end;
end;

procedure TForm1.RequestMatch(date, compet: string);
var
  jValue: TJSONValue;
  jsonarray: TJSONArray;
  ArrayElement: TJSONValue;
begin
  RESTRequest1.Method := TRESTRequestMethod.rmGET;
  RESTClient1.BaseURL := 'http://www.famfoot.fr/api/matchs/date/' + date +
    '/compet/' + compet;

  RESTRequest1.Execute;

  jValue := RESTResponse1.JSONValue;
  jsonarray := jValue as TJSONArray;
  for ArrayElement in jsonarray do
  begin
    ComboBox3.Items.Add(ArrayElement.FindValue('equipe1').ToString.Replace('"',
      '') + ' - ' + ArrayElement.FindValue('equipe2')
      .ToString.Replace('"', ''));
  end;
end;

end.
