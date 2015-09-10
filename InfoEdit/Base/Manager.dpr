program Manager;

uses
  Forms,
  uMain in 'uMain.pas' {FrmMain},
  uConfig in 'common\uConfig.pas',
  uList in 'common\uList.pas',
  uinfoEdit in 'uinfoEdit.pas' {FrmEdit},
  uAddType in 'uAddType.pas' {FrmType},
  AES in 'common\AES.pas',
  uDBModule in 'common\uDBModule.pas' {DBConn: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDBConn, DBConn);
  Application.CreateForm(TFrmEdit, FrmEdit);
  Application.CreateForm(TFrmType, FrmType);
  Application.Run;
end.
