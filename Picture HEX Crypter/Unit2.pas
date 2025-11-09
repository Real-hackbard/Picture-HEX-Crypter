unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  try
    Form1.ImgHeight := StrToInt(Edit1.Text);
    Form1.ImgWidth := StrToInt(Edit2.Text);
    Form1.Button6Click(self);
    Close();
  except
  end;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (Key in [#08, '0'..'9']) then Key := #0;
end;

procedure TForm2.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (Key in [#08, '0'..'9']) then Key := #0;
end;

end.
