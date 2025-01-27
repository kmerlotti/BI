unit BI.Languages.English;

interface

var
  // DataItem
  BIMsg_DataItem_ChildNotFound:String      = 'Error: Child data: %s not found';
  BIMsg_CannotAccessData:String            = 'Cannot access data: %s from: %s';
  BIMsg_RelativeOriginNoParent:String      = 'Error: Cannot find relative ".." origin, data: %s has no parent';
  BIMsg_UnNamed:String                     = '(unnamed)';

  // Stores
  BIMsg_Store_ErrorOpening:String          = 'Error: %s opening store: %s';
  BIMsg_Store_NotRegistered:String         = 'Error: Store %s is not configured in this machine registry';
  BIMsg_Store_MissingImporter:String       = 'Error: Cannot find data importer class for store: %s';
  BIMsg_Store_AlreadyExists:String         = 'Error: Store already exists: %s';
  BIMsg_Store_DataLoadError:String         = 'Error: Loading data: %s from store: %s';
  BIMsg_Store_WrongName:String             = 'Error: Store name cannot contain ":" character: %s';
  BIMsg_Store_EmptyName:String             = 'Error: Store name cannot be empty';
  BIMsg_Store_SelectRemote:String          = 'Select Remote Store';
  BIMsg_Store_SureRemove:String            = 'Are you sure to remove store: %s from registry?';
  BIMsg_Store_ChangeName:String            = 'Change Store Name';
  BIMsg_Store_SureToDelete:String          = 'Are you sure to delete data: %s?';

  // Data Manager
  BIMsg_NewDataSource:String               = 'New Data Source';
  BIMsg_Name:String                        = 'Name';
  BIMsg_Data_ChangeName:String             = 'Change Data Name';
  BIMsg_DataSourceAlreadyExists:String     = 'Data: %s already exists. Choose a different name';

  // Web, Web Server
  BIMsg_Web_LatestVersionDownloaded:String = 'Latest version downloaded. Please re-start';
  BIMsg_Web_ErrorCheckingUpdates:String    = 'Cannot check for updates, error checking latest version: %s';
  BIMsg_Web_NoDefaultStore:String          = 'BIWeb server cannot continue without a default Store';
  BIMsg_Web_ErrorWrongOrigin:String        = 'Error: Wrong web origin: %s';
  BIMsg_Web_ErrorEmptyDataStream:String    = 'Error: Web data stream is empty';
  BIMsg_Web_ErrorUnzip:String              = 'Error: Empty data uncompressing BIWeb stream.';

  // Persist
  BIMsg_Persist_IncompatibleVersion:String = 'Data cannot be loaded. It was created with an old non-compatible version: %d';
  BIMsg_Persist_CorruptIndex:String        = 'Error: Corrupt data index count: %s %d';
  BIMsg_Persist_CorruptLoad:String         = 'Error: Corrupt data kind: %s (%s)';

  // Dataset
  BIMsg_Dataset_NoData:String              = 'Cannot open BIDataSet. No Data assigned';
  BIMsg_Dataset_NoDetail:String            = 'Error: Cannot link BIDataset to master dataset, no detail data';
  BIMsg_Dataset_NotAsTable:String          = 'Internal Error: Data is not AsTable searching for: %s';
  BIMsg_Dataset_DataNotFound:String        = 'Internal Error: Data not found: %s';

  // Summary:
  BIMsg_Summary_NoMainData:String          = 'Summary: No main data item.';
  BIMsg_Summary_AtLeastOne:String          = 'Summary: At least one active Measure or Groupby should be selected.';
  BIMsg_Summary_ErrorSortParameter:String  = 'Error in sort parameter: %s';
  BIMsg_Summary_WrongAggregate:String      = 'Error: Wrong measure aggregate: %s';
  BIMsg_Summary_MeasureNilData:String      = 'Summary missing Data adding measure';
  BIMsg_Summary_MeasureNilExpression:String= 'Summary missing Expression adding measure';
  BIMsg_Summary_GroupByNilData:String      = 'Summary missing Data adding groupby';
  BIMsg_Summary_GroupByNilExpression:String= 'Summary missing expression adding groupby';
  BIMsg_Summary_DeleteMeasure:String       = 'Error: Delete measure index out of bounds: %d';
  BIMsg_Summary_SwapMeasure:String         = 'Error: Swap measure index out of bounds: %d';
  BIMsg_Summary_DeleteGroupBy:String       = 'Error: Delete groupby index out of bounds: %d';
  BIMsg_Summary_SwapGroupBy:String         = 'Error: Swap groupby index out of bounds: %d';

  // Arrays:
  BIMsg_DifferentArrayLength:String        = 'Arrays are of different length';

  // JSON
  BIMsg_JSON_WrongClass:String             = 'Wrong JSON class: %s';

  // XML
  BIMsg_XML_WrongContent:String            = 'Wrong XML content';

  // CSV
  BIMsg_CSV_FirstRowNoFields:String        = 'First row contains no fields';

  // ZIP
  BIMsg_ZIP_FileNotValid:String            = 'Zip file format not valid: %s';

  // Import
  BIMsg_ImporterMissing:String             = 'Cannot find importer class for data path: %s';
  BIMsg_FileImporterMissing:String         = 'Cannot find importer class for data file: %s';
  BIMsg_ImportError:String                 = 'Cannot import data: %s';

  // Export
  BIMsg_Export:String                      = 'Export';
  BIMsg_Export_EmptyData:String            = 'Error: Cannot export empty data';

  // DB
  BIMsg_DB_NoEngineConfigured:String       = 'Error: No Database Engine configured. Use BI.Data.DB FireDAC or SQLExpr units';
  BIMsg_DB_SqlExpressWrongConnection:String= 'Error: Connection is not TSQLConnection (SqlExpress engine)';
  BIMsg_ConnectionTestPassed:String        = 'Connection test passed';
  
  // Http
  BIMsg_Http_UserCancelled:String          = 'Http request user cancelled';

  // Grid
  BIMsg_Grid_MissingEngine:String          = 'Error: Missing BIGrid Engine plugin';

  // UI
  BIMsg_ChooseFolder:String                = 'Choose a folder';
  BIMsg_NewName:String                     = 'New name:';
  BIMsg_Default:String                     = '(default)';

  // Navigator
  BIMsg_NavigatorSingleItem:String         = '%d of %d';
  BIMsg_NavigatorItem:String               = '%d-%d of %d';
  BIMsg_NavigatorPage:String               = 'Page %d of %d';

  // Expressions
  BIMsg_ExpressionError:String             = 'Error: %s at position: %d';
  BIMsg_ExpressionEmpty:String             = 'Error: Empty expression: %s';
  BIMsg_ExpressionFunctionMissing:String   = 'Cannot find function: %s';
  BIMsg_ExpressionNotLogical:String        = 'Expression: %s is not boolean (logical)';

  // Sort
  BIMsg_SortNoItems:String                 = 'Sort error: At least a defined Item is necessary';
  BIMsg_SortNoData:String                  = 'Sort error: No Data specified';
  BIMsg_SortWrongParent:String             = 'Sort error: Parent of data: %s is not data: %s';

  // Server
  BIMsg_ServerAlreadyRunning:String        = 'BIWeb Server is already running.';
  BIMsg_ServerSureToClose:String           = 'Are you sure to close this server? (There are %d active conections)';

implementation
