{*********************************************}
{  TeeBI Software Library                     }
{  HTML Web Dashboard                         }
{  Copyright (c) 2015-2016 by Steema Software }
{  All Rights Reserved                        }
{*********************************************}
unit BI.Dashboard.HTML;

interface

{$IFNDEF FPC}
{$DEFINE HASTEECHART}
{$ENDIF}

uses
  System.Classes,

  {$IFNDEF FPC}
  System.Generics.Collections,
  {$ENDIF}

  {$IFDEF HASTEECHART}
  {$IFDEF FMX}
  FMXTee.Constants, FMXTee.Engine,
  {$ELSE}
  VCLTee.TeeConst, VCLTee.TeEngine,
  {$ENDIF}
  {$ENDIF}

  BI.Dashboard;

{$IF (TeeVCLBuildVersionInteger >= 160309)}
{$DEFINE HASJSCRIPTGETSERIES} // New event at TJavascriptExportFormat
{$ENDIF}

type
  TDiv=record
  public
    Item : TDashboardItem;
    ID : String;
    Style : String;
    HTML : String;
    Position : String;
  end;

  TDivs=class(TList<TDiv>)
  public
    function IndexOfPosition(const APosition:String):Integer;
  end;

  THTMLRender=class(TRender)
  private
  const
    ItemSeparator='%----%';

  var
    Charts : TStringList;
    Divs : TDivs;
    FHTML : TStringList;
    FMinify : Boolean;
    FTitle : String;

    IAnyGauge : Boolean;
    IAnyMap   : Boolean;

    IBody : String;
    IRadioCount,
    IDivCount : Integer;
    IAnyList : Boolean;
    IUpdate : Boolean;

    {$IFDEF AUTOREFCOUNT}
    [Weak]
    {$ENDIF}
    IDashboard : TDashboard;

  const
    ScriptBegin='<script type="text/javascript">';
    ScriptEnd='</script>';
    CSSBegin='<style type="text/css">';
    CSSEnd='</style>';

    procedure Add(const S:String); inline;
    procedure AddAllChartsFunctions;
    procedure AddButtonsCSS;
    procedure AddCSS;
    procedure AddListChange;
    procedure AddPartialHead;
    procedure AddTeeScript(const AScript:String);
    procedure AddUpdateScript;
    procedure EmitDivs;

    function FreeChartName:String;

    {$IFDEF HASJSCRIPTGETSERIES}
    function GetJScriptSeries(const ASeries:TChartSeries):String;
    {$ENDIF}

    function HTMLGrid(const AItem:TDashboardItem):String;

    procedure PrepareVariables(const AParams:TStrings);
  protected
    procedure AddItemSeparator(const AIndex:Integer=-1; const AKind:String=''); override;
    procedure AddListener(const AName:String; const ADataIndex:Integer); override;
  public
    const
      PureCSS='<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">';

    var
      CSS: String;
      SteemaSources:String;

    Constructor Create;
    Destructor Destroy; override;

    procedure Emit(const ADashboard:TDashboard; const AItem:Integer; const APosition:String); override;
    procedure Init(const ADashboard:TDashboard; const ALayout:String=''; const AParams:TStrings=nil); override;

    procedure Finish; override;

    property HTML:TStringList read FHTML;
    property MinifyScripts:Boolean read FMinify write FMinify default True;
    property Title:String read FTitle write FTitle;
  end;

implementation
