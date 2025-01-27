unit Import_Store;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  BI.VCL.Grid;

type
  TFromBIStore = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button4: TButton;
    PageControl1: TPageControl;
    TabStores: TTabSheet;
    TabRemote: TTabSheet;
    Panel3: TPanel;
    LBStores: TListBox;
    LBDatas: TListBox;
    BIGrid1: TBIGrid;
    Panel4: TPanel;
    Button1: TButton;
    LBRemoteDatas: TListBox;
    BIGrid2: TBIGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LBRemoteDatasClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LBStoresClick(Sender: TObject);
    procedure LBDatasClick(Sender: TObject);
  private
    { Private declarations }

    procedure LoadStores;
  public
    { Public declarations }

    class procedure Show(const AOwner: TComponent); static;
  end;

implementation

{$R *.dfm}

uses
  BI.Persist, BI.Web;

procedure TFromBIStore.Button1Click(Sender: TObject);
var Web : TBIWebClient;
begin
  Screen.Cursor:=crHourGlass;
  try
    Web:=TBIWebClient.Create('steema.cat');
    try
      LBRemoteDatas.Items.Text:=Web.GetDatas;
    finally
      Web.Free;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFromBIStore.Button4Click(Sender: TObject);
begin
  Close;
end;

procedure TFromBIStore.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage:=TabStores;

  LoadStores;
end;

procedure TFromBIStore.FormDestroy(Sender: TObject);
begin
  BIGrid2.DestroyData;
end;

procedure TFromBIStore.LBDatasClick(Sender: TObject);
var Store,
    Data : String;
begin
  if LBDatas.ItemIndex<>-1 then
  begin
    Store:=LBStores.Items[LBStores.ItemIndex];
    Data:=LBDatas.Items[LBDatas.ItemIndex];

    BIGrid1.Data:=TStore.Load(Store,Data);
  end;
end;

procedure TFromBIStore.LBRemoteDatasClick(Sender: TObject);
var Web : TBIWebClient;
begin
  if LBRemoteDatas.ItemIndex<>-1 then
  begin
    BIGrid2.DestroyData;

    // This example obtains data remotely using the low-level class TBIWebClient.
    // Use of TBIWebClient is only for demostrative purpose.
    // The easier way is to use TStore.Load method instead.

    Screen.Cursor:=crHourGlass;
    try
      Web:=TBIWebClient.Create('steema.cat'); // 'localhost'
      try
        BIGrid2.Data:=Web.GetMetaData(LBRemoteDatas.Items[LBRemoteDatas.ItemIndex], TWebCompression.No);
      finally
        Web.Free;
      end;
    finally
      Screen.Cursor:=crDefault;
    end;

    // Alternative way, if the web Store is already registered:
    // BIGrid2.Data:=TStore.Load('MyStore', LBRemoteDatas.Items[LBRemoteDatas.ItemIndex]);
  end;
end;

procedure TFromBIStore.LBStoresClick(Sender: TObject);
var Store,
    S : String;
begin
  if LBStores.ItemIndex<>-1 then
  begin
    Store:=LBStores.Items[LBStores.ItemIndex];

    // Obtain all datas from a Store, add them to LBDatas listbox

    LBDatas.Items.BeginUpdate;
    try
      LBDatas.Items.Clear;

      for S in TStore.AllData(Store) do
          LBDatas.Items.Add(S);
    finally
      LBDatas.Items.EndUpdate;
    end;
  end;
end;

procedure TFromBIStore.LoadStores;
begin
  // Get all registered Stores from registry, add them to LBStores listbox
  TStores.AllTo(LBStores.Items);
end;

class procedure TFromBIStore.Show(const AOwner: TComponent);
begin
  with TFromBIStore.Create(AOwner) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
