unit Unit17;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls,
  INIFiles, StdCtrls;

type
  TQHD = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    ADOQuerySQL: TADOQuery;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key:
      Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure c1;

    { Public declarations }
  end;

var
  QHD: TQHD;

implementation

uses Unit4, Unit2;

{$R *.dfm}

procedure TQHD.SpeedButton1Click(Sender: TObject);
begin
  QHD.Close;
end;

procedure TQHD.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: SpeedButton1.Click;
    VK_SPACE: SpeedButton2.Click;

    VK_UP:
      begin
        DBGrid1.SetFocus;
      end;

    VK_DOWN:
      begin
        DBGrid1.SetFocus;
      end;
  end;
end;

{ȷ��ѡ��ʱ�����Ƽ�¼ȥAftersellmain��}

procedure TQHD.SpeedButton2Click(Sender: TObject);
begin
  //Main_T.Label26.Caption := ADOQuery1.FieldByName('slid').AsString;

  if Main_T.ADOQuery1.RecordCount > 1 then
  begin
    //Ŀǰһ���˻����ϲ�����ͬʱ�������Ų�һ���ĳ��ⵥ
    ShowMessage('��ǰ�Ѿ������ڲ������ۺ󵥣����������µ��˻����ˡ�');
    Exit;
  end;

  Main.ADOConnection1.BeginTrans;
  try

    {���Ƽ�¼}
    //���� �����ۺ󵥵���Դ�ǳ��ⵥ�����ó�ʼ״̬Ϊ   �ۺ��У���ʼ״̬Ϊ 0
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('insert into aftersellmains(tid,custid,custstate,custname,custtel,custaddr,yingshou,shishou,shoukuan,zhaoling,sid,sname,stel,saddress,payment,status,uid,uname,preid,nextid,type,cdate,remark,created_at,updated_at) select "' + Main_T.Label26.Caption +
      '" as tid,custid,custstate,custname,custtel,custaddr,yingshou,shishou,shoukuan,zhaoling,sid,sname,stel,saddress,payment,"0" as status,uid,uname,"' +
      ADOQuery1.FieldByName('slid').AsString +
      '" as preid,nextid,"������" as type,now() as cdate,remark,now() as created_at,now() as updated_at from selllogmains where slid="' +
      ADOQuery1.FieldByName('slid').AsString + '"');
    ADOQuerySQL.ExecSQL;

    //��ϸ�� �������ۼ�¼�������ۺ��ţ���ʼ״̬Ϊ0����ʼ����Ϊ-�������ۺ�
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('insert into afterselldetails(tid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,');
    ADOQuerySQL.SQL.Add('ramount,bundle,rbundle,discount,additional,subtotal,status,type,cdate,remark,created_at,updated_at) select "' + Main_T.Label26.Caption +
      '" as tid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,camount,camount,cbundle,cbundle,discount,' +
      'additional,subtotal,"0" as status,"-" as type,now() as cdate,remark,now() as created_at,now() as updated_at from selllogdetails where slid="' +
      ADOQuery1.FieldByName('slid').AsString + '"');
    ADOQuerySQL.ExecSQL;

    //����
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('update selllogmains set type="�ۺ���",nextid="' +
      Main_T.Label26.Caption + '" where slid="' +
      ADOQuery1.FieldByName('slid').AsString + '"');
    ADOQuerySQL.ExecSQL;

    Main.ADOConnection1.CommitTrans;
  except
    Main.ADOConnection1.RollbackTrans;
  end;

  {�ָ��ͻ�����������Ϣ}
  Main_T.edt1.Text :=
    ADOQuery1.FieldByName('custname').AsString;
  Main_T.edt2.Text :=
    ADOQuery1.FieldByName('custtel').AsString;
  Main_T.edt3.Text :=
    ADOQuery1.FieldByName('custaddr').AsString;
  Main_T.edt7.Text :=
    ADOQuery1.FieldByName('custid').AsString;
  Main_T.edt8.Text :=
    ADOQuery1.FieldByName('custstate').AsString;
  Main_T.RzEdit7.Text :=
    ADOQuery1.FieldByName('shopname').AsString;

  Main_T.edt4.Text :=
    ADOQuery1.FieldByName('sname').AsString;
  Main_T.edt5.Text :=
    ADOQuery1.FieldByName('stel').AsString;
  Main_T.edt6.Text :=
    ADOQuery1.FieldByName('saddress').AsString;

  Main_T.cbb1.Text :=
    ADOQuery1.FieldByName('payment').AsString;
  Main_T.mmo1.Text :=
    ADOQuery1.FieldByName('remark').AsString;

  Main_T.QH1;
  Main_T.QH2;

  Main_T.RzEdit4.Text := '';

  SpeedButton1.Click;
end;

procedure TQHD.c1;
begin
  //���û�йҵ��������˳�
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('�ҵ���û�м�¼~~!');
    QHD.Close;
  end
end;

procedure TQHD.DBGrid1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

{��ѯ���ۼ�¼��}
//Ĭ�ϱ�������Ϊ100��

procedure TQHD.FormShow(Sender: TObject);
begin
  if Main_T.qsrc = 'custname' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select sm.* from selllogdetails sd,selllogmains sm where sd.additional<>"����" and');
    ADOQuery1.SQL.Add(' sd.camount>0 and sd.slid=sm.slid and sm.type<>"�ۺ���" and sm.created_at between date_add(now(),interval -100 day) and now() and sm.custname like "%' +
      Main_T.edt1.Text + '%" group by sm.slid');
    ADOQuery1.Active := True;
  end
  else if Main_T.qsrc = 'pid' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select sm.* from selllogdetails sd,selllogmains sm where sd.pid="' + Main_T.RzEdit4.Text +
      '" and sd.additional<>"����" and');
    ADOQuery1.SQL.Add(' sd.camount>0 and sd.slid=sm.slid and sm.type<>"�ۺ���" and sm.created_at between date_add(now(),interval -100 day) and now() and sm.custname like "%' +
      Main_T.edt1.Text + '%" group by sm.slid');
    ADOQuery1.Active := True;
  end;

end;

end.