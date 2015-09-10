{========================================================
   ListView 操作单元
   @ zhiguo.wu
   2014-06-12 21:00
========================================================}

unit uList;


interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ADODB, DB;

type
  ptTreeNode = ^TTreeData;

  TTreeData = record
    NodeValue: string;

  end;

  procedure FillTreeViewFile(TreeView: TTreeView; TargetNode: TTreeNode);
  procedure initTreeView(vwName: TTreeView);

implementation

uses uDBModule;

var
  FileTreeNode: ptTreeNode;


procedure FillTreeViewFile(TreeView: TTreeView; TargetNode: TTreeNode);   // 动态创建树
var
  TreeNodeParent: TTreeNode;

  procedure CreateSubTree(FNodeName: string; Node: TTreeNode);
  var
    TreeNode: TTreeNode;
  begin
    with DBConn.FDSView do
    try
      Close;
      CommandText := ' SELECT  TypeCode, DetName  From T_Detail WHERE TypeCode = ' + FNodeName + ' ORDER BY PID ';
      Open;
      First;
      while not Eof do
      begin
        New(FileTreeNode);
        FileTreeNode^.nodeValue := FieldbyName('TypeCode').Asstring;
        TreeNode:= TreeView.Items.AddChildObject(node, FieldByName('DetName').AsString, FileTreeNode);
        TreeNode.ImageIndex := 2;
        TreeNode.SelectedIndex := 3;
        Next;
      end;
    finally
    end;
  end;

begin
  TreeView.Items.BeginUpdate;
  //TreeView.Items.Clear;
  if TargetNode <> nil then
    TargetNode.DeleteChildren;

  DBConn.GetRecord(DBConn.FViewQuery, 'SELECT TypeCode, TypeName From T_Type ORDER BY PID ');

  while not DBConn.FViewQuery.Eof do
  begin
    New(FileTreeNode);
    FileTreeNode^.nodeValue := DBConn.FViewQuery.fieldbyname('TypeCode').asstring;
    TreeNodeParent := TreeView.Items.AddChildObject(TargetNode, DBConn.FViewQuery.FieldByName('TypeName').AsString, FileTreeNode);
    begin
      TreeNodeParent.ImageIndex := 0;
      TreeNodeParent.SelectedIndex := 0;
    end;
    CreateSubTree(DBConn.FViewQuery.fieldbyname('TypeCode').asstring, TreeNodeParent);
    DBConn.FViewQuery.Next;
  end;
  TreeView.Items.EndUpdate;

end;


procedure initTreeView(vwName: TTreeView);
var
  tmpNode: TTreeNode;
begin

  vwName.Items.BeginUpdate;
  vwName.Items.Clear;
  New(FileTreeNode);
  FileTreeNode^.nodeValue := 'all';
  tmpNode := vwName.Items.AddChildObject(nil, '所有类型', FileTreeNode);
  FillTreeViewFile(vwName, tmpNode);
  vwName.Items.EndUpdate;
  vwName.SetFocus;
  vwName.TopItem.Selected := True;
//  vwName.TopItem.Expanded:=True;
  vwName.TopItem.Item[0].Selected := True;
end;


end.

