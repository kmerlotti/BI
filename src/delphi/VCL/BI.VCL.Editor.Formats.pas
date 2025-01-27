{*********************************************}
{  TeeBI Software Library                     }
{  Data Formats Editor                        }
{  Copyright (c) 2015-2016 by Steema Software }
{  All Rights Reserved                        }
{*********************************************}
unit BI.VCL.Editor.Formats;

interface

uses
  {$IFNDEF FPC}
  Winapi.Windows, Winapi.Messages,
  {$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  BI.DataSource, BI.Persist;

type
  TDataFormatEditor = class(TForm)
    PageFormat: TPageControl;
    TabCSV: TTabSheet;
    Label1: TLabel;
    CBDelimiter: TComboBox;
    ECustomDelimiter: TEdit;
    Label2: TLabel;
    CBQuote: TComboBox;
    Label3: TLabel;
    EMissing: TEdit;
    Label4: TLabel;
    CBHeader: TComboBox;
    Label5: TLabel;
    Edit1: TEdit;
    UDHeader: TUpDown;
    TabZip: TTabSheet;
    EZipPassword: TEdit;
    Label6: TLabel;
    TabExcel: TTabSheet;
    Label7: TLabel;
    EExcelHeader: TEdit;
    UDExcelHeader: TUpDown;
    procedure CBDelimiterChange(Sender: TObject);
    procedure ECustomDelimiterChange(Sender: TObject);
    procedure CBQuoteChange(Sender: TObject);
    procedure CBHeaderChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure EMissingChange(Sender: TObject);
    procedure EZipPasswordChange(Sender: TObject);
    procedure EExcelHeaderChange(Sender: TObject);
  private
    { Private declarations }
    IData : TDataDefinition;

    procedure RefreshCSV;
    procedure RefreshExcel;
    procedure RefreshZip;
  public
    { Public declarations }
    class procedure Embedd(const AData:TDataDefinition; const AParent:TWinControl); static;
    procedure Refresh(const AData:TDataDefinition);
  end;

implementation
