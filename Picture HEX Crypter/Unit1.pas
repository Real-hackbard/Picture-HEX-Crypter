unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Vcl.ComCtrls, IniFiles, PngImage, Jpeg,
  GIFImg, ShellApi, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OpenDialog2: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    Memo1: TMemo;
    HeaderControl1: THeaderControl;
    Panel4: TPanel;
    ScrollBox1: TScrollBox;
    Image2: TImage;
    HeaderControl2: THeaderControl;
    Button5: TButton;
    Splitter1: TSplitter;
    SaveDialog2: TSaveDialog;
    CheckBox1: TCheckBox;
    Button6: TButton;
    CheckBox2: TCheckBox;
    Button7: TButton;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    CheckBox3: TCheckBox;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    ImgHeight : integer;
    ImgWidth : integer;
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1: TForm1;
  TIF : TIniFile;
  JPEGImage: TJPEGImage;
  crypt : string;

implementation

uses Unit2;

{$R *.dfm}
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT : string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
    WriteBool(OPT,'EditHEX',CheckBox1.Checked);
    WriteBool(OPT,'Automatic',CheckBox2.Checked);
    WriteInteger(OPT,'Size',SpinEdit1.Value);

   //WriteBool(OPT,'SaveOptions',CheckBox1.Checked);
   //WriteInteger(OPT,'Compress',Combobox1.ItemIndex);
   //WriteInteger(OPT,'Overlay',RadioGroup1.ItemIndex);
   Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT : string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
  TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
  with TIF do
  begin
   CheckBox1.Checked:=ReadBool(OPT,'EditHEX',CheckBox1.Checked);
   CheckBox2.Checked:=ReadBool(OPT,'Automatic',CheckBox2.Checked);
   SpinEdit1.Value:=ReadInteger(OPT,'Size',SpinEdit1.Value);

  //CheckBox1.Checked:=ReadBool(OPT,'SaveOptions',CheckBox1.Checked);
  //Combobox1.ItemIndex:=ReadInteger(OPT,'Compress',combobox1.ItemIndex);
  //RadioGroup1.ItemIndex:=ReadInteger(OPT,'Overlay',RadioGroup1.ItemIndex);
  Free;
  end;
  end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  Memo1.Font.Size := SpinEdit1.Value;
end;

function DeleteFile(const AFile: string): boolean;
var
 sh: SHFileOpStruct;
begin
 ZeroMemory(@sh, sizeof(sh));
 with sh do
   begin
   Wnd := Application.Handle;
   wFunc := fo_Delete;
   pFrom := PChar(AFile +#0);
   fFlags := fof_Silent or fof_NoConfirmation;
   end;
 result := SHFileOperation(sh) = 0;
end;

procedure BitmapFileToPNG(const Source, Dest: String);
var
  Bitmap: TBitmap;
  PNG: TPNGObject;
begin
  { Here, the bitmap image is converted into a PNG image.}
  Bitmap := TBitmap.Create;
  PNG := TPNGObject.Create;
  {In case something goes wrong, free booth Bitmap and PNG}
  try
    Bitmap.LoadFromFile(Source);
    PNG.Assign(Bitmap);    //Convert data into png
    PNG.SaveToFile(Dest);
  finally
    Bitmap.Free;
    PNG.Free;
  end
end;

procedure LoadPngToBmp(var Dest: TBitmap; AFilename: TFilename);
type
  TRGB32 = packed record
    B, G, R, A : Byte;
  end;
  PRGBArray32 = ^TRGBArray32;
  TRGBArray32 = array[0..0] of TRGB32;
type
  TRG24 = packed record
    rgbtBlue, rgbtGreen, rgbtRed : Byte;
  end;
  PRGBArray24 = ^TPRGBArray24;
  TPRGBArray24 = array[0..0] of TRG24;
type
  TByteArray = Array[Word] of Byte;
  PByteArray = ^TByteArray;
  TPByteArray = array[0..0] of TByteArray;
var
  BMP : TBitmap;
  PNG: TPNGObject;
  x, y: Integer;
  BmpRow: PRGBArray32;
  PngRow : PRGBArray24;
  AlphaRow: PByteArray;
begin
{$I-}
{$R-}
  (* This function converts the pixels of a PNG image file into the
  color levels of a bitmap. *)
  Bmp := TBitmap.Create;
  PNG := TPNGObject.Create;
  try
    if AFilename <> '' then
    begin
      PNG.LoadFromFile(AFilename);
      BMP.PixelFormat := pf32bit;
      BMP.Height := PNG.Height;
      BMP.Width := PNG.Width;

      if ( PNG.TransparencyMode = ptmPartial ) then
      begin
        for Y := 0 to BMP.Height-1 do
        begin
          BmpRow := PRGBArray32(BMP.ScanLine[Y]);
          PngRow := PRGBArray24(PNG.ScanLine[Y]);
          AlphaRow := PByteArray(PNG.AlphaScanline[Y]);

          for X := 0 to BMP.Width - 1 do
          begin
            with BmpRow[X] do
            begin
              with PngRow[X] do
              begin
                R := rgbtRed; G := rgbtGreen; B := rgbtBlue;
              end;
              A := Byte(AlphaRow[X]);
            end;
          end;
        end;
      end else
      begin
        for Y := 0 to BMP.Height-1 do
        begin
          BmpRow := PRGBArray32(BMP.ScanLine[Y]);
          PngRow := PRGBArray24(PNG.ScanLine[Y]);
          for X := 0 to BMP.Width - 1 do
          begin
            with BmpRow[X] do
            begin
              with PngRow[X] do
              begin
                R := rgbtRed; G := rgbtGreen; B := rgbtBlue;
              end;
              A := 255;
            end;
          end;
        end;
      end;
      Dest.Assign(BMP);
    end;
  finally
    Bmp.Free;
    PNG.Free;
  end;
{$I+}
{$R+}
end;

procedure Hex2Png(str: string; out png: TPngObject);
var
  stream: TMemoryStream;
begin
  if not Assigned(png) then
  try
    // Conversion of HEX code to PNG image files.
    png := TPngObject.Create;
    stream := TMemoryStream.Create;
    stream.SetSize(Length(str) div 2);
    HexToBin(PChar(str), stream.Memory, stream.Size);
    png.LoadFromStream(stream);
  finally
    stream.Free;
  end;
end;

function Png2Hex(png: TPngObject): string;
var
  stream: TMemoryStream;
begin
  try
    // Conversion of PNG files to HEX code.
    stream := TMemoryStream.Create;
    png.SaveToStream(stream);
    SetLength(Result, stream.Size * 2);
    BinToHex(stream.Memory, PChar(Result), stream.Size);
  finally
    stream.Free;
  end;
end;

function bmp2Hex(out bmp: TBitmap):string;
var
  stream: TMemoryStream;
begin
  try
    // Conversion of Bitmap files to HEX code.
    stream := TMemoryStream.Create;
    bmp.SaveToStream(stream);
    SetLength(Result, stream.Size * 2);
    BinToHex(stream.Memory, PChar(Result), stream.Size);
  finally
    stream.Free;
  end;
end;

procedure Hex2bmp(str: string; out bmp: TBitmap);
var
  stream: TMemoryStream;
begin
  try
    // Conversion of HEX code to Bitmap image files.
    if not Assigned(bmp) then
     bmp := TBitmap.Create;
     stream := TMemoryStream.Create;
     stream.SetSize(Length(str) div 2);
     HexToBin(PChar(str), stream.Memory, stream.Size);
     bmp.LoadFromStream(stream);
  finally
   stream.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Resolution : TextFile;
begin
  StatusBar1.SetFocus;
  if Memo1.Lines.Text = '' then begin
    Beep;
    ShowMessage('No Data to Save');
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  // Export HEX Data to Ini File
  if SaveDialog1.Execute then begin
    Memo1.Lines.SaveToFile(SaveDialog1.FileName + '.ini');
    try
      AssignFile(Resolution,SaveDialog1.FileName + '.stub') ;
      Rewrite(Resolution);
      WriteLn(Resolution, '[Height]');WriteLn(Resolution, IntToStr(Image2.Height));
      WriteLn(Resolution, '[Width]');WriteLn(Resolution, IntToStr(Image2.Width));
      if CheckBox3.Checked = true then begin
        WriteLn(Resolution, '[Xor]');WriteLn(Resolution, 'on');
      end else begin
        WriteLn(Resolution, '[Xor]');WriteLn(Resolution, 'off');
      end;

      Beep;
      ShowMessage('CAUTION!' +#13+#13+ 'Do not change ASCii and Unicode in File or' +#13 +
                  'Picutre Data is damage.' + #13 +
                  'Dont lose the (*.stub) File to draw the Picture');
    finally
      CloseFile(Resolution);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  f : TextFile;
  s : string;
begin
  {$WARNINGS OFF}
  StatusBar1.SetFocus;
  if OpenDialog2.Execute then
  begin
    Memo1.Lines.LoadFromFile(OpenDialog2.FileName);
    Image2.Picture.Graphic := nil;
    try
      (* Here, the image's size ratios are stored in a *.stub file, which
        are important for the image's construction when the HEX code is
        converted back into an image.*)
      AssignFile(F, ChangeFileExt(OpenDialog2.FileName, '.stub'));
      Reset(F);
      Readln(F, S);
      Readln(F, S); ImgHeight := StrToInt(s);
      Readln(F, S);
      Readln(F, S); ImgWidth := StrToInt(s);
      Readln(F, S);
      Readln(F, S); crypt := s;
      CloseFile(f);
    except
      Beep;
      Form2.ShowModal;
    end;
    if CheckBox2.Checked = true then Button6Click(self);
  end;
  {$WARNINGS ON}
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  bmp: TBitmap;
  Picture: TPicture;
  FileHeader: TBitmapFileHeader;
  InfoHeader: TBitmapInfoHeader;
  Stream    : TFileStream;
  s: string;
  i: Integer;
begin
  StatusBar1.SetFocus;
  if OpenDialog1.Execute then
  begin

   if OpenDialog1.FilterIndex = 1 then    // Bmp import
   begin
     try
      Screen.Cursor := crHourGlass;
      bmp := TBitmap.Create;
      bmp.LoadFromFile(OpenDialog1.FileName);
      Image2.Picture.Bitmap.Assign(bmp);

      Stream := TFileStream.Create(OpenDialog1.FileName,
                                   fmOpenRead or fmShareDenyNone);
      Stream.Read(FileHeader, SizeOf(FileHeader));
      Stream.Read(InfoHeader, SizeOf(InfoHeader));
      StatusBar1.Panels[1].Text := ExtractFileName(OpenDialog1.FileName);
      StatusBar1.Panels[3].Text := Format('%d Bytes', [FileHeader.bfSize]);
      StatusBar1.Panels[5].Text := Format('X%d-', [InfoHeader.biWidth]) +
                                   Format('Y%d', [InfoHeader.biHeight]);
      StatusBar1.Panels[7].Text := Format('%d', [InfoHeader.biBitCount]);
      StatusBar1.Panels[9].Text := Format('%d', [InfoHeader.biClrUsed]);
      Memo1.Text := bmp2Hex(bmp);
      HeaderControl2.Sections[1].Text := OpenDialog1.FileName;
     finally
      bmp.Free;
      Stream.Free;
     end;
   end;
  end;

  if OpenDialog1.FilterIndex = 2 then    // Png  import
  begin
     try
      Screen.Cursor := crHourGlass;
      bmp := TBitmap.Create;
      LoadPngToBmp(bmp, OpenDialog1.FileName);
      bmp.SaveToFile(MainDir + 'Data\Backup\_pic');
      Image2.Picture.Bitmap.Assign(bmp);

      Stream := TFileStream.Create(MainDir + 'Data\Backup\_pic',
                                   fmOpenRead or fmShareDenyNone);
      Stream.Read(FileHeader, SizeOf(FileHeader));
      Stream.Read(InfoHeader, SizeOf(InfoHeader));

      StatusBar1.Panels[1].Text := ExtractFileName(OpenDialog1.FileName);
      StatusBar1.Panels[3].Text := Format('%d Bytes', [FileHeader.bfSize]);
      StatusBar1.Panels[5].Text := Format('X%d-', [InfoHeader.biWidth]) +
                                   Format('Y%d', [InfoHeader.biHeight]);
      StatusBar1.Panels[7].Text := Format('%d', [InfoHeader.biBitCount]);
      StatusBar1.Panels[9].Text := Format('%d', [InfoHeader.biClrUsed]);
      Memo1.Text := bmp2Hex(bmp);
      HeaderControl2.Sections[1].Text := OpenDialog1.FileName;
     finally
      bmp.Free;
      Stream.Free;
     end;
  end;

  if OpenDialog1.FilterIndex = 3 then    // Jpg/Jpeg import
  begin
     try
      Screen.Cursor := crHourGlass;
      bmp := TBitmap.Create;
      JPEGImage := TJPEGImage.Create;
      JPEGImage.LoadFromFile(OpenDialog1.FileName);
      Image2.Picture.Bitmap.Height := JPEGImage.Height;
      Image2.Picture.Bitmap.Width := JPEGImage.Width;
      Image2.Canvas.Draw(0,0,JPEGImage);
      bmp.Assign(Image2.Picture.Bitmap);
      bmp.SaveToFile(MainDir + 'Data\Backup\_pic');

      Stream := TFileStream.Create(MainDir + 'Data\Backup\_pic',
                                   fmOpenRead or fmShareDenyNone);
      Stream.Read(FileHeader, SizeOf(FileHeader));
      Stream.Read(InfoHeader, SizeOf(InfoHeader));
      StatusBar1.Panels[1].Text := ExtractFileName(OpenDialog1.FileName);
      StatusBar1.Panels[3].Text := Format('%d Bytes', [FileHeader.bfSize]);
      StatusBar1.Panels[5].Text := Format('X%d-', [InfoHeader.biWidth]) +
                                   Format('Y%d', [InfoHeader.biHeight]);
      StatusBar1.Panels[7].Text := Format('%d', [InfoHeader.biBitCount]);
      StatusBar1.Panels[9].Text := Format('%d', [InfoHeader.biClrUsed]);
      Memo1.Text := bmp2Hex(bmp);
      HeaderControl2.Sections[1].Text := OpenDialog1.FileName;
     finally
      bmp.Free;
      Stream.Free;
      JPEGImage.Free;
     end;
  end;

  if OpenDialog1.FilterIndex = 4 then    // Gif  import
   begin
     try
      Screen.Cursor := crHourGlass;
      bmp := TBitmap.Create;
      Picture := TPicture.Create;
      Picture.LoadFromFile(OpenDialog1.FileName);
      bmp.Width := Picture.Width;
      bmp.Height := Picture.Height;
      bmp.Canvas.Draw(0, 0, Picture.Graphic);
      bmp.SaveToFile(MainDir + 'Data\Backup\_pic');
      Image2.Picture.Bitmap.Assign(bmp);

      Stream := TFileStream.Create(MainDir + 'Data\Backup\_pic',
                                   fmOpenRead or fmShareDenyNone);
      Stream.Read(FileHeader, SizeOf(FileHeader));
      Stream.Read(InfoHeader, SizeOf(InfoHeader));
      StatusBar1.Panels[1].Text := ExtractFileName(OpenDialog1.FileName);
      StatusBar1.Panels[3].Text := Format('%d Bytes', [FileHeader.bfSize]);
      StatusBar1.Panels[5].Text := Format('X%d-', [InfoHeader.biWidth]) +
                                   Format('Y%d', [InfoHeader.biHeight]);
      StatusBar1.Panels[7].Text := Format('%d', [InfoHeader.biBitCount]);
      StatusBar1.Panels[9].Text := Format('%d', [InfoHeader.biClrUsed]);
      Memo1.Text := bmp2Hex(bmp);
      HeaderControl2.Sections[1].Text := OpenDialog1.FileName;
     finally
      bmp.Free;
      Stream.Free;
      Picture.Free;
     end;
   end;

   if CheckBox3.Checked = true then begin
    s:= Memo1.Lines.Text;
    for i:=1 to length(s) do
      s[i]:=char(23 Xor ord(s[i]));
    Memo1.Lines.Text := s;
  end;

  Screen.Cursor := crDefault;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  bmp: TBitmap;
  s: string;
  i: Integer;
begin
  StatusBar1.SetFocus;
  Screen.Cursor := crHourGlass;
  if Image2.Picture.Graphic = nil then
  begin
    Beep;
    ShowMessage('Load Picture to Calculate HEX');
    Exit;
  end;
{$I-}
{$R-}
  bmp := nil;
  (* Conversion of the image into a HEX code, with overflow
    calculation disabled to avoid compiler errors, so that
    even very large images can be converted.*)
  try
    bmp := TBitmap.Create;
    bmp.Height := Image2.Picture.Bitmap.Height;
    bmp.Width := Image2.Picture.Bitmap.Width;
    bmp.Assign(Image2.Picture.Bitmap);
    Memo1.Text := bmp2Hex(bmp);
  finally
    bmp.Free;
  end;
{$I+}
{$R+}
  if CheckBox3.Checked = true then begin
    s:= Memo1.Lines.Text;
    for i:=1 to length(s) do
      s[i]:=char(23 Xor ord(s[i]));
    Memo1.Lines.Text := s;
  end;

  Screen.Cursor := crDefault;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  bmp : TBitmap;
  JPG : TJPEGImage;
  GIF : TGIFImage;
begin
  StatusBar1.SetFocus;
  if Image2.Picture.Graphic = nil then
  begin
    Beep;
    ShowMessage('No Picture Data to Save');
    Exit;
  end;

  if SaveDialog2.Execute then
  BEGIN
    if SaveDialog2.FilterIndex = 1 then   // Bitmap export
    begin
      Image2.Picture.Bitmap.SaveToFile(SaveDialog2.FileName + '.bmp');
    end;

    if SaveDialog2.FilterIndex = 2 then    // Jpg export
    begin
      bmp := TBitmap.Create;
      JPG := TJPEGImage.Create;
      try
        bmp.Assign(Image2.Picture.Bitmap);
        JPG.Assign(bmp);
        JPG.SaveToFile(SaveDialog2.FileName + '.jpg');
      finally
        bmp.Free;
        JPG.Free;
      end;
    end;

    if SaveDialog2.FilterIndex = 3 then    // Bitmap to Png export
    begin
      try
        Image2.Picture.Bitmap.SaveToFile(SaveDialog2.FileName + '.bmp');
        BitmapFileToPNG(SaveDialog2.FileName + '.bmp', SaveDialog2.FileName + '.png');
        DeleteFile(SaveDialog2.FileName + '.bmp');
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    end;

    if SaveDialog2.FilterIndex = 4 then     // Gif export
    begin
      GIF := TGIFImage.Create;
        try
          // Copy Bitmap Pixel to GIF Data
          GIF.Assign(Image2.Picture.Bitmap);
          // Create GIF File Image
          GIF.SaveToFile(SaveDialog2.FileName + '.gif')
        finally
          GIF.Free;
        end;
    end;
  END;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  bmp: TBitmap;
  FileHeader: TBitmapFileHeader;
  InfoHeader: TBitmapInfoHeader;
  Stream    : TFileStream;
  s : string;
  i : integer;
begin
  StatusBar1.SetFocus;

  if Memo1.Lines.Text = '' then begin
    Beep;
    ShowMessage('Load HEX to Calculate Picture');
    Exit;
  end;
{$I-}
{$R-}
  Screen.Cursor := crHourGlass;
  try
    (* Here, the HEX code is converted into an image, taking into
      account the image's dimensions, which are contained in the
      *.stub file. If these dimensions are not present, they must
      be determined manually to draw the image.*)
    bmp := TBitmap.Create;
    bmp.Height := ImgHeight;
    bmp.Width := ImgWidth;
    Memo1.Text := StringReplace(Memo1.Text,#13,'',[]);
    Memo1.Text := StringReplace(Memo1.Text,#10,'',[]);

    if crypt = 'on' then
    begin
      Beep;
      ShowMessage('The data in the ini file is encrypted, i turning on decryption to draw picture');
      CheckBox3.Checked := true;
    end;

    if CheckBox3.Checked = true then begin
      s:= Memo1.Lines.Text;
      for i:=1 to length(s) do
        s[i]:=char(23 Xor ord(s[i]));
      Memo1.Lines.Text := s;
    end;

    Screen.Cursor := crHourGlass;
    Hex2bmp(Memo1.Lines.GetText,bmp);
    Application.ProcessMessages;
    Sleep(300);

    Image2.Picture.Bitmap.Height := ImgHeight;
    Image2.Picture.Bitmap.Width := ImgWidth;
    Image2.Picture.Bitmap.Assign(bmp);
    Image2.Picture.Bitmap.SaveToFile(MainDir + 'Data\Backup\_hex');

   try
    Stream := TFileStream.Create(MainDir + 'Data\Backup\_hex', fmOpenRead or fmShareDenyNone);
    Stream.Read(FileHeader, SizeOf(FileHeader));
    Stream.Read(InfoHeader, SizeOf(InfoHeader));
    StatusBar1.Panels[1].Text := 'Stream';
    StatusBar1.Panels[3].Text := Format('%d Bytes', [FileHeader.bfSize]);
    StatusBar1.Panels[5].Text := Format('X%d-', [InfoHeader.biWidth]) +
                                 Format('Y%d', [InfoHeader.biHeight]);
    StatusBar1.Panels[7].Text := Format('%d', [InfoHeader.biBitCount]);
    StatusBar1.Panels[9].Text := Format('%d', [InfoHeader.biClrUsed]);
   except
    ShowMessage('Cant read Image Header Information!');
   end;

  finally
    bmp.Free;
    Stream.Free;
    Screen.Cursor := crDefault;
  end;
  {$I+}
  {$R+}

  Screen.Cursor := crDefault;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
  Image2.Picture.Graphic := nil;
  Memo1.Clear;
  StatusBar1.Panels[1].Text := '';
  StatusBar1.Panels[3].Text := '0 bytes';
  StatusBar1.Panels[5].Text := 'X0-Y0';
  StatusBar1.Panels[7].Text := '0';
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Memo1.ReadOnly := not CheckBox1.Checked
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  (*If DoubleBuffered is set to false, the window-oriented control is
    drawn directly into the window. If DoubleBuffered is true,
    the window-oriented control is drawn to a memory bitmap, which is
    then used to draw the window. Double buffering reduces flickering when
    redrawing the control. However, it requires more memory.*)
  Form1.DoubleBuffered := true;
  // 2 GB Support for big Pictures
  Memo1.MaxLength := $7FFFFFF0;

  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  CheckBox3.Hint := 'The HEX code is additionally encrypted using the XOR cipher algorithm.';
  CheckBox1.Hint := 'Allow text changes, but every change will alter or destroy the image.';
  CheckBox2.Hint := 'Automatically decrypts the HEX code.';
  Button2.Hint := 'Load HEX code.';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  HeaderControl1.Sections[1].Text := IntToStr(Memo1.Lines.Count);
end;

end.
