{========================================================
   信息编辑单元
   @ zhiguo.wu
   2014-06-12 20:00
========================================================}

unit uinfoEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, uDBModule, DB, ADODB;

type
  TFrmEdit = class(TForm)
    PanelBottom: TPanel;
    PanelMain: TPanel;
    BtnNew: TButton;
    BtnCancel: TButton;
    EdtName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxClassity: TComboBox;
    EditArea: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EdtPrice: TEdit;
    lblUnit: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure EdtPriceKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FValueQuery: TADOQuery;
    MethodType: string;

    function AddValueToComBoBox(Cmbox: TComboBox; FieldName: string): Boolean;
    procedure initFromValue(Mtype: string);
    function IFValueEmpty(Sender: TObject): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEdit: TFrmEdit;

procedure ShowInfoEditFrm(StrType: string; Fquery: TADOQuery);

implementation


{$R *.dfm}


procedure ShowInfoEditFrm(StrType: string; Fquery: TADOQuery);
begin
  with TFrmEdit.Create(nil) do
  begin
    FValueQuery := Fquery;
    MethodType := StrType;

    initFromValue(MethodType);
    ShowModal;
    Free;
  end;


end;

procedure TFrmEdit.FormCreate(Sender: TObject);
begin
  AddValueToComBoBox(ComboBoxClassity, 'TypeName');
end;

procedure TFrmEdit.initFromValue(Mtype: string);
var
  PriceValue: string;
begin
  if SameText(Mtype, 'AddNew') then
  begin
    EdtName.Text := '';
    EdtPrice.Text := '';
    EditArea.Text := '';

    ComboBoxClassity.ItemIndex := 0;
  end;

  if SameText(Mtype, 'AddModify') then
  begin
    with FValueQuery do
    begin
      if not Eof then
      begin
        EdtName.Text := FieldByName('DetName').AsString;
        PriceValue := FieldByName('Price').AsString;
        EdtPrice.Text := Copy(PriceValue, 1, Pos('元', PriceValue) - 1);
        EditArea.Text := FieldByName('ProducingArea').AsString;

       // ShowMessage(FieldByName('TypeName').AsString);
        ComboBoxClassity.ItemIndex:= ComboBoxClassity.Items.IndexOf( FieldByName('TypeName').AsString);
      end;
    end;
  end;

end;


function TFrmEdit.IFValueEmpty(Sender: TObject): Boolean;
begin
  Result := False;

  if SameText(TButton(sender).Name, TButton(BtnNew).Name) then
  begin
    if Trim(EdtName.Text) = '' then
    begin
      EdtName.SetFocus;
      Exit;
    end;
    if Trim(EdtPrice.Text) = '' then
    begin
      EdtPrice.SetFocus;
      Exit;
    end;
    if Trim(EditArea.Text) = '' then
    begin
      EditArea.SetFocus;
      Exit;
    end;
    if Trim(ComboBoxClassity.Text) = '' then
    begin
      ComboBoxClassity.SetFocus;
      Exit;
    end;

    Result := True;
  end;
end;

procedure TFrmEdit.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFrmEdit.AddValueToComBoBox(Cmbox: TComboBox; FieldName: string): Boolean;
var
  Strsql: string;
  I: Integer;
begin
  if Trim(FieldName) = '' then Exit;

  Strsql := 'SELECT ' + FieldName + ' FROM T_Type ORDER BY PID ';

  Cmbox.Clear;
  if DBConn.GetRecord(DBConn.Fqry, Strsql) then
  begin
    with DBConn.Fqry do
    begin
      First;

      while not Eof do
      begin
        Cmbox.Items.Add(FieldByName(FieldName).AsString);
        Next;
      end;
    end;
  end;
  Cmbox.ItemIndex := 0;
end;

procedure TFrmEdit.BtnNewClick(Sender: TObject);
var
  StrSQL, StrVal: string;
begin
  if not IFValueEmpty(BtnNew) then Exit;

  StrVal := ' SELECT * FROM T_TYPE ';

  if not DBConn.GetRecord(DBConn.FLtqry, StrVal) then
  begin
    Exit;
  end;

  DBConn.FLtqry.Locate('TypeName', ComboBoxClassity.Text, []);


  if SameText(MethodType, 'AddNew') then
  begin

    StrVal := 'SELECT * FROM T_Detail WHERE DetName = ''' + Trim(EdtName.Text) + ''' ';

    if DBConn.GetRecord(DBConn.Fqry, StrVal) then
    begin
      if not DBConn.Fqry.Eof then
      begin
        ShowMessage('数据库中已存在该分类');
        EdtName.SetFocus;
        Exit;
      end;
    end;


    StrSQL := ' INSERT INTO T_Detail(DetName, Price, ProducingArea, TypeCode) VALUES ( ' +
      ' ''' + Trim(EdtName.Text) + ''', ''' + Trim(EdtPrice.Text) + '元/Kg'',  ''' + Trim(EditArea.Text) + ''', ' +
      ' ''' + Trim(DBConn.FLtqry.FieldByName('TypeCode').AsString) + ''') ';
  end
  else if SameText(MethodType, 'AddModify') then
  begin
    StrSQL := ' UPDATE T_Detail SET  DetName = ''' + Trim(EdtName.Text) + ''', Price = ''' + Trim(EdtPrice.Text) + '元/Kg'' , ' +
      ' ProducingArea = ''' + Trim(EditArea.Text) + ''', TypeCode = ' + Trim(DBConn.FLtqry.FieldByName('TypeCode').AsString) + ' ' +
      ' WHERE PID = ' + FValueQuery.FieldByName('Det.PID').AsString ;
  end else
  begin
    Exit;
  end;

  DBConn.ExecSQL(DBConn.Fqry, StrSQL);

  Close;

end;

procedure TFrmEdit.EdtPriceKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', '.', #13, #8]) then
    Key := #0; ;

end;

end.

