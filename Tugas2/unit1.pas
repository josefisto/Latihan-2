unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnHitung: TButton;
    btnKeluar: TButton;
    btnUlang: TButton;
    CBKode: TComboBox;
    EDiskon: TEdit;
    EHarga: TEdit;
    ENama: TEdit;
    EQTY: TEdit;
    ESubTotal: TEdit;
    ETotal: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnHitungClick(Sender: TObject);
    procedure btnKeluarClick(Sender: TObject);
    procedure btnUlangClick(Sender: TObject);
    procedure CBKodeChange(Sender: TObject);
    procedure EDiskonChange(Sender: TObject);
    procedure EHargaChange(Sender: TObject);
    procedure ENamaChange(Sender: TObject);
    procedure EQTYChange(Sender: TObject);
    procedure ESubTotalChange(Sender: TObject);
    procedure ETotalChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CBKodeChange(Sender: TObject);
var
  selectedKode: string;
  HargaInt: Integer;
begin
  // Reset nilai EQTY, ESubTotal, dan EDiskon ke kosong saat ada perubahan kode
  EQTY.Text := '';
  ESubTotal.Text := '';
  EDiskon.Text := '';
  ETotal.Text := ''; // Menambahkan ini untuk mengosongkan ETotal

  selectedKode := CBKode.Text;

  case selectedKode of
    'A01':
      begin
        ENama.Text := 'Speaker';
        HargaInt := 50000;
      end;
    'B02':
      begin
        ENama.Text := 'Mouse';
        HargaInt := 25000;
      end;
    'C03':
      begin
        ENama.Text := 'Harddisk';
        HargaInt := 750000;
      end;
    'D04':
      begin
        ENama.Text := 'Mouse Pad';
        HargaInt := 5000;
      end;
  end;

  EHarga.Text := FormatFloat('#,##0', HargaInt);
end;

procedure TForm1.btnHitungClick(Sender: TObject);
var
  SubTotal: Integer;
  Diskon: Double;
  Total: Double;
begin
  // Mengonversi nilai subtotal dari string ke integer
  if TryStrToInt(StringReplace(ESubTotal.Text, '.', '', [rfReplaceAll]), SubTotal) then
  begin
    // Mengonversi nilai diskon dari string ke double
    Diskon := StrToFloat(StringReplace(EDiskon.Text, '%', '', [])) / 100;

    // Menghitung total setelah diskon
    Total := SubTotal * (1 - Diskon);

    // Mengonversi nilai total ke string dengan pemisah ribuan
    ETotal.Text := FormatFloat('#,##0', Total);
  end
  else
  begin
    ShowMessage('Subtotal harus berupa angka yang valid.');
  end;
end;

procedure TForm1.btnKeluarClick(Sender: TObject);
begin
    Close; // Tutup Program
end;

procedure TForm1.btnUlangClick(Sender: TObject);
begin
  // Mengatur kembali nilai-nilai sesuai dengan kondisi yang diminta
  CBKode.ItemIndex := 0; // Mengatur kembali ke nilai Text
  EQTY.Text := ''; // Mengosongkan EQTY
  ENama.Text := ''; // Mengosongkan ENama
  EHarga.Text := ''; // Mengosongkan EHarga
  ESubTotal.Text := ''; // Mengosongkan ESubTotal
  EDiskon.Text := ''; // Mengosongkan EDiskon
  ETotal.Text := ''; // Mengosongkan ETotal
end;

procedure TForm1.EDiskonChange(Sender: TObject);
begin

end;

procedure TForm1.EHargaChange(Sender: TObject);
begin

end;

procedure TForm1.ENamaChange(Sender: TObject);
begin

end;

procedure TForm1.EQTYChange(Sender: TObject);
var
  Quantity: Integer;
begin
  // Memeriksa apakah input tidak kosong dan adalah angka yang valid
  if Trim(EQTY.Text) <> '' then
  begin
    if not TryStrToInt(EQTY.Text, Quantity) then
    begin
      ShowMessage('Kuantitas harus berupa angka.');
      EQTY.Text := ''; // Membersihkan input jika tidak valid
      Exit;
    end;

    // Memeriksa apakah kuantitas lebih dari 10
    if Quantity > 10 then
    begin
      ShowMessage('Kuantitas tidak boleh lebih dari 10.');
      EQTY.Text := '10'; // Mengatur nilai maksimum jika lebih dari 10
    end;
  end;
  // Memanggil ESubTotalChange untuk menghitung ulang subtotal
  ESubTotalChange(nil);
end;

procedure TForm1.ESubTotalChange(Sender: TObject);
var
  Quantity: Integer;
  UnitPrice: Integer;
  SubTotal: Integer;
  CleanedHarga: string; // String untuk harga tanpa pemisah ribuan
  SubTotalStr: string; // String untuk SubTotal dengan pemisah ribuan
  DiskonStr: string; // String untuk nilai diskon
  EQTYValue: string; // Nilai dari EQTY setelah membersihkan spasi

begin
  // Membersihkan karakter pemisah ribuan dari EHarga.Text
  CleanedHarga := StringReplace(EHarga.Text, '.', '', [rfReplaceAll]);
  CleanedHarga := StringReplace(CleanedHarga, ',', '', [rfReplaceAll]);

  // Membersihkan nilai EQTY dari spasi
  EQTYValue := Trim(EQTY.Text);

  // Mengambil nilai kuantitas dan harga satuan jika EQTYValue tidak kosong
  if EQTYValue <> '' then
  begin
    if TryStrToInt(EQTYValue, Quantity) and TryStrToInt(CleanedHarga, UnitPrice) then
    begin
      // Menghitung subtotal
      SubTotal := Quantity * UnitPrice;
      // Mengonversi SubTotal ke string dengan pemisah ribuan
      SubTotalStr := FormatFloat('#,##0', SubTotal);
      ESubTotal.Text := SubTotalStr;

      // Menghitung diskon berdasarkan nilai subtotal
      if SubTotal >= 100000 then
        DiskonStr := '15%'
      else if SubTotal >= 50000 then
        DiskonStr := '10%'
      else if SubTotal >= 25000 then
        DiskonStr := '5%'
      else
        DiskonStr := '0%';

      // Mengatur nilai diskon pada EDiskonChange
      EDiskon.Text := DiskonStr;
    end
    else
    begin
      // Menampilkan pesan kesalahan jika kuantitas atau harga tidak valid
      ShowMessage('Kuantitas dan harga harus berupa angka yang valid.');
    end;
  end
  else
  begin
    // Mengosongkan ESubTotal dan EDiskon jika EQTY kosong
    ESubTotal.Text := '';
    EDiskon.Text := '';
  end;
end;

procedure TForm1.ETotalChange(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.

