unit fMain2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Menus, fDef, ExtCtrls, DateUtils, StrUtils, MyGraph;

const
  MAC: array[0..3] of Integer = (30, 60, 120, 250);
  VMAC: array[0..2] of Integer = (5, 10, 30);
  RSIC: array[0..1] of Integer = (5, 10);
  PLC: array[0..0] of Integer = (1);

type
{ TVertLine }
  TVertLine = class(TGraphicControl)
  private
    FVisible: Boolean;
  protected
    FPosition: Integer;
    procedure SetPosition(const Value: Integer);
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Position: Integer read FPosition write SetPosition;
  end;

{ TfrmMain2 }
  TfrmMain2 = class(TForm)
    GRID: TStringGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mi100: TMenuItem;
    mi101: TMenuItem;
    N3: TMenuItem;
    mi0: TMenuItem;
    mi1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Header: TStringGrid;
    miLeftOne: TMenuItem;
    miRightOne: TMenuItem;
    miPageLast: TMenuItem;
    miPageFirst: TMenuItem;
    miFirst: TMenuItem;
    miLast: TMenuItem;
    miQuickLeft: TMenuItem;
    miQuickRight: TMenuItem;
    miSizing: TMenuItem;
    N2: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    miShowKLineHighLow: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    OpenDialog1: TOpenDialog;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    XTDAT1: TMenuItem;
    DATTXT1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GRIDDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure mi100Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure mi0Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HeaderDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure N3Click(Sender: TObject);
    procedure miPageLastClick(Sender: TObject);
    procedure miLeftOneClick(Sender: TObject);
    procedure miRightOneClick(Sender: TObject);
    procedure miUpOneClick(Sender: TObject);
    procedure miDownOneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure miPageFirstClick(Sender: TObject);
    procedure miFirstClick(Sender: TObject);
    procedure miLastClick(Sender: TObject);
    procedure miQuickLeftClick(Sender: TObject);
    procedure miQuickRightClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure XTDAT1Click(Sender: TObject);
    procedure DATTXT1Click(Sender: TObject);
  private
    FDataIndex: Integer;
    function GetDataPerPage: Integer;
    procedure SetDataIndex(Value: Integer);
  protected
    VertLine: TVertLine;
    ScaleHigh: array[0..3] of Single;
    ScaleLow: array[0..3] of Single;
    MA: array[0..5] of TArrayOfSingle;
    VMA: array[0..2] of TArrayOfSingle;
    RSI: array[0..1] of TArrayOfSingle;
    PL: array[0..0] of TArrayOfSingle;
    FStockName: string;
    FPageStart: Integer;
    FUnitWidth: Integer;
    procedure CalcMA;
    procedure CalcPL;
    procedure CalcVMA;
    procedure CalcRSI;
    procedure DrawK(C: TCanvas; R: TRect); overload;
    procedure DrawV(C: TCanvas; R: TRect); overload;
    procedure DrawRSI(C: TCanvas; R: TRect); overload;
    procedure DrawPL(C: TCanvas; R: TRect); overload;
    procedure DrawScaleK(C: TCanvas; R: TRect);
    procedure DrawScaleV(C: TCanvas; R: TRect);
    procedure DrawLine(A: TArrayOfSingle; Color: TColor; C: TCanvas; R: TRect; High, Low: Single);
    procedure SetStockName(const Value: string);
    procedure SetPageStart(Value: Integer);
    procedure SetUnitWidth(Value: Integer);
    procedure CalcAll;
    function FindKLineScaleHighLow(DataFile: IDataFile; var High, Low: Single;
      var HA, LA: TArrayOfSingle; var HIndex, LIndex: TArrayOfInteger): Boolean;
    function FindVLineScaleHighLow(DataFile: IDataFile; var High, Low: Single): Boolean;
    function PageIndex2DataIndex(Index: Integer): Integer;
    procedure DRAW_DATE_SCALE(C: TCanvas; R: TRect; ShowText: Boolean);
    procedure ITERATE_DATA(Index: Integer);
    procedure MOVE_VERTLINE(DataIndex: Integer); overload;
    function DataIndexToPixel(DataIndex: Integer): Integer;
    function PixelToDataIndex(X: Integer): Integer;
    procedure CLEAR_ALL_CALCULATE_DATA();
  public
    StkDataFile: IDataFile;
    function Fy2Iy(FY: Single; R: TRect; ScaleHigh, ScaleLow: Single): Integer;
    property StockName: string read FStockName write SetStockName;
    property PageStart: Integer read FPageStart write SetPageStart;
    property UnitWidth: Integer read FUnitWidth write SetUnitWidth;
    property DataPerPage: Integer read GetDataPerPage;
    property DataIndex: Integer read FDataIndex write SetDataIndex;
  end;

var
  frmMain2: TfrmMain2;

implementation

{$R *.dfm}

uses Math, fUtils;

procedure TfrmMain2.FormCreate(Sender: TObject);
begin
  IS_FRACTION_UNDERLINE := True;
  VertLine := TVertLine.Create(Self);
  WindowState := wsMaximized;
  FPageStart := 0;
  FDataIndex := 0;
  FUnitWidth := 6;
  GRID.Color := clBlack;
  //StockName := 'IFL0';//�����ļ���
  StockName := '.\DATA\IFL0.DAT'; //�����ļ���
  Header.Options := Header.Options - [goVertLine, goHorzLine];
  Header.Color := clBlack;
  Header.Cells[2, 0] := '''����'; //��ʾ�б���
  Header.Cells[4, 0] := '''���';
  Header.Cells[6, 0] := '''���';
  Header.Cells[8, 0] := '''����';
  Header.Cells[10, 0] := '''�ǵ�';
  Header.Cells[12, 0] := '''�ɽ���';
end;

procedure TfrmMain2.FormResize(Sender: TObject);
const //�������Ŀ���
  WWW: array[0..13] of Single = (4, 7.5, 2.5, 3.5, 2.5, 3.5, 2.5, 3.5, 2.5, 3.5, 2.5, 2.5, 3.5, 3.5);
var
  I, Temp: Integer;
  w, h: Single;
  R: TRect;
begin
  w := Round(GRID.ClientWidth * 19 / 20);
  GRID.ColWidths[1] := Max(24, Round(GRID.ClientWidth - w));
  GRID.ColWidths[0] := GRID.ClientWidth - GRID.ColWidths[1];

  //���岻ͬ����ĸ߶�
  h := (GRID.ClientHeight - 24) / 24;
  GRID.RowHeights[0] := 24;
  GRID.RowHeights[1] := Round(h * 12);
  GRID.RowHeights[2] := Round(h * 6);
  GRID.RowHeights[3] := Round(h * 6);
  R := GRID.CellRect(0, 0);
  InflateRect(R, -1, -1);
  Header.BoundsRect := R;
  Header.Font.Height := Header.ClientHeight - 1;
  for I := 0 to Header.ColCount - 1 do
    Header.ColWidths[I] := Round(Header.Font.Height * WWW[I]);

  if (VertLine <> nil) and (VertLine.Visible) then
  begin
    Temp := FUnitWidth;
    FUnitWidth := -1;
    UnitWidth := Temp;
  end;
end;

procedure TfrmMain2.GRIDDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  C: TCanvas;
begin
  C := GRID.Canvas;
  C.Pen.Color := clGreen;
  C.Brush.Color := GRID.Color;
  if ACol < 1 then Inc(Rect.Right);
  if ARow < 3 then Inc(Rect.Bottom);
  C.Rectangle(Rect); //���Ʋ�ͬ����ķֽ���
  case ACol of
    0: case ARow of
        0: ;
        1: DrawK(C, Rect);
        2: DrawV(C, Rect);
       //3: DrawRSI(C, Rect);
        3: DrawPL(C, Rect);
      end;
    1: case ARow of
        0: ;
        1: DrawScaleK(C, Rect);
        2: DrawScaleV(C, Rect);
//      	3: DRAW_SCALE(C, Rect, ArrayOdSingle([80, 50, 20]), 0, 100, 0, 100);
        3: DRAW_SCALE(C, Rect, ArrayOdSingle([60, -0, -60]), -110, 110, -110, 110);
      end;
  end;
  if (VertLine <> nil) and VertLine.Visible then VertLine.Paint;
end;

//�л������ļ�ʱ

procedure TfrmMain2.SetStockName(const Value: string);
begin
  if (StkDataFile = nil) or (Value <> FStockName) then
  begin
    FStockName := Value;
    CLEAR_ALL_CALCULATE_DATA(); //�������õ�����
    StkDataFile := TDataFile.Create(FStockName);
    if StkDataFile <> nil then
    begin
      if DataIndex > StkDataFile.getCount - 1 then
      begin
        FPageStart := StkDataFile.getCount - DataPerPage;
        FDataIndex := StkDataFile.getCount - 1;
      end;
      CalcAll;
      GRID.Repaint;
      //Header.Cells[0,0] := Copy(FStockName,4,Length(FStockName)-3);
      Header.Cells[0, 0] := ExtractFileName(FStockName);
      MOVE_VERTLINE(DataIndex);
      ITERATE_DATA(DataIndex);
    end;
  end;
end;

procedure TfrmMain2.SetPageStart(Value: Integer);
begin
  if StkDataFile <> nil then
  begin
    Value := Max(-Max(1, DataPerPage div 8), Min(StkDataFile.getCount - DataPerPage, Value));
    if Value <> FPageStart then
    begin
      FPageStart := Value;
      GRID.Repaint;
    end;
  end;
end;

procedure TfrmMain2.SetUnitWidth(Value: Integer);
var
  NewPageStart: Integer;
  P: PStkDataRec;
begin
  Value := Max(1, Min(40, Value));
  if Value > 1 then Value := Value div 2 * 2;
  if (Value <> FUnitWidth) and (StkDataFile <> nil) then
  begin
    FUnitWidth := Value;
    NewPageStart := DataIndex - DataPerPage div 2;
    NewPageStart := Max(0, NewPageStart);
    NewPageStart := Min(NewPageStart, StkDataFile.getCount - DataPerPage);
    FPageStart := NewPageStart;
    FDataIndex := Max(FDataIndex, FPageStart);
    MOVE_VERTLINE(FDataIndex);

    GRID.Repaint; //����
    ITERATE_DATA(FDataIndex);

  //GRID.Repaint;//����

    {
    IF FDataIndex <> -1 THEN
    BEGIN
    //����MA����
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    GRID.Canvas.TextOut(0,GRID.RowHeights[0] + 1,'MA30: ' + FormatFloat('0,000.00', MA[0][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[1];
    GRID.Canvas.TextOut(90,GRID.RowHeights[0] + 1,'MA60: ' + FormatFloat('0,000.00', MA[1][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[2];
    GRID.Canvas.TextOut(180,GRID.RowHeights[0] + 1,'MA120: ' + FormatFloat('0,000.00', MA[2][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[3];
    GRID.Canvas.TextOut(278,GRID.RowHeights[0] + 1,'MA250: ' + FormatFloat('0,000.00', MA[3][StkDataFile.getCount-FDataIndex]));


    //����VOL����
    P := StkDataFile.getData(FDataIndex);
    IF P <> NIL THEN
    BEGIN
    GRID.Canvas.Font.Color := DEF_COLOR[5];
    GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + 1,'VOL: ' + FormatFloat('000,000.00', P.VOL));
    END;
    //����PL����
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    if PL[0][StkDataFile.getCount-FDataIndex -1] > 0 then
      GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1,'PL250: ' + FormatFloat('+0,000.00', PL[0][StkDataFile.getCount-FDataIndex -1]))
    else
      GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1,'PL250: ' + FormatFloat(' -0,000.00', -PL[0][StkDataFile.getCount-FDataIndex -1]));
   END;
    }
  end;
end;

procedure TfrmMain2.CalcAll;
begin
  CalcMA;
  CalcVMA;
  CalcRSI;
  CalcPL;
end;

function TfrmMain2.GetDataPerPage: Integer;
begin
  if FUnitWidth > 0 then
    Result := _width_(GRID.CellRect(0, 1)) div FUnitWidth
  else Result := 0;
end;

procedure TfrmMain2.CalcMA;
var
  I: Integer;
begin
  for I := 0 to Length(MAC) - 1 do
    if MAC[I] = 0 then MA[I] := nil
    else MA[I] := _calcMA_(StkDataFile.getCP, MAC[I]);
end;

procedure TfrmMain2.CalcPL;
var
  I: Integer;
begin
  for I := 0 to Length(PLC) - 1 do
    if PLC[I] = 0 then PL[I] := nil
    else PL[I] := _calcPL_(StkDataFile.getCP, MA, PLC[I]);
end;

procedure TfrmMain2.CalcRSI;
var
  I: Integer;
  A: TArrayOfSingle;
begin
  A := StkDataFile.getUD;
  if A <> nil then
    for I := 0 to 1 do
      RSI[I] := _calcRSI_(A, RSIC[I]);
end;

procedure TfrmMain2.CalcVMA;
var
  I: Integer;
begin
  for I := 0 to Length(VMAC) - 1 do
    if VMAC[I] = 0 then VMA[I] := nil
    else VMA[I] := _calcMA_(StkDataFile.getVOL, VMAC[I]);
end;

procedure TfrmMain2.DrawK(C: TCanvas; R: TRect);
var
  C3: TColor;
  High, Low, D: Single;
  I, J, X1, X2, Y1, Y2, X3, Y3, M, N: Integer;
  P: PStkDataRec;
  HIndex, LIndex: TArrayOfInteger; //Range 0 to DataPerPage-1.
  HA, LA: TArrayOfSingle;
  str: string;
  Rt: TRect;
  TH, TW: Integer;
begin
  HA := nil;
  LA := nil;

  if IS_SHOW_DATESCALE then DRAW_DATE_SCALE(C, R, True);

  if FindKLineScaleHighLow(StkDataFile, High, Low, HA, LA, HIndex, LIndex) then
  begin
    ScaleHigh[1] := High;
    ScaleLow[1] := Low;
    D := (High - Low) / 20;
    High := High + D;
    Low := Low - D * 2;
    InflateRect(R, 0, -2);
    if ShowBackgroundDotLine then
      DRAW_HORZ_SCALE(C, R, ScaleLow[1], ScaleHigh[1], Low, High, _height_(R) div 25, True);

    if miShowKLineHighLow.Checked and (Length(HIndex) > 0) then
    begin
      C.Font.Name := 'ARIAL';
      C.Font.Height := Max(2, Round(_height_(R) * 0.05) - 1);
      C.Pen.Color := GRID.Color;
      for I := 0 to Length(HIndex) - 1 do
      begin
        str := _vs_(HA[HIndex[I]]);
        TW := C.TextWidth(str);
        TH := C.TextHeight(str);
        X1 := 1 + UnitWidth * HIndex[I] - TW div 2 + UnitWidth div 2 - 1;
        Y1 := Fy2Iy(HA[HIndex[I]], R, High, Low) - TH + 1;
        Rt := Rect(X1, Y1, X1 + TW, Y1 + TH);
        Rt.Left := Min(R.Right - TW - 1, Max(Rt.Left, 1));
        Rt.Right := Rt.Left + TW + 2;
        if not IS_FRACTION_UNDERLINE then
          _textRectBackground_(C, Rt, str, C.Font.Height, clRed or $008000, GRID.Color, taCenter, tlTop, True)
        else _textRect_(C, Rt, str, clRed or $008000, GRID.Color, taCenter, tlTop, False);
      end;
    end;

    if miShowKLineHighLow.Checked and (Length(LIndex) > 0) then
    begin
      C.Font.Name := 'ARIAL';
      C.Font.Height := Max(2, Round(_height_(R) * 0.05) - 1);
      C.Pen.Color := GRID.Color;
      for I := 0 to Length(LIndex) - 1 do
      begin
        str := _vs_(LA[LIndex[I]]);
        TW := C.TextWidth(str);
        TH := C.TextHeight(str);
        X1 := 1 + UnitWidth * LIndex[I] - TW div 2 + UnitWidth div 2 - 1;
        Y1 := Fy2Iy(LA[LIndex[I]], R, High, Low) + 1;
        Rt := Rect(X1, Y1, X1 + TW, Y1 + TH);
        Rt.Left := Min(R.Right - TW - 1, Max(Rt.Left, 1));
        Rt.Right := Rt.Left + TW + 2;
        if not IS_FRACTION_UNDERLINE then
          _textRectBackground_(C, Rt, str, C.Font.Height, clAqua and $C0C0C0, GRID.Color, taCenter, tlTop, True)
        else _textRect_(C, Rt, str, clAqua and $C0C0C0, GRID.Color, taCenter, tlTop, False);
      end;
    end;

    _setPen_(C, GRID.Color, 1, psSolid, pmCopy);
    _setBrush_(C, GRID.Color, bsSolid);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      P := PStkDataRec(StkDataFile.getData(J));
      if P <> nil then
      begin
        Y1 := Fy2Iy(P^.OP, R, High, Low);
        Y2 := Fy2Iy(P^.CP, R, High, Low);
        M := Min(Y1, Y2); //Measured by pixels
        N := Max(Y1, Y2); //Measured by pixels
//
        X1 := UnitWidth * I + UnitWidth div 2;
        X2 := X1;
        Y1 := Fy2Iy(P^.HP, R, High, Low);
        Y2 := Fy2Iy(P^.LP, R, High, Low);
        if UnitWidth > 2 then
        begin //K-Char����Ӱ��
          _line_(C, X1, Y1, X2, M, clWhite); //HP
          _line_(C, X1, N, X2, Y2, clWhite); //LP
        end
        else if UnitWidth < 2 then _line_(C, X1, Y1, X2, Y2) //HP to LP
        else begin
         //����ֵ
          X3 := X2;
          Y3 := Y2;
          C3 := C.Pen.Color;

          X2 := UnitWidth * (I + 1) + UnitWidth div 2;
          Y2 := Fy2Iy(P^.CP, R, High, Low);
          _line_(C, X1, Y2, X2, Y2, clWhite); //CP to CP
          _line_(C, X1, Y1, X3, Y3, C3) //HP to LP
        end;
//
        X1 := 1 + UnitWidth * I;
        X2 := UnitWidth * (I + 1);
        Y1 := Fy2Iy(P^.OP, R, High, Low);
        Y2 := Fy2Iy(P^.CP, R, High, Low);
        if Y1 > Y2 then C.Pen.Color := clRed
        else if Y1 < Y2 then C.Pen.Color := clAqua
        else C.Pen.Color := clLime;
        C.Brush.Color := C.Pen.Color;
        if UnitWidth > 2 then
        begin
          if (X1 = X2) or (Y1 = Y2) then _line_(C, X1, Y1, X2, Y2, clLime)
          else if Y1 > Y2 then
          begin
            C.Brush.Color := clBlack;
            C.Rectangle(Rect(X1, Y1, X2, Y2));
          end
          else begin
            C.Brush.Color := C.Pen.Color;
            C.Rectangle(Rect(X1, Y1, X2, Y2));
          end;
        end;
      end;
    end;

    if IS_DRAW_MA then
      for I := 0 to Length(MAC) - 1 do
        if MAC[I] > 0 then
          DrawLine(MA[I], DEF_COLOR[I], C, R, High, Low);

  end;
end;

procedure TfrmMain2.DrawScaleK(C: TCanvas; R: TRect);
var
  High, Low, D: Single;
  HIndex, LIndex: TArrayOfInteger;
  HA, LA: TArrayOfSingle;
begin
  if FindKLineScaleHighLow(StkDataFile, High, Low, HA, LA, HIndex, LIndex) then
  begin
    ScaleHigh[1] := High;
    ScaleLow[1] := Low;
    D := (High - Low) / 20;
    High := High + D;
    Low := Low - D;
    InflateRect(R, 0, -2);
    DRAW_SCALE(C, R, ScaleLow[1], ScaleHigh[1], Low, High, _height_(R) div 25, True);
  end;
end;

//���Ƴɽ���ͼ��

procedure TfrmMain2.DrawV(C: TCanvas; R: TRect);
var
  D, High, Low: Single;
  I, J, X1, X2, Y1, Y2: Integer;
  P: PStkDataRec;
begin
  if FindVLineScaleHighLow(StkDataFile, High, Low) then
  begin
    ScaleHigh[2] := High;
    ScaleLow[2] := Low;
    D := (High - Low) / 10;
    High := High + D;
    InflateRect(R, 0, -2);
    if ShowBackgroundDotLine then DRAW_HORZ_SCALE(C, R, ScaleLow[2], ScaleHigh[2], Low, High, _height_(R) div 25, True);
    _setPen_(C, GRID.Color, 1, psSolid, pmCopy);
    _setBrush_(C, GRID.Color, bsSolid);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      P := StkDataFile.getData(J);
      if P <> nil then
      begin
        if P^.CP > P^.OP then C.Pen.Color := clRed
        else if P^.CP < P^.OP then C.Pen.Color := clAqua
        else C.Pen.Color := clLime;
        C.Brush.Color := C.Pen.Color;
        X1 := 1 + UnitWidth * I;
        X2 := UnitWidth * (I + 1);
        Y1 := R.Bottom;
        Y2 := Fy2Iy(P^.VOL, R, High, Low);
        if UnitWidth > 2 then C.Rectangle(Rect(X1, Y1, X2, Y2))
        else _line_(C, X1, Y1, X1, Y2);
      end;
    end;

    if IS_DRAW_MA then
      for I := 0 to Length(VMAC) - 1 do
        if VMAC[I] > 0 then
          DrawLine(VMA[I], DEF_COLOR[I], C, R, High, Low);
  end;
end;

procedure TfrmMain2.DrawRSI(C: TCanvas; R: TRect);
var
  High, Low: Single;
  I, Y: Integer;
begin
  High := 100;
  Low := 0;
  ScaleHigh[3] := 100;
  ScaleLow[3] := 0;
  InflateRect(R, 0, -2);
  _setBrush_(C, GRID.Color, bsSolid);
  if ShowBackgroundDotLine then
  begin
    _setPen_(C, clRed, 1, psDot, pmCopy);
    Y := Fy2Iy(80, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clRed);
    Y := Fy2Iy(50, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clSilver);
    Y := Fy2Iy(20, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clAqua);
  end;
  _setPen_(C, clRed, 1, psSolid, pmCopy);

  for I := 0 to Length(RSIC) - 1 do
    if RSIC[I] > 0 then
      DrawLine(RSI[I], DEF_COLOR[I], C, R, High, Low);

end;

procedure TfrmMain2.DrawPL(C: TCanvas; R: TRect);
var
  High, Low: Single;
  I, Y: Integer;
begin
  High := 100;
  Low := -100;
  ScaleHigh[3] := 100;
  ScaleLow[3] := -100;
  InflateRect(R, 0, -2);
  _setBrush_(C, GRID.Color, bsSolid);
  if ShowBackgroundDotLine then
  begin
    _setPen_(C, clRed, 1, psDot, pmCopy);
    Y := Fy2Iy(80, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clRed);
    Y := Fy2Iy(0, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clSilver);
    Y := Fy2Iy(-80, R, High, Low); _line_(C, R.Left + 1, Y, R.Right, Y, clAqua);
  end;
  _setPen_(C, clRed, 1, psSolid, pmCopy);

  for I := 0 to Length(PLC) - 1 do
    if PLC[I] > 0 then
      DrawLine(PL[I], DEF_COLOR[I], C, R, High, Low);

  //C.TextOut(100,100,FloatToStr(PL[0][DataIndex]));
end;

function TfrmMain2.FindKLineScaleHighLow(DataFile: IDataFile;
  var High, Low: Single; var HA, LA: TArrayOfSingle; var HIndex, LIndex: TArrayOfInteger): Boolean;
  function IsHighLabel(Index: Integer): Boolean;
  var
    I, SS, EE: Integer;
    FH: Single;
    Interval: Integer;
  begin
    Result := False;
    Interval := Max(10, DataPerPage div 20);
    if Length(HA) = 0 then Exit;
    if Interval < 1 then Exit;
    if Index > -1 then
    begin
      FH := 0;
      SS := Max(0, Index - Interval);
      EE := Min(Length(HA) - 1, Index + Interval);
      for I := SS to EE do FH := Max(FH, HA[I]);
      Result := (HA[Index] = FH);
    end;
  end;

  function IsLowLabel(Index: Integer): Boolean;
  var
    I, SS, EE: Integer;
    FL: Single;
    Interval: Integer;
  begin
    Result := False;
    Interval := Max(10, DataPerPage div 20);
    if Length(LA) = 0 then Exit;
    if Interval < 1 then Exit;
    if Index > -1 then
    begin
      FL := MaxSingle;
      SS := Max(0, Index - Interval);
      EE := Min(Length(LA) - 1, Index + Interval);
      for I := SS to EE do FL := Min(FL, LA[I]);
      Result := (LA[Index] = FL);
    end;
  end;
var
  I, J: Integer;
  P: PStkDataRec;
begin
  High := -MaxSingle;
  Low := MaxSingle;
  HA := nil;
  LA := nil;
  HIndex := nil;
  LIndex := nil;
  for I := 0 to DataPerPage - 1 do
  begin
    J := PageStart + DataPerPage - I - 1;
    P := PStkDataRec(DataFile.getData(J));
    if P <> nil then
    begin
      if miShowKLineHighLow.Checked then
      begin
        SetLength(HA, Length(HA) + 1);
        SetLength(LA, Length(LA) + 1);
        HA[Length(HA) - 1] := P.HP;
        LA[Length(LA) - 1] := P.LP;
        if Length(HA) > 1 then HA[Length(HA) - 1] := HA[Length(HA) - 1] * 0.9995 + HA[Length(HA) - 2] * 0.0005;
        if Length(LA) > 1 then LA[Length(LA) - 1] := LA[Length(LA) - 1] * 0.9995 + LA[Length(LA) - 2] * 0.0005;
      end;
      High := Max(High, P.HP);
      Low := Min(Low, P.LP);
    end;
  end;

  if miShowKLineHighLow.Checked then
  begin
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      if J > -1 then
      begin
        if IsHighLabel(I) then
        begin
          SetLength(HIndex, Length(HIndex) + 1);
          HIndex[Length(HIndex) - 1] := I;
        end
        else if IsLowLabel(I) then
        begin
          SetLength(LIndex, Length(LIndex) + 1);
          LIndex[Length(LIndex) - 1] := I;
        end
      end;
    end;
  end;

  Result := High > Low;

end;

function TfrmMain2.FindVLineScaleHighLow(DataFile: IDataFile; var High, Low: Single): Boolean;
var
  I, J: Integer;
  P: PStkDataRec;
begin
  High := -MaxSingle;
  Low := MaxSingle;
  for I := 0 to DataPerPage - 1 do
  begin
    J := PageStart + DataPerPage - I - 1;
    if _valid_(J, 0, DataFile.getCount - 1) then
    begin
      P := PStkDataRec(DataFile.getData(J));
      High := Max(High, P.VOL);
      Low := Min(Low, P.VOL);
    end;
  end;
  Result := High > Low;
end;

function TfrmMain2.Fy2Iy(FY: Single; R: TRect; ScaleHigh, ScaleLow: Single): Integer;
var
  RatioY: Single;
begin
  Result := 0;
  if (ScaleHigh > ScaleLow) and (_height_(R) > 0) then
  begin
    RatioY := (ScaleHigh - ScaleLow) / _height_(R);
    if RatioY > 0 then Result := R.Top + Round((ScaleHigh - FY) / RatioY);
  end;
end;

function TfrmMain2.PageIndex2DataIndex(Index: Integer): Integer;
begin
  Result := StkDataFile.getCount - Index - 1;
end;

procedure TfrmMain2.DrawLine(A: TArrayOfSingle; Color: TColor;
  C: TCanvas; R: TRect; High, Low: Single);
var
  I, J, X, Y, Len: Integer;
  FirstDataFound: Boolean;
begin
  if A <> nil then
  begin
    FirstDataFound := False;
    _setPen_(C, Color, 1, psSolid, pmCopy);

    C.Brush.Color := GRID.Color;
    C.Brush.Style := bsSolid;
    Len := Length(A);
    for I := 0 to DataPerPage - 1 do
    begin
      J := PageStart + DataPerPage - I - 1;
      J := PageIndex2DataIndex(J);
      //if _valid_(J,0,Len-1) then
      if _valid_(J, 0, Len - 1) and (A[J] <> -9999) then //û�м����������ʱ����ʾ��-1����������
      begin
        X := UnitWidth * I + UnitWidth div 2;
        Y := Fy2Iy(A[J], R, High, Low);
        if not FirstDataFound then
        begin
          C.MoveTo(X, Y);
          FirstDataFound := True;
        end
        else C.LineTo(X, Y);
      end;
    end;
  end;
end;

//����ʱ��ֽ���

procedure TfrmMain2.DRAW_DATE_SCALE(C: TCanvas; R: TRect; ShowText: Boolean);
var
  Rt: TRect;
  str: string;
  I, J, TW, TH: Integer;
  y, m, d, y1, m1, d1, ymd: WORD;
  P, Q: PStkDataRec;
  XX, YY: Integer;
  days: array[1..7] of string;
begin
  for I := 0 to DataPerPage do
  begin
    J := PageStart + DataPerPage - I - 1;
    P := StkDataFile.getData(J);
    Q := StkDataFile.getData(J + 1);
    if (P <> nil) and (Q <> nil) then
    begin
      days[1] := '������';
      days[2] := '����һ';
      days[3] := '���ڶ�';
      days[4] := '������';
      days[5] := '������';
      days[6] := '������';
      days[7] := '������';
      DecodeDate(P^.Date, y, m, d);
      DecodeDate(Q^.Date, y1, m1, d1);
      //ymd := _if_(m<>m1,m,0);//�����·������л���
      ymd := _if_(d <> d1, d, 0); //�������������л���
      if ymd <> 0 then
      begin
        XX := UnitWidth * I + UnitWidth div 2; // In pixels
        _setBrush_(C, GRID.Color, bsSolid);
        if ShowBackgroundDotLine then
        begin
          _setPen_(C, cl3DDkShadow, 1, psDot, pmCopy);
          C.MoveTo(XX, R.Top);
          C.LineTo(XX, R.Bottom);
        end
        else _setPen_(C, GRID.Color, 1, psDot, pmCopy);

        if ShowText then
        begin
     //str := IntToStr(ymd);
          str := FormatDateTime('yyyy/MM/dd ', P.Date) + days[DayofWeek(P.Date)];
          C.Font.Name := 'ARIAL';
          C.Font.Height := Max(2, Round(_height_(R) * 0.05) - 2);
          TW := C.TextWidth(str);
          TH := C.TextHeight(str);
          YY := R.Bottom - TH;
          Rt := _Offset_(Rect(0, 0, TW + 30, TH), XX + 1, YY - 1);
          _textRect_(C, Rt, str, clYellow, GRID.Color, taLeftJustify, tlBottom, True);
        end;
      end;
    end;
  end;
  C.Pen.Style := psSolid;
end;

procedure TfrmMain2.mi100Click(Sender: TObject);
begin
  with TMenuItem(Sender) do
  begin
    Checked := not Checked;
    case Tag of
      100: IS_DRAW_MA := Checked;
      101: IS_SHOW_DATESCALE := Checked;
      102: ShowBackgroundDotLine := Checked;
      103: IS_FRACTION_UNDERLINE := Checked;
      105: IS_IMG_SAVE_TO_FILE := Checked;
    end;
    GRID.Repaint;
    ITERATE_DATA(DataIndex);
  end;
end;

procedure TfrmMain2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '+', '=': UnitWidth := UnitWidth + 2;
    '-': UnitWidth := UnitWidth - 2;
  end;
end;

//����TXT���ݵ��ڴ�

procedure TfrmMain2.mi0Click(Sender: TObject);
var
  Value: string;
begin
  if TMenuItem(Sender).Name <> 'mi0' then
    OpenDialog1.Filter := '�������ļ�(*.DAT)|*.DAT'
  else
    OpenDialog1.Filter := '�ı��ļ�(*.txt)|*.txt';

  if OpenDialog1.Execute then
  begin
  //ShowMessage(OpenDialog1.FileName);
    Value := OpenDialog1.FileName;

    if (StkDataFile = nil) or (Value <> FStockName) then
    begin
      FStockName := OpenDialog1.FileName;
      CLEAR_ALL_CALCULATE_DATA(); //�������õ�����
      StkDataFile := TDataFile.Create(Value);
      if StkDataFile <> nil then
      begin
        if DataIndex > StkDataFile.getCount - 1 then
        begin
          FPageStart := StkDataFile.getCount - DataPerPage;
          FDataIndex := StkDataFile.getCount - 1;
        end;
        CalcAll;
        GRID.Repaint;
      //Header.Cells[0,0] := Copy(FStockName,4,Length(FStockName)-3);
        Header.Cells[0, 0] := ExtractFileName(FStockName);
        MOVE_VERTLINE(DataIndex);
        ITERATE_DATA(DataIndex);
      end;
    end;
  end;
end;

procedure TfrmMain2.N5Click(Sender: TObject);
begin
  UnitWidth := UnitWidth + 2;
end;

procedure TfrmMain2.N6Click(Sender: TObject);
begin
  UnitWidth := UnitWidth - 2;
end;

procedure TfrmMain2.DrawScaleV(C: TCanvas; R: TRect);
var
  D, High, Low: Single;
begin
  if FindVLineScaleHighLow(StkDataFile, High, Low) then
  begin
    ScaleHigh[2] := High;
    ScaleLow[2] := Low;
    D := (High - Low) / 10;
    High := High + D;
    InflateRect(R, 0, -2);
    DRAW_SCALE(C, R, ScaleLow[2], ScaleHigh[2], Low, High, _height_(R) div 25, True);
  end;
end;

//���������ƶ�ʱ������Ӧ����

procedure TfrmMain2.SetDataIndex(Value: Integer);
var
  LB, RB, Diff: Integer;
  P: PStkDataRec;
begin
  if StkDataFile <> nil then
  begin
    Value := Max(-Max(1, DataPerPage div 8), Min(StkDataFile.getCount - 1, Value));
    if Value <> FDataIndex then
    begin
      LB := PageStart + DataPerPage - 1;
      RB := PageStart;
      Diff := Value - FDataIndex;
      if (Value < RB) or (Value > LB) then
        PageStart := PageStart + Diff; //DataPerPage div 4
      FDataIndex := Value;
      MOVE_VERTLINE(FDataIndex);
      //GRID.Repaint;
      ITERATE_DATA(FDataIndex);

      //GRID.Repaint;  //����ҳ����˸

    {
    IF FDataIndex <> -1 THEN
    BEGIN
    //����MA����
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    GRID.Canvas.TextOut(0,GRID.RowHeights[0] + 1,'MA30: ' + FormatFloat('0,000.00', MA[0][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[1];
    GRID.Canvas.TextOut(90,GRID.RowHeights[0] + 1,'MA60: ' + FormatFloat('0,000.00', MA[1][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[3];
    GRID.Canvas.TextOut(180,GRID.RowHeights[0] + 1,'MA120: ' + FormatFloat('0,000.00', MA[2][StkDataFile.getCount-FDataIndex]));
    GRID.Canvas.Font.Color := DEF_COLOR[4];
    GRID.Canvas.TextOut(278,GRID.RowHeights[0] + 1,'MA250: ' + FormatFloat('0,000.00', MA[3][StkDataFile.getCount-FDataIndex]));

    //����VOL����
    P := StkDataFile.getData(FDataIndex);
    IF P <> NIL THEN
    BEGIN
    GRID.Canvas.Font.Color := DEF_COLOR[5];
    GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + 1,'VOL: ' + FormatFloat('000,000.00', P.VOL));
    END;
    //����PL����
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    if PL[0][StkDataFile.getCount-FDataIndex -1] > 0 then
      GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1,'PL250: ' + FormatFloat('+0,000.00', PL[0][StkDataFile.getCount-FDataIndex -1]))
    else
      GRID.Canvas.TextOut(0,GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1,'PL250: ' + FormatFloat(' -0,000.00', -PL[0][StkDataFile.getCount-FDataIndex -1]));
   END;
    }
    end;
  end;
end;

//����ȫ�ֿ�ݼ�

procedure TfrmMain2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  begin
    case Key of
      VK_LEFT: miLeftOne.Click;
      VK_RIGHT: miRightOne.Click;
      VK_UP: N5.Click;
      VK_DOWN: N6.Click;
      VK_HOME: miPageFirst.Click;
      VK_END: miPageLast.Click;
    end;
  end
  else if Shift = [ssCtrl] then
  begin
    case Key of
      VK_LEFT: miQuickLeft.Click;
      VK_RIGHT: miQuickRight.Click;
      VK_HOME: miFirst.Click;
      VK_END: miLast.Click;
      VK_TAB: N15.Click;
      VK_INSERT: N17.Click;
    end;
  end;
end;

procedure TfrmMain2.ITERATE_DATA(Index: Integer);
var
  I: Integer;
  P, Q: PStkDataRec;
begin
  if StkDataFile <> nil then
  begin
    P := StkDataFile.getData(Index);
    Q := StkDataFile.getData(Index + 1);
    if P <> nil then
    begin
     //Header.Cells[01,0] := FormatDateTime('YYYY-MM-DD', P.Date);
      Header.Cells[01, 0] := FormatDateTime('yyyy-mm-dd  hh:nn', P.Date);
      Header.Cells[03, 0] := _vs_(P.OP);
      Header.Cells[05, 0] := _vs_(P.HP);
      Header.Cells[07, 0] := _vs_(P.LP);
      Header.Cells[09, 0] := _vs_(P.CP);
      if Q = nil then Header.Cells[11, 0] := ''
      else Header.Cells[11, 0] := _vs_(P.CP - Q.CP, 2, True, True);
      Header.Cells[13, 0] := _vs_(P.VOL, _if_(Pos('ָ��', StockName) > 0, 2, 0));
    end
    else begin
      Header.Cells[01, 0] := IntToStr(FDataIndex);
      for I := 2 to Header.ColCount - 1 do
        if I mod 2 = 1 then Header.Cells[I, 0] := '';
    end;


    //���Ƶ�ǰλ��
    GRID.Canvas.Font.Color := DEF_COLOR[0];
    if DataIndex > 0 then
      GRID.Canvas.TextOut(800, GRID.RowHeights[0] + 1, 'λ��: ' + '[' + FormatFloat('00,000', StkDataFile.getCount - DataIndex) + ']  ' + FormatFloat('0,000', (StkDataFile.getCount - PageStart) / DataPerPage) + ' / ' + FormatFloat('0,000', StkDataFile.getCount / DataPerPage))
    else
      GRID.Canvas.TextOut(800, GRID.RowHeights[0] + 1, 'λ��: ' + '[' + FormatFloat('00,000', StkDataFile.getCount) + ']  ' + FormatFloat('0,000', (StkDataFile.getCount - PageStart) / DataPerPage) + ' / ' + FormatFloat('0,000', StkDataFile.getCount / DataPerPage));

    if Index <> -1 then
    begin
    //����MA����
      GRID.Canvas.Font.Color := DEF_COLOR[0];
      if MA[0][StkDataFile.getCount - Index - 1] <> -9999 then
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + 1, 'MA30: ' + FormatFloat('0,000.00', MA[0][StkDataFile.getCount - Index - 1]))
      else
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + 1, 'MA30: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[1];
      if MA[1][StkDataFile.getCount - Index - 1] <> -9999 then
        GRID.Canvas.TextOut(130, GRID.RowHeights[0] + 1, 'MA60: ' + FormatFloat('0,000.00', MA[1][StkDataFile.getCount - Index - 1]))
      else
        GRID.Canvas.TextOut(130, GRID.RowHeights[0] + 1, 'MA60: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[2];
      if MA[2][StkDataFile.getCount - Index - 1] <> -9999 then
        GRID.Canvas.TextOut(260, GRID.RowHeights[0] + 1, 'MA120: ' + FormatFloat('0,000.00', MA[2][StkDataFile.getCount - Index - 1]))
      else
        GRID.Canvas.TextOut(260, GRID.RowHeights[0] + 1, 'MA120: ' + '                ');
      GRID.Canvas.Font.Color := DEF_COLOR[3];
      if MA[3][StkDataFile.getCount - Index - 1] <> -9999 then
        GRID.Canvas.TextOut(398, GRID.RowHeights[0] + 1, 'MA250: ' + FormatFloat('0,000.00', MA[3][StkDataFile.getCount - Index - 1]))
      else
        GRID.Canvas.TextOut(398, GRID.RowHeights[0] + 1, 'MA250: ' + '                ');


    //����VOL����
      P := StkDataFile.getData(Index);
      if P <> nil then
      begin
        GRID.Canvas.Font.Color := DEF_COLOR[5];
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + 1, 'VOL: ' + FormatFloat('000,000.00', P.VOL));
      end;

    //����PL����
      GRID.Canvas.Font.Color := DEF_COLOR[0];
      if PL[0][StkDataFile.getCount - Index - 1] <> -9999 then
      begin
        if PL[0][StkDataFile.getCount - Index - 1] > 0 then
          GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, 'PL250: ' + FormatFloat('+0,000.00', PL[0][StkDataFile.getCount - Index - 1]))
        else
          GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, 'PL250: ' + FormatFloat(' -0,000.00', -PL[0][StkDataFile.getCount - Index - 1]));
      end
      else
      begin
        GRID.Canvas.TextOut(0, GRID.RowHeights[0] + GRID.RowHeights[1] + GRID.RowHeights[2] + 1, 'PL250: ' + '                  ');
      end;
    end;


  end;
end;

procedure TfrmMain2.N3Click(Sender: TObject);
var
  I: Integer;
  mi: TMenuItem;
begin
  mi := TMenuItem(Sender);
  for I := 0 to mi.Count - 1 do
  begin
    mi.Items[I].Checked := Pos(StockName, mi.Items[I].Caption) > 0;
  end;
end;

procedure TfrmMain2.HeaderDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Q: TTextRectInfo;
begin
  Q := _rec_(Rect, Header.Cells[ACol, ARow], clWhite, clBlack, taCenter, tlCenter);
  GRID.Canvas.Font.Name := _if_(ACol mod 2 = 0, '�꿬��', 'ARIAL');
  case ACol of
    00: Q.FC := clYellow;
    01: Q.FC := clWhite;
    11: Q.FC := _if_(Pos('+', Q.S) > 0, clRed, _if_(Pos('-', Q.S) > 0, clAqua, Q.FC));
  else Q.FC := _if_(ACol mod 2 = 0, clSilver, clFuchsia);
  end;
  case ACol of
    11, 13: Q.AL := taLeftJustify;
    1: if FDataIndex > -1 then Q.AL := taRightJustify else Q.AL := taCenter;
  end;
  with Q do _textRect_(Header.Canvas, R, S, FC, BC, AL, TL, Transparent);
end;

procedure TfrmMain2.miPageLastClick(Sender: TObject);
begin
  DataIndex := Max(0, PageStart);
end;

procedure TfrmMain2.miLeftOneClick(Sender: TObject);
begin
  DataIndex := DataIndex + 1;
end;

procedure TfrmMain2.miRightOneClick(Sender: TObject);
begin
  DataIndex := DataIndex - 1;
end;

procedure TfrmMain2.miUpOneClick(Sender: TObject);
begin
  UnitWidth := UnitWidth + 2;
end;

procedure TfrmMain2.miDownOneClick(Sender: TObject);
begin
  UnitWidth := UnitWidth - 2;
end;

{ TVertLine }

constructor TVertLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVisible := True;
  FPosition := 100;
  Parent := TfrmMain2(Owner).GRID;
  Align := alClient;
  Width := 1;
end;

procedure TVertLine.Paint;
begin
  if Visible then
  begin
    _setPen_(Canvas, clFuchsia, 1, psSolid, pmXOR);
    _line_(Canvas, FPosition, 26, FPosition, Parent.ClientHeight - 1);
  end;
end;

procedure TVertLine.SetPosition(const Value: Integer);
begin
  if Value <> FPosition then
  begin
    Paint;
    FPosition := Value;
    Paint;
  end;
end;

procedure TfrmMain2.FormDestroy(Sender: TObject);
begin
  _free_(VertLine);
end;

procedure TfrmMain2.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssLeft] then DataIndex := PixelToDataIndex(X);
end;

procedure TfrmMain2.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssLeft] then DataIndex := PixelToDataIndex(X);
end;

procedure TfrmMain2.FormActivate(Sender: TObject);
begin
  if (VertLine <> nil) and VertLine.Visible then VertLine.Paint;
end;

function TfrmMain2.DataIndexToPixel(DataIndex: Integer): Integer;
begin
  Result := PageStart + DataPerPage - DataIndex - 1;
  Result := Result * UnitWidth + UnitWidth div 2;
end;

procedure TfrmMain2.MOVE_VERTLINE(DataIndex: Integer);
begin
  VertLine.Position := DataIndexToPixel(FDataIndex);
end;

procedure TfrmMain2.miPageFirstClick(Sender: TObject);
begin
  DataIndex := PageStart + DataPerPage - 1;
end;

procedure TfrmMain2.miFirstClick(Sender: TObject);
begin
  if StkDataFile <> nil then
  begin
    PageStart := StkDataFile.getCount - DataPerPage;
    DataIndex := StkDataFile.getCount - 1;
  end;
end;

procedure TfrmMain2.miLastClick(Sender: TObject);
begin
  PageStart := 0;
  DataIndex := 0;
end;

procedure TfrmMain2.miQuickLeftClick(Sender: TObject);
begin
  DataIndex := DataIndex + DataPerPage div 8;
end;

procedure TfrmMain2.miQuickRightClick(Sender: TObject);
begin
  DataIndex := DataIndex - DataPerPage div 8;
end;

procedure TfrmMain2.CLEAR_ALL_CALCULATE_DATA;
var
  I: Integer;
begin
  for I := 0 to Length(MA) - 1 do MA[I] := nil;
  for I := 0 to Length(VMA) - 1 do VMA[I] := nil;
  //for I := 0 to Length(RSI)-1 do RSI[I] := nil;
  for I := 0 to Length(PL) - 1 do PL[I] := nil;
end;

function TfrmMain2.PixelToDataIndex(X: Integer): Integer;
begin
  Result := PageStart + DataPerPage - Round((X - UnitWidth div 2) / UnitWidth) - 1;
end;

procedure TfrmMain2.N11Click(Sender: TObject);
begin
  GRID.Invalidate;
end;

procedure TfrmMain2.N15Click(Sender: TObject);
var str: string;
  lstSplit: TStringList;
  idx: Integer;
  date: TDateTime;
  //AFormat: TFormatSettings;
begin

  InputQuery('�����������������λ���ڣ�', '���ڸ�ʽ��yyyy-mm-dd hh:nn:ss', str);
  //ShowMessage(str); //��ʾ���������
  if str <> '' then
  begin

    lstSplit := TStringList.Create;
    lstSplit.Delimiter := ' ';
    lstSplit.DelimitedText := str;
    //��������м��
    if Length(lstSplit.Strings[0]) <> 10 then
    begin
      ShowMessage('���������д���!');
    end
    else
    begin
      if lstSplit.Count <> 2 then
        date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[0], 4)), StrToInt(MidStr(lstSplit.Strings[0], 6, 2)), StrToInt(RightStr(lstSplit.Strings[0], 2)), 9, 15, 0, 0)
      else
      begin
        if Length(lstSplit.Strings[1]) <> 8 then
        begin
          ShowMessage('ʱ�������д���!');
        end
        else
          date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[0], 4)), StrToInt(MidStr(lstSplit.Strings[0], 6, 2)), StrToInt(RightStr(lstSplit.Strings[0], 2)), StrToInt(LeftStr(lstSplit.Strings[1], 2)), StrToInt(MidStr(lstSplit.Strings[1], 4, 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), 0);
      end;

    //AFormat.ShortDateFormat := 'yyyy-mm-dd hh:nn:ss';
    //AFormat.DateSeparator := '-';
    //date := StrToDateTime(str, AFormat);

      idx := StkDataFile.indexOf(date);
      if idx <> -1 then
      begin
        PageStart := idx - DataPerPage + 1;
        DataIndex := idx;
      end;
    end;

  end;
end;

procedure TfrmMain2.N17Click(Sender: TObject);
begin
  if IS_IMG_SAVE_TO_FILE then
  begin
    OpenDialog1.Filter := 'ͼ���ļ�(*.JPG)|*.JPG';
    if OpenDialog1.Execute then
    //�����ȡ���ݱ��ڵ�
      GRID.Repaint;
    ITERATE_DATA(FDataIndex);
  end;
  CapAndSaveToFile(OpenDialog1.FileName + '.JPG', cmCapWindowClient, stJPEG, false, word(100), pf32bit, 0, 100, 0, 0);
end;

procedure TfrmMain2.XTDAT1Click(Sender: TObject);
var
  i: Integer;
  lstSplit: TStringList;
  rec: TStkDataRec;
  line: string;
  rText: TextFile;
  M: TMemoryStream;
begin
//����TXT�ļ�ת��ΪDAT�ļ�
  OpenDialog1.Filter := '�ı��ļ�(*.txt)|*.txt';

  if OpenDialog1.Execute then

    if FileExists(OpenDialog1.FileName) then
    begin
      M := TMemoryStream.Create;
   //M.LoadFromFile(FileName);
      AssignFile(rText, OpenDialog1.FileName);
      reset(rText);
      while not EOF(rText) do
      begin
        readln(rText, line);

        lstSplit := TStringList.Create;
        lstSplit.Delimiter := ',';
        lstSplit.DelimitedText := line;

        if length(lstSplit.Strings[2]) = 4 then
        begin
          rec.Date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[1], 4)), StrToInt(MidStr(lstSplit.Strings[1], 5, 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), StrToInt(LeftStr(lstSplit.Strings[2], 2)), StrToInt(RightStr(lstSplit.Strings[2], 2)), 0, 0);
        end
        else
        begin
          rec.Date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[1], 4)), StrToInt(MidStr(lstSplit.Strings[1], 5, 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), StrToInt(LeftStr(lstSplit.Strings[2], 1)), StrToInt(RightStr(lstSplit.Strings[2], 2)), 0, 0);
        end;

        rec.OP := StrToFloat(lstSplit.Strings[3]);
        rec.CP := StrToFloat(lstSplit.Strings[4]);
        rec.HP := StrToFloat(lstSplit.Strings[5]);
        rec.LP := StrToFloat(lstSplit.Strings[6]);
        rec.VOL := StrToInt(lstSplit.Strings[10]);


        try
          M.Write(rec, SizeOf(rec));

        finally

        end;
      end;

      SaveDialog1.Filter := '�ı��ļ�(*.DAT)|*.DAT';

      if SaveDialog1.Execute then
        M.SaveToFile(SaveDialog1.FileName);

      _free_(M);
      closefile(rText);
    end;
end;

procedure TfrmMain2.DATTXT1Click(Sender: TObject);
var
  i: Integer;
  lstSplit: TStringList;
  rec: TStkDataRec;
  line, timeStr: string;
  rText: TextFile;
  M: TMemoryStream;
begin
//����TXT�ļ�ת��ΪDAT�ļ�
  OpenDialog1.Filter := '�ı��ļ�(*.txt)|*.txt';

  if OpenDialog1.Execute then

    if FileExists(OpenDialog1.FileName) then
    begin

      SaveDialog1.Filter := '�ı��ļ�(*.DAT)|*.DAT';

      if SaveDialog1.Execute then
      begin
        M := TMemoryStream.Create;

        M.LoadFromFile(SaveDialog1.FileName);
    //�ƶ�ָ�뵽���λ��
        M.Seek(M.Size, 0);
        AssignFile(rText, OpenDialog1.FileName);
        reset(rText);
        while not EOF(rText) do
        begin
          readln(rText, line);

          lstSplit := TStringList.Create;
          lstSplit.Delimiter := '	';
          lstSplit.DelimitedText := line;

          timeStr := Trim(lstSplit.Strings[0]);
          rec.Date := EncodeDateTime(2013, StrToInt(LeftStr(timeStr, 2)), StrToInt(MidStr(timeStr, 4, 2)), StrToInt(MidStr(timeStr, 7, 2)), StrToInt(RightStr(timeStr, 2)), 0, 0);

          rec.OP := StrToFloat(lstSplit.Strings[1]);
          rec.CP := StrToFloat(lstSplit.Strings[4]);
          rec.HP := StrToFloat(lstSplit.Strings[2]);
          rec.LP := StrToFloat(lstSplit.Strings[3]);
          rec.VOL := StrToInt(lstSplit.Strings[5]);


          try
            M.Write(rec, SizeOf(rec));

          finally

          end;
        end;

      end;
      //SaveDialog1.Filter := '�ı��ļ�(*.DAT)|*.DAT';

      //if SaveDialog1.Execute then
        M.SaveToFile(SaveDialog1.FileName);

      _free_(M);
      closefile(rText);
    end;
end;

end.
