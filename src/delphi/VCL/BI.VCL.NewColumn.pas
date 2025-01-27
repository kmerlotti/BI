unit BI.VCL.NewColumn;

interface

uses
  {$IFNDEF FPC}
  Winapi.Windows, Winapi.Messages,
  {$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  BI.Data, BI.Arrays;

type
  TAddColumn = class(TForm)
    Label1: TLabel;
    EName: TEdit;
    Panel1: TPanel;
    RGStyle: TRadioGroup;
    Label2: TLabel;
    EExpression: TEdit;
    Panel2: TPanel;
    BOk: TButton;
    Button2: TButton;
    CBKind: TComboBox;
    LError: TLabel;
    CBLookup: TComboBox;
    CBDetail: TComboBox;
    procedure ENameChange(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
    procedure EExpressionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBKindChange(Sender: TObject);
    procedure CBLookupChange(Sender: TObject);
    procedure CBDetailChange(Sender: TObject);
  private
    { Private declarations }

    IData : TDataItem;

    procedure AddKinds;
    procedure AddLookups;
    procedure AddDetails;
    function CurrentDetail:TDataItem;
    function CurrentLookup:TDataItem;
    procedure InitMissing(const ACol:TDataItem);
    function TryExpression(const Fill:Boolean):TDataItem;
  public
    { Public declarations }
    Constructor CreateData(const AOwner:TComponent; const AData:TDataItem);

    class function NewColumn(const AOwner:TComponent; const AData:TDataItem):TDataItem;
    class function NewDetail(const AName:String; const AMaster:TDataItem; const ADetail:TDataItem):TDataItem;
  end;

implementation
