{*********************************************}
{  TeeBI Software Library                     }
{  TExpression tests and examples             }
{  Copyright (c) 2015-2016 by Steema Software }
{  All Rights Reserved                        }
{*********************************************}
unit Main_Unit;

interface

{$IF CompilerVersion<=20}
{$DEFINE FMX20}
{$ENDIF}

// This example contains several tests of TExpression class.

// TExpression is a general-purpose class to parse and evaluate formulas.

// TExpression unit is:  BI.Expression.pas

// Tests can be run all together ("unit testing") and benchmarked.

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  {$IFNDEF FMX20}
  FMX.Controls.Presentation, FMX.ScrollBox,
  {$ENDIF}
  FMX.Edit, FMX.Layouts, FMX.TreeView, BI.Expression,
  BI.Summary, BI.Data, BI.Data.Dataset, Data.DB, Datasnap.DBClient,
  BI.Data.DB,

  BI.Data.ClientDataSet, FMX.ListBox, FMX.Memo, System.Math, FMX.TabControl;

type
  TFormMain = class(TForm)
    ClientDataSet1: TClientDataSet;
    TabControl1: TTabControl;
    TabTest: TTabItem;
    TabItem2: TTabItem;
    BExampleFormula: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    BEvaluate: TButton;
    Button5: TButton;
    LabelResult: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    Layout1: TLayout;
    BTestAll: TButton;
    Button8: TButton;
    Layout2: TLayout;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    procedure BEvaluateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ListBox1Change(Sender: TObject);
    procedure BTestAllClick(Sender: TObject);
    procedure BExampleFormulaClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }

    Expression : TExpression;

    Changing : Boolean;

    Animals : TDataItem; // <-- For Dataset example

    procedure ParseExpression(const AExpression:String);
    procedure Present;
    procedure SetNewExpression(const AExpression:String);
    procedure ShowTree;
    procedure TestExpression(const S:String);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  BI.Arrays, BI.FMX.Expression.Tree, BI.Expression.Benchmark;

{$R *.fmx}

procedure TFormMain.BEvaluateClick(Sender: TObject);
begin
  LabelResult.Text:=Expression.Value;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  Expression.Free;

  // Manually created expression, equivalent to: "1<2"
  Expression:=TLogicalExpression.Create(TFloatExpression.Create(1),TLogicalOperand.Lower,TFloatExpression.Create(2));

  Present;

  BEvaluate.Enabled:=True;
  BEvaluateClick(Self);
end;

(*
// Advanced: Create an expression manually

function CreateSampleExpression(const Data:TDataItem; const Filter:TDataFilter):TLogicalExpression;
var NameOcelot,
    SizeGreater : TLogicalExpression;
begin
  // Animals: (Size>7) and (Name<>'Ocelot')

  SizeGreater:=TLogicalExpression.Create(Filter.ColumnExpression(Data['Size']),
                  TLogicalOperand.Greater,
                  TIntegerExpression.Create(7));

  NameOcelot:=TLogicalExpression.Create(Filter.ColumnExpression(Data['Name']),
                  TLogicalOperand.NotEqual,
                  TTextExpression.Create('Ocelot'));

  result:=TLogicalExpression.Create(SizeGreater,TLogicalOperand.&And,NameOcelot);
end;
*)

procedure TFormMain.Button3Click(Sender: TObject);
var D : TBIDatasetSource;
begin
  if Animals=nil then
  begin
    D:=TBIDataSetSource.Create;
    try
      Animals:=D.Import(ClientDataSet1,'animals');
    finally
      D.Free;
    end;
  end;

  // Just to see the expression in Edit1
  Changing:=True;
  try
    Edit1.Text:='(size>7) and (name<>"Ocelot")';
  finally
    Changing:=False;
  end;

  Expression.Free;

  // Example parsing a string expression:
  Expression:=TDataExpression.FromString(Animals,Edit1.Text);

  // Example constructing the same expression manually:
  // Expression:=CreateSampleExpression(Data);

  ShowTree;

  BEvaluate.Enabled:=False;
  LabelResult.Text:='';
end;

procedure TFormMain.Button4Click(Sender: TObject);
begin
  Expression.Free;

  // Manually created expression, equivalent to: " 'X' in ['A','C','B','Y','X','Z'] "

  Expression:=TLogicalExpression.Create(
     TTextExpression.Create('X'),
     TLogicalOperand.&In,
     TArrayExpression.Create(['A','C','B','Y','X','Z']));

  Present;

  BEvaluate.Enabled:=True;
  BEvaluateClick(Self);
end;

procedure TFormMain.Button5Click(Sender: TObject);
begin
//  TExpressionEditor.Edit(Self,Expression);
end;

// Parse and evaluate S string to verify the expression
procedure TFormMain.TestExpression(const S:String);
var Value,
    Left,
    Right : String;
    tmpResult : Variant;
begin
  if S<>'' then
  begin
    if SplitTest(S,Left,Right) then
    try
      // Parse Expression
      SetNewExpression(Left);

      // We can now evaluate the Expression object

      if Expression=nil then
         Memo1.Lines.Add('Cannot parse expression: '+S)
      else
      begin
        tmpResult:=Expression.Value;

        if VarIsNull(tmpResult) then
           Memo1.Lines.Add('Cannot evaluate expression: '+S)
        else
        begin
          Value:=tmpResult;

          if Right<>Value then
             Memo1.Lines.Add('Test error: '+S+' -> '+Right+' --> '+Value);
        end;
      end;
    except
      on E:EExpressionParse do
      begin
        Memo1.Lines.Add(S+' : '+E.Message+' at '+IntToStr(E.Position));
      end;
    end
    else
      Memo1.Lines.Add('Bad test string: '+S);
  end;
end;

// Loop all expressions in ListBox to test parsing and evaluating them
procedure TFormMain.BTestAllClick(Sender: TObject);
var t : Integer;
begin
  Memo1.Lines.Clear;

  for t:=0 to ListBox1.Count-1 do
      TestExpression(ListBox1.Items[t]);
end;

procedure TFormMain.BExampleFormulaClick(Sender: TObject);
const
  Test=' (3*2) + Sqr(4) - 7 ';

var x : Integer;
begin
  // Quick way to evaluate a string
  x:=TExpression.Evaluate(Test);

  LabelResult.Text:=x.ToString;

  SetNewExpression(Test);
end;

procedure TFormMain.Button8Click(Sender: TObject);
var Benchmark : TBenchmark;
begin
  // Create the expressions
  Benchmark.Initialize(ListBox1.Items);

  // Evaluate all expressions
  Benchmark.EvaluateAll;

  // Display results
  Benchmark.ShowResults(Memo1.Lines);

  // Release the expressions
  Benchmark.DestroyAll;
end;

// Parse S string into Expression variable
procedure TFormMain.ParseExpression(const AExpression:String);
var tmp : TExpression;
    Ok : Boolean;
begin
  BEvaluate.Enabled:=False;

  try
    Ok:=True;

    // Try to parse AExpression string to create a TExpression

    tmp:=TExpression.FromString(AExpression,
           function(const S:String; IsFunction:Boolean):TExpression
           begin
             // Parse error, unknown identifier

             LabelResult.Text:='Unknown: '+S;
             result:=nil;
           end,
           function(const APos:Integer; const Text:String):Boolean
           begin
             // Parse error

             LabelResult.Text:=Text+' at '+IntToStr(APos);
             Ok:=False;

             result:=True;
           end);

    // Replace old expression with new one
    Expression.Free;
    Expression:=tmp;

    if Expression<>nil then
       ShowTree;

    BEvaluate.Enabled:=Expression<>nil;

    if BEvaluate.Enabled and Ok then
       BEvaluateClick(Self); // Evaluate
  except

    // Parsing error
    on E:EExpressionParse do
       LabelResult.Text:=E.Message+' at '+IntToStr(E.Position);
  end;
end;

procedure TFormMain.Edit1Change(Sender: TObject);
begin
  if not Changing then
     ParseExpression(Edit1.Text);
end;

// Fills TreeView1 with the Expression object tree
procedure TFormMain.ShowTree;
begin
  FillTree(TreeView1,Expression);
  TreeView1.ExpandAll;
end;

// Converts the Expression to string and fills the treeview
procedure TFormMain.Present;
begin
  SetNewExpression(Expression.ToString);
  ShowTree;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  // This example contains test strings in USA format:
  FormatSettings.DecimalSeparator:='.';
  FormatSettings.DateSeparator:='/';
  FormatSettings.ShortDateFormat:='M/d/yyyy';

  // Start with a manually created expression,
  // equivalent to: "1+2"
  Expression:=TArithmeticExpression.Create(TFloatExpression.Create(1),TArithmeticOperand.Add,TFloatExpression.Create(2));

  Present;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  // Release memory
  Expression.Free;
  Animals.Free;
end;

// Set Edit1 and parse the new expression
procedure TFormMain.SetNewExpression(const AExpression:String);
begin
  Changing:=True; // <-- flag to prevent multiple parsing at Edit1 OnChange
  try
    Edit1.Text:=AExpression;
    ParseExpression(Edit1.Text);
  finally
    Changing:=False;
  end;
end;

procedure TFormMain.ListBox1Change(Sender: TObject);
var S : String;
begin
  S:=ListBox1.Items[ListBox1.ItemIndex];
  TestExpression(S);
end;

end.
