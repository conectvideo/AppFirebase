unit Unit1;

interface

  uses
    System.SysUtils, System.Types, System.UITypes, System.Classes,
    System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
    FMX.TabControl, FMX.ListBox, FMX.Controls.Presentation, FMX.Edit,
    FMX.Layouts,
    TBGFirebaseConnection.View.Connection, Data.DB, Datasnap.DBClient;

  type
    TForm1 = class(TForm)
      FireBase: TTBGFirebaseConnection;
      ListBox1: TListBox;
      ListBoxItem1: TListBoxItem;
      EdtBaseURL: TEdit;
      Label1: TLabel;
      ListBoxItem2: TListBoxItem;
      EdtAuth: TEdit;
      Label2: TLabel;
      ListBoxItem3: TListBoxItem;
      ListBoxItem4: TListBoxItem;
      Label3: TLabel;
      EdtuID: TEdit;
      Label4: TLabel;
      EdtResource: TEdit;
      ListBox2: TListBox;
      ListBoxHeader1: TListBoxHeader;
      Label5: TLabel;
      ListBoxItem5: TListBoxItem;
      ListBoxItem6: TListBoxItem;
      ListBoxItem7: TListBoxItem;
      Nome: TLabel;
      Label7: TLabel;
      Label8: TLabel;
      Edit1: TEdit;
      Edit2: TEdit;
      Edit3: TEdit;
      TabControl1: TTabControl;
      TABCONFIG: TTabItem;
      TABCADASTRO: TTabItem;
      ToolBar1: TToolBar;
      Button1: TButton;
      TABLISTAR: TTabItem;
    Label6: TLabel;
    Button2: TButton;
    ListBox3: TListBox;
    ClientDataSet1: TClientDataSet;
    ClientDataSet2: TClientDataSet;
      procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
    end;

  var
    Form1: TForm1;

implementation

  uses
    System.JSON;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

  procedure TForm1.Button1Click(Sender: TObject);
  var
    JsonArray: TJSONArray;
    i: Integer;
  begin
    JsonArray := TJSONArray.Create;
    try
     FireBase
        .Connect
           .BaseURL(EdtBaseURL.Text)
           .Auth(EdtAuth.Text)
           .uId(EdtuID.Text)
        .&End
        .Get
          .Resource(EdtResource.Text)
          .ResponseContent(JsonArray)
        .&End;

      JsonArray.AddElement(
        TJSONObject.Create
          .AddPair('_id', TJSONNumber.Create(i))
          .AddPair('nome', Edit1.Text)
          .AddPair('sobrenome', Edit2.Text)
          .AddPair('email', Edit3.Text)
       );


      FireBase
        .Connect
           .BaseURL(EdtBaseURL.Text)
           .Auth(EdtAuth.Text)
           .uId(EdtuID.Text)
           .&End
           .Put
            .Resource(EdtResource.Text)
            .Json(JsonArray)
           .&End

    finally
       JsonArray.DisposeOf;
    end;
  end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FireBase
     .Connect
        .BaseURL(EdtBaseURL.Text)
        .Auth(EdtAuth.Text)
        .uId(EdtuID.Text)
     .&End
     .Get
       .Resource(EdtResource.Text)
       .DataSet(ClientDataSet1)
     .&End;

    ListBox3.Items.Clear;
    while not ClientDataSet1.eof do
    begin
      ListBox3.Items.Add(ClientDataSet1.FieldByName('nome').AsString);
      ClientDataSet1.Next;
    end;
end;

end.
