{========================================================
   类型增加单元
   @ zhiguo.wu
   2014-06-12 20:00
========================================================}
unit uAddType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, ADODB, uDBModule;

type
  TFrmType = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnAdd: TButton;
    BtnCancel: TButton;
    EdtTypeName: TEdit;
    lblTypeName: TLabel;

    procedure BtnAddClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FVtQuery: TADOQuery;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmType: TFrmType;

procedure ShowAddTypeFrm(FVQuery: TADOQuery);

implementation

uses uList;

{$R *.dfm}


procedure ShowAddTypeFrm(FVQuery: TADOQuery);
begin
  with TFrmType.Create(nil) do
  begin
    FVtQuery := FVQuery;

    ShowModal;
    Free;
  end;

end;

procedure TFrmType.BtnAddClick(Sender: TObject);
var
  StrSql: string;
  MaxValue: Integer;
begin
  if Trim(EdtTypeName.Text) = '' then
  begin
    EdtTypeName.SetFocus;
    Exit;
  end;


  StrSql := 'SELECT * FROM T_Type WHERE TypeName = ''' + Trim(EdtTypeName.Text) + ''' ';

  if DBConn.GetRecord(DBConn.Fqry, StrSql) then
  begin
    if not DBConn.Fqry.Eof then
    begin
      ShowMessage('数据库中已存在该分类');
      EdtTypeName.SetFocus;
      Exit;
    end;
  end;

  if DBConn.GetRecord(DBConn.Fqry, 'SELECT Max(TypeCode) AS TypeCode From T_Type ') then
  begin
    MaxValue := DBConn.Fqry.FieldByName('TypeCode').AsInteger;

    Inc(MaxValue);

    StrSql := 'INSERT INTO T_Type(TypeName, TypeCode) Values (''' + Trim(EdtTypeName.Text) + ''',  '+IntToStr(MaxValue)+')';

    DBConn.ExecSQL(DBConn.Fqry, StrSql);

    FVtQuery.Close;
    FVtQuery.Open;

    Close;
  end;

end;




procedure TFrmType.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmType.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

