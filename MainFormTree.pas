unit MainFormTree;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.DBCtrls;

type
    pNode = ^TNode;
    TNode = record
      pLeftChild : pNode;
      pRightChild : pNode;
      pRTag : pNode;
      Key : integer;
    end;
    TArr = array of integer;

  TMainForm = class(TForm)
    BnAddNum: TButton;
    BnCreate: TButton;
    BnDeteleNum: TButton;
    OpenD: TOpenDialog;
    MemoTemp: TMemo;
    Image: TImage;
    BnLeftRootRight: TButton;
    MyPicture: TImage;
    BnTask: TButton;
    BnLeftRightRoot: TButton;
    BnRootLeftRight: TButton;
    BnRightSew: TButton;
    procedure BnCreateClick(Sender: TObject);
    procedure BnAddNumClick(Sender: TObject);
    procedure BnDeteleNumClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BnLeftRootRightClick(Sender: TObject);
    procedure BnTaskClick(Sender: TObject);
    procedure BnRootLeftRightClick(Sender: TObject);
    procedure BnLeftRightRootClick(Sender: TObject);
    procedure BnRightSewClick(Sender: TObject);
  end;
    procedure GetValue(var str1: string);
    procedure FindElementTask(var pFirst : pNode; Key : integer; var num : integer; var ArrTaskOne : TArr);

    procedure AddElement(var pFirst: pNode; Key : integer); external 'dll.dll';
    procedure FindElement(var pFirst : pNode; Key : integer; var pResult : pNode; var pParent: pNode); external 'dll.dll';
    function MakeATree(Key : integer): pointer; external 'dll.dll';

    procedure LeftRootRight(pFirst : pNode; var Mystr: shortstring); external 'dll.dll';
    procedure RootLeftRight(pFirst : pNode; var Mystr: shortstring); external 'dll.dll';
    procedure LeftRightRoot(pFirst : pNode; var Mystr: shortstring); external 'dll.dll';

    procedure RightSew(pFirst : pNode; var pPrevious : pNode; var Mystr: shortstring);  //external 'dll.dll';

    procedure DeleteElement(pFirst : pNode; Key : integer); external 'dll.dll';
    procedure WriteTreeMain(pFirst : pNode; x, y, hide: integer);
    procedure WriteTree(pFirst : pNode; x, y, hide: integer);
    procedure DrawRoot(x,y, Key : integer);

var
  MainForm: TMainForm;

implementation

const
    CWidth = 60;
    SizeOfCanvas = 100;
    CX = -30;
    CY = 220{20};

{$R *.dfm}
var
    pRoot: pNode;
    ArrTaskOne,ArrTaskTwo : TArr;


procedure TMainForm.BnAddNumClick(Sender: TObject);
var
    i, intValueArr, intValueStr: integer;
    valueArr, valueStr, valueNum, str1: shortString;
begin
    repeat
        valueNum := InputBox('AddElement', 'Add element', '21');
    until (valueNum <> '') and (StrToInt(valueNum) < 100) and (StrToInt(valueNum) > 0);
    intValueStr := StrToInt(valueNum);
    AddElement(pRoot, intValueStr);

    WriteTree(pRoot,CX, CY, SizeOfCanvas);
end;

procedure TMainForm.BnCreateClick(Sender: TObject);
var
    tempInt, i : integer;
    tempStr : string;
    a : pointer;
begin
    if openD.Execute then
    begin
        MemoTemp.Lines.LoadFromFile(OpenD.FileName);
        BnDeteleNum.Enabled := true;
        BnAddNum.Enabled := true;
        BnLeftRootRight.Enabled := true;
        BnTask.Enabled := true;
        BnCreate.Enabled := false;
        MyPicture.Hide;

        tempStr := MemoTemp.Lines[0];
        MemoTemp.Lines.Delete(0);
        TempInt := StrToInt(TempStr);

        a := MakeATree(TempInt);
        pRoot := a;

        tempStr := MemoTemp.Lines[0];
        MemoTemp.Lines.Delete(0);
        TempInt := StrToInt(TempStr);
        for i := 0 to TempInt - 1 do

        begin
            GetValue(TempStr);
            TempInt := StrToInt(TempStr);
            AddElement(pRoot, TempInt);
        end;

        WriteTree(pRoot,CX,CY, SizeOfCanvas);
    end;
end;

procedure TMainForm.BnDeteleNumClick(Sender: TObject);
var
    i, intValueArr, intValueStr: integer;
    valueArr, valueStr: string;
begin
    repeat
        valueStr:= InputBox('DeleteElement', 'Element for deleting', '3');
    until (valueStr <> '') and (StrToInt(valueStr) < 100) and (StrToInt(valueStr) > 0);
    intValueStr := StrToInt(valueStr);
    DeleteElement(pRoot, intValueStr);

    WriteTree(pRoot,CX,CY, SizeOfCanvas);
end;

procedure TMainForm.BnLeftRightRootClick(Sender: TObject);
var
    MyStr : ShortString;
begin
    MyStr := '';
    LeftRightRoot(pRoot, MyStr);
    showMessage(MyStr);
end;

procedure TMainForm.BnLeftRootRightClick(Sender: TObject);
var
    MyStr : ShortString;
begin
    MyStr := '';
    LeftRootRight(pRoot, MyStr);
    showMessage(MyStr);
end;

procedure TMainForm.BnRootLeftRightClick(Sender: TObject);
var
    MyStr : ShortString;
begin
    MyStr := '';
    RootLeftRight(pRoot, MyStr);
    showMessage(MyStr);
end;

procedure TMainForm.BnTaskClick(Sender: TObject);
var
    i, j, k, len : integer;
    ResultArr : TArr;
    tempStr : string[3];
    intValueStr1, intValueStr2: integer;
    valueStr1, valueStr2: string;
    num1, num2 :integer;
begin
(*    ArrTaskOne := nil;
    ArrTaskTwo := nil;
    num1 := 0;
    num2 := 0;
    repeat
        valueStr1:= InputBox('Node', '������� 1 ����', '3');
    until (valueStr1 <> '') and (StrToInt(valueStr1) < 100) and (StrToInt(valueStr1) > 0);
    intValueStr1 := StrToInt(valueStr1);

    repeat
        valueStr2:= InputBox('Node', '������� 2 ����', '3');
    until (valueStr2 <> '') and (StrToInt(valueStr2) < 100) and (StrToInt(valueStr2) > 0);
    intValueStr2 := StrToInt(valueStr2);

    i := 0;
    FindElementTask(pRoot, intValueStr1, num1, ArrTaskOne);
    FindElementTask(pRoot, intValueStr2, num2, ArrTaskTwo);

    while ArrTaskOne[i] = ArrTaskTwo[i] do
        inc(i);
    len := num1 + num2 - 2 * i + 1;
    setLength(ResultArr, len);
    k := 0;
    for j := num1 - 1 downto i- 1 do
    begin
          ResultArr[k] := ArrTaskOne[j];
          inc(k);
    end;
    for j := i  to num2 - 1 do
    begin
          ResultArr[k] := ArrTaskTwo[j];
          inc(k);
    end;
    len := len div 2;

    tempStr :=  intToStr(ResultArr[len]);
    ShowMessage('We will delete ' + tempStr + ' element');

    DeleteElement(pRoot, ResultArr[len]);
    WriteTree(pRoot,CX,CY, SizeOfCanvas);
    *)
end;

//����� ��������
procedure FindElementTask(var pFirst : pNode; Key : integer; var num : integer; var ArrTaskOne : TArr);
begin
    if pFirst <> nil then
    begin
        if pFirst.Key > Key then
        begin
            setlength(ArrTaskOne, num + 1);
            ArrTaskOne[num] :=  pFirst.Key;
            inc(num);
            FindElementTask(pFirst.pLeftChild, Key, num, ArrTaskOne);
        end
        else
            if pFirst.Key < Key then
            begin
                setlength(ArrTaskOne, num + 1);
                ArrTaskOne[num] :=  pFirst.Key;
                inc(num);
                FindElementTask(pFirst.pRightChild, Key, num, ArrTaskOne);
            end
            {else
                pResult :=  pFirst;}
    end
    else
        ShowMessage('Root was not found');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    MemoTemp.Hide;
    BnTask.Hide;
    BnDeteleNum.Enabled := false;
    BnAddNum.Enabled := false;
    BnLeftRootRight.Enabled := false;
    BnTask.Enabled := false;

end;

procedure TMainForm.BnRightSewClick(Sender: TObject);
var
    MyStr : ShortString;
    tempRoot : pNode;
begin
    MyStr := '';
    tempRoot := pRoot;
    RightSew(pRoot, tempRoot, MyStr);
    showMessage(MyStr)
end;

procedure RightSew(pFirst : pNode; var pPrevious : pNode; var Mystr: shortstring);
begin
    if pFirst <> nil then
    begin
        RightSew(pFirst.pLeftChild, pPrevious, Mystr);
        if (pPrevious.pRightChild = nil) then
        begin
            pPrevious.pRTag := pFirst;
            Mystr := Mystr + '(' + intTostr(pPrevious.Key) + '->'+ intTostr(pFirst.Key) + ')';
        end;
        pPrevious := pFirst;
        RightSew(pFirst.pRightChild, pPrevious, Mystr);
    end;
end;

procedure WriteTree(pFirst : pNode; x, y, hide: integer);
begin

    MainForm.Image.Canvas.Pen.Color := clWhite;
    MainForm.Image.Canvas.Brush.Color := clWhite;
    MainForm.Image.Canvas.Rectangle(0,0,500,500);

    WriteTreeMain(pRoot,CY, CX, SizeOfCanvas);
end;

procedure WriteTreeMain(pFirst : pNode; x, y, hide: integer);
begin
    if pFirst <> nil then
    begin
        WriteTreeMain(pFirst.pLeftChild, x - hide, y+ cWidth, hide div 2);


        MainForm.Image.Canvas.LineTo(x , y+ CWidth);
        DrawRoot(x , y+ CWidth, pFirst.Key);
        WriteTreeMain(pFirst.pRightChild, x + hide, y + cWidth, hide div 2);

        MainForm.Image.Canvas.Pen.Color := clBlack;
        MainForm.Image.Canvas.LineTo(x, y + CWidth);
    end
    else
        MainForm.Image.Canvas.Pen.Color := clWhite;
end;

procedure DrawRoot(x,y, Key : integer);
begin
    MainForm.Image.Canvas.Pen.Color := clBlack;
    MainForm.Image.Canvas.Ellipse(x - 12, y - 12, x + 12, y + 12);
    MainForm.Image.Canvas.Font.Size := 7;
    MainForm.Image.Canvas.TextOut(x - 5 , y - 7, intToStr(Key));
    MainForm.Image.Canvas.Pen.Color := clBlack;
    MainForm.Image.Canvas.MoveTo(x,y);
end;


procedure GetValue(var str1: string);
begin
    str1 := MainForm.MemoTemp.Lines[0];
    MainForm.MemoTemp.Lines.Delete(0);
end;



end.
