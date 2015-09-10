{========================================================
   信息管理的主窗体
   @ zhiguo.wu
   2014-06-12 20:00
========================================================}

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, ComCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ImgList, Menus, cxLookAndFeels, cxLookAndFeelPainters;

type
  TFrmMain = class(TForm)
    GroupBoxMain: TGroupBox;
    PanelMain: TPanel;
    PanelLeft: TPanel;
    PanelRight: TPanel;
    TreeViewMain: TTreeView;
    ImageList: TImageList;
    PopupMenuMain: TPopupMenu;
    AddNew: TMenuItem;
    AddModify: TMenuItem;
    N3: TMenuItem;
    InfoCancel: TMenuItem;
    PopupMenuLeft: TPopupMenu;
    AddType: TMenuItem;
    cxgrd1: TcxGrid;
    cxgrdbtblvwGrid1DBTableViewList: TcxGridDBTableView;
    cxgrdlvlGrid1LevelList: TcxGridLevel;
    cxgrdbclmnGrid1DBTableViewListID: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableViewListName: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableViewListClassify: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableViewListPrice: TcxGridDBColumn;
    cxgrdbtblvwGrid1DBTableViewListProducingArea: TcxGridDBColumn;
    dsDetail: TDataSource;
    procedure AddModifyClick(Sender: TObject);
    procedure AddNewClick(Sender: TObject);
    procedure AddTypeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure InfoCancelClick(Sender: TObject);
    procedure TreeViewMainChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewMainClick(Sender: TObject);
    procedure TreeViewMainCollapsing(Sender: TObject; Node: TTreeNode; var
      AllowCollapse: Boolean);
    procedure TreeViewMainDblClick(Sender: TObject);
    procedure TreeViewMainExpanding(Sender: TObject; Node: TTreeNode; var
      AllowExpansion: Boolean);
  private
    procedure FillDataToCxGrid(NodeValue: string);
    procedure ManagerEdtFrm(sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uList, uDBModule, uinfoEdit, uAddType;

{$R *.dfm}



procedure TFrmMain.ManagerEdtFrm(sender: TObject);
begin
  ShowInfoEditFrm(TButton(sender).Name, DBConn.FListQuery);
  initTreeView(TreeViewMain);
end;

procedure TFrmMain.AddModifyClick(Sender: TObject);
begin
  if not DBConn.FListQuery.Eof then
  begin
    ManagerEdtFrm(Sender);
  end;
end;

procedure TFrmMain.AddNewClick(Sender: TObject);
begin
  ManagerEdtFrm(Sender);
end;

procedure TFrmMain.AddTypeClick(Sender: TObject);
begin
  ShowAddTypeFrm(DBConn.FViewQuery);
  initTreeView(TreeViewMain);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  DBConn := TDBConn.Create(nil);
end;


procedure TFrmMain.FormShow(Sender: TObject);
begin
  TreeViewMain.Images := ImageList;
  initTreeView(TreeViewMain);
end;



procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmMain.TreeViewMainChange(Sender: TObject; Node: TTreeNode);
begin
  if Node = nil then exit;

  if Node.Level < 2 then //当选择的子结点为"所有类型"或者"大类" 时
  begin
    if Node.Expanded = False then
      Node.Expanded := True;
  end;
end;

procedure TFrmMain.TreeViewMainClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeViewMain.Selected;

  if (Node.Level = 0) or (Node.Level = 1) then
  begin
    TreeViewMain.PopupMenu := PopupMenuLeft;
  end else
  begin
    TreeViewMain.PopupMenu := nil;
  end;

end;

procedure TFrmMain.TreeViewMainCollapsing(Sender: TObject; Node: TTreeNode; var
  AllowCollapse: Boolean);
begin
  if (Node.Level = 0) or (Node.Level = 1) then
  begin
    Node.ImageIndex := 0;
    Node.SelectedIndex := 0;
  end;
end;

procedure TFrmMain.TreeViewMainDblClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeViewMain.Selected;

  if Node.Level = 2 then
  begin
    FillDataToCxGrid(Node.Text);

  end;
end;

procedure TFrmMain.TreeViewMainExpanding(Sender: TObject; Node: TTreeNode; var
  AllowExpansion: Boolean);
begin
  if (Node.Level = 0) or (Node.Level = 1) then
  begin
    Node.ImageIndex := 1;
    Node.SelectedIndex := 1;
  end;
end;


procedure TFrmMain.FillDataToCxGrid(NodeValue: string);
var
  StrSQL: string;
begin
  if Trim(NodeValue) = '' then Exit;

  StrSQL := ' SELECT * FROM T_Detail Det Left Join T_Type Tye on Det.TypeCode = Tye.TypeCode  WHERE Det.DetName = ''' + Trim(NodeValue) + ''' ';

  if DBConn.GetRecord(DBConn.FListQuery, StrSQL) then
  begin
    dsDetail.DataSet := DBConn.FListQuery;
  end;

end;

procedure TFrmMain.InfoCancelClick(Sender: TObject);
var
  StrSql: string;
begin
  if DBConn.FListQuery.Eof then
  begin
    Exit;
  end;

  if Application.MessageBox('确定要删除此记录？', '提示', MB_OKCANCEL + MB_ICONINFORMATION) = IDOK then
  begin

    StrSql := ' DELETE FROM T_Detail WHERE PID = ' + DBConn.FListQuery.FieldByName('Det.PID').AsString;

    if DBConn.ExecSQL(DBConn.Fqry, StrSql) then
    begin
      DBConn.FListQuery.Close;
      DBConn.FListQuery.Open;

      initTreeView(TreeViewMain);
    end;

  end;

end;

end.

