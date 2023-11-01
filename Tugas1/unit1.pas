unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtCtrls, ActnList;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnHitung: TButton;
    btnClear: TButton;
    btnClose: TButton;
    cbJabatan: TComboBox;
    edtNama: TEdit;
    edtGapok: TEdit;
    edtTunjangan: TEdit;
    edtTotalGaji: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Honorer: TRadioButton;
    rgStatus: TRadioGroup;
    Tetap: TRadioButton;
    procedure btnClearClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnHitungClick(Sender: TObject);
    procedure cbJabatanChange(Sender: TObject);
    procedure edtGapokChange(Sender: TObject);
    procedure edtNamaChange(Sender: TObject);
    procedure edtTotalGajiChange(Sender: TObject);
    procedure edtTunjanganChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure HonorerChange(Sender: TObject);
    procedure rgStatusClick(Sender: TObject);
    procedure TetapChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.GroupBox1Click(Sender: TObject);
begin

end;

procedure TForm1.HonorerChange(Sender: TObject);
begin
  if Honorer.Checked then
  begin
    edtTunjangan.Text := '500000'; // Mengatur nilai tunjangan untuk "Honorer"
  end;
end;

procedure TForm1.rgStatusClick(Sender: TObject);
begin

end;

procedure TForm1.TetapChange(Sender: TObject);
begin
  if Tetap.Checked then
  begin
    edtTunjangan.Text := '1500000'; // Mengatur nilai tunjangan untuk "Tetap"
  end;
end;

procedure TForm1.edtTotalGajiChange(Sender: TObject);
begin

end;

procedure TForm1.edtTunjanganChange(Sender: TObject);
begin
  if Tetap.Checked then
  begin
    edtTunjangan.Text := '1.500.000'; // Mengatur nilai tunjangan untuk "Tetap" sebagai integer
  end
  else if Honorer.Checked then
  begin
    edtTunjangan.Text := '500.000'; // Mengatur nilai tunjangan untuk "Honorer" sebagai integer
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.edtNamaChange(Sender: TObject);
begin

end;

procedure TForm1.cbJabatanChange(Sender: TObject);
begin
  case cbJabatan.ItemIndex of
    0: // Direktur
      edtGapok.Text := '5000000'; // Mengatur nilai gaji untuk Direktur sebagai bilangan bulat
    1: // Manajer
      edtGapok.Text := '3000000'; // Mengatur nilai gaji untuk Manajer sebagai bilangan bulat
    2: // Karyawan
      edtGapok.Text := '1000000'; // Mengatur nilai gaji untuk Karyawan sebagai bilangan bulat
  end;
end;

procedure TForm1.btnHitungClick(Sender: TObject);
var
  gapok, tunjangan, totalGaji: Integer;
begin
  // Validasi: Pastikan pengguna telah memilih baik jabatan (ComboBox) maupun status (Tetap atau Honorer)
  if (cbJabatan.ItemIndex = -1) or (not Tetap.Checked and not Honorer.Checked) then
  begin
    ShowMessage('Pilih jabatan dan status sebelum menghitung total gaji.');
    Exit; // Keluar dari prosedur jika validasi gagal
  end;

  // Konversi nilai gaji dan tunjangan ke integer setelah validasi
  gapok := StrToInt(StringReplace(edtGapok.Text, '.', '', [rfReplaceAll]));
  tunjangan := StrToInt(StringReplace(edtTunjangan.Text, '.', '', [rfReplaceAll]));

  // Menghitung total gaji
  totalGaji := gapok + tunjangan;

  // Menampilkan hasil perhitungan di edtTotalGaji
  edtTotalGaji.Text := FormatFloat('#,#', totalGaji);
end;

procedure TForm1.btnClearClick(Sender: TObject);
begin
  // Reset nilai komponen-komponen ke nilai default atau kosong
  cbJabatan.Text := 'Jabatan'; // Menghapus pilihan pada ComboBox
  edtNama.Text := 'Nama'; // Mengosongkan nilai pada Edit
  edtGapok.Text := 'Gaji Pokok'; // Mengosongkan nilai pada Edit
  edtTunjangan.Text := 'Tunjangan'; // Mengosongkan nilai pada Edit
  edtTotalGaji.Text := 'Total Gaji'; // Mengosongkan nilai pada Edit
  Tetap.Checked := False; // Menghilangkan pilihan pada RadioButton Tetap
  Honorer.Checked := False; // Menghilangkan pilihan pada RadioButton Honorer
  rgStatus.ItemIndex := -1; // Menghapus pilihan pada RadioGroup

  edtTunjangan.Text := 'Tunjangan'; // Kedua kali klik, menghindari Bug
end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
    Close;
end;

procedure TForm1.edtGapokChange(Sender: TObject);
begin
  case cbJabatan.ItemIndex of
    0: // Direktur
      edtGapok.Text := '5.000.000'; // Mengatur nilai gaji untuk Direktur
    1: // Manajer
      edtGapok.Text := '3.000.000'; // Mengatur nilai gaji untuk Manajer
    2: // Karyawan
      edtGapok.Text := '1.000.000'; // Mengatur nilai gaji untuk Karyawan
  end;
end;

end.

