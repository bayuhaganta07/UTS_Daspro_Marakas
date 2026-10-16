# PATHFINDER — Intelligent Route Planner

PATHFINDER adalah program pencarian dan optimasi rute yang dikembangkan menggunakan bahasa Pascal untuk memenuhi tugas Ujian Tengah Semester (UTS) mata kuliah Dasar Pemrograman.

## Anggota Kelompok

| No. | Nama | NIM | KOM | Lab |
|:---:|---|---|:---:|:---:|
| 1 | Bayu Haganta Morgan | 261401001 | B | Lab 3 |
| 2 | Michelle Rajagukguk | 261401019 | B | Lab 3 |
| 3 | Wily David Nababan | 261401032 | B | Lab 3 |

## Fitur Utama

- **Pencarian rute terpendek:** Menggunakan algoritma Dijkstra untuk menentukan rute dengan total jarak paling kecil.
- **Pencarian rute tercepat:** Menentukan rute dengan total waktu perjalanan paling sedikit.
- **Pencarian rute termurah:** Menentukan rute dengan total biaya perjalanan paling rendah.
- **Daftar lokasi dan jalan:** Menampilkan informasi lokasi, jalan, jarak, waktu perjalanan, dan biaya.
- **Pengelolaan jalan:** Memungkinkan pengguna menutup jalan atau membukanya kembali.
- **Penghindaran jalan tertutup:** Mengabaikan jalan berstatus tertutup saat melakukan pencarian rute.
- **Menu interaktif:** Menyediakan pilihan fitur berbasis teks yang dapat digunakan berulang kali sampai pengguna memilih keluar.

## Teknologi

- **Bahasa pemrograman:** Pascal
- **Compiler:** Free Pascal Compiler (FPC)
- **Algoritma pencarian rute:** Dijkstra
- **Antarmuka:** Command Line Interface (CLI)

## Konsep Dasar Pemrograman yang Digunakan

- **Input dan output:** Menggunakan `Readln`, `Write`, dan `Writeln` untuk menerima masukan dan menampilkan informasi.
- **Variabel dan tipe data:** Menggunakan variabel, konstanta, array, record, dan tipe data yang sesuai.
- **Percabangan:** Menggunakan `if-then`, `if-then-else`, percabangan bersarang, dan `case-of`.
- **Perulangan:** Menggunakan `for-to-do`, `while-do`, dan `repeat-until`.
- **Kontrol perulangan:** Menggunakan `Break` dan `Continue` untuk mengatur alur perulangan.

## Contoh Penggunaan Program

PATHFINDER menggunakan lima lokasi simulasi:

1. Kampus
2. Perpustakaan
3. Rumah Sakit
4. Pusat Kota
5. Terminal

### 1. Menjalankan Program

Pastikan Free Pascal Compiler (FPC) sudah terpasang. Buka terminal pada folder proyek, kemudian kompilasi program:

```bash
fpc Main.pas
```

Setelah kompilasi berhasil, jalankan program di Windows:

```powershell
.\Main.exe
```

Menu utama akan ditampilkan. Masukkan nomor pilihan untuk menggunakan fitur yang tersedia.

### 2. Mencari Rute Terpendek

Untuk mencari rute terpendek dari Kampus ke Terminal:

1. Pilih menu `3` (**Cari rute optimal**).
2. Masukkan ID lokasi asal `1` (**Kampus**).
3. Masukkan ID lokasi tujuan `5` (**Terminal**).
4. Pilih kriteria `1` (**Jarak terpendek**).

Berdasarkan hasil pengujian program, rute yang ditemukan adalah:

**Kampus → Perpustakaan → Pusat Kota → Terminal**

Total jarak: **7,50 km**.

### 3. Mencari Rute Tercepat

1. Pilih menu `3` (**Cari rute optimal**).
2. Masukkan ID lokasi asal dan tujuan.
3. Pilih kriteria `2` (**Waktu tercepat**).

Program akan mencari rute dengan total waktu perjalanan paling sedikit berdasarkan data waktu pada setiap jalan.

### 4. Mencari Rute Termurah

1. Pilih menu `3` (**Cari rute optimal**).
2. Masukkan ID lokasi asal dan tujuan.
3. Pilih kriteria `3` (**Biaya termurah**).

Program akan mencari rute dengan total biaya perjalanan paling rendah berdasarkan data biaya pada setiap jalan.

### 5. Menutup atau Membuka Jalan

1. Pilih menu `4` (**Tutup/buka jalan**).
2. Ikuti petunjuk program untuk memilih jalan dan mengubah statusnya.

Jalan yang ditutup akan dihindari dalam pencarian rute. Jika jalan dibuka kembali, jalan tersebut dapat digunakan lagi dalam pencarian berikutnya.

> **Catatan:** Lokasi, jarak, waktu perjalanan, dan biaya merupakan data simulasi. Hasil pencarian dapat berubah sesuai data jalan dan status jalan yang digunakan.

## Status Proyek

Versi awal PATHFINDER telah dibuat, dikompilasi, dan diuji menggunakan data jalan simulasi. Pengujian pencarian rute terpendek dari Kampus ke Terminal menghasilkan rute sepanjang 7,50 km.

## Batasan Proyek

- Data lokasi, jarak, waktu perjalanan, dan biaya masih berupa simulasi.
- Program belum menggunakan data jalan nyata atau informasi lalu lintas secara langsung.
- Hasil pencarian rute bergantung pada data jalan yang tersedia dan status jalan yang ditentukan pengguna.
- Program dijalankan melalui antarmuka berbasis teks (CLI).