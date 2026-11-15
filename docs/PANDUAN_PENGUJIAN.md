# Panduan Pengujian TopoSurvey

Panduan ini digunakan untuk menguji aplikasi pada HP Android fisik, mencatat hasil,
dan menentukan apakah alur survei satu perangkat dapat dipakai.

## 1. Informasi pengujian

Isi sebelum mulai.

| Informasi | Nilai |
|---|---|
| Tanggal dan waktu | |
| Nama penguji | |
| Model HP | |
| Versi Android | |
| Versi APK / commit | |
| Lokasi pengujian | |
| Kondisi area dan cuaca | |
| Barometer tersedia | Ya / Tidak |

**Status hasil:** Lulus, Gagal, Belum diuji, atau Tidak berlaku.

## 2. Persiapan

- [ ] Pasang APK terbaru.
- [ ] Siapkan area terbuka dan lokasi yang aman untuk menaruh HP.
- [ ] Aktifkan GPS dan izinkan lokasi presisi untuk TopoSurvey.
- [ ] Siapkan penggaris atau meteran untuk mengukur tinggi HP di atas titik.
- [ ] Siapkan aplikasi penerima file, misalnya file manager atau aplikasi berbagi.
- [ ] Siapkan spreadsheet untuk CSV dan QGIS untuk GeoJSON.
- [ ] Gunakan proyek khusus pengujian agar data lapangan tidak tercampur.

Biarkan HP diam selama sampling. Catat tinggi sensor/HP di atas titik tanah,
bukan tinggi badan penguji. Pertahankan layar survei terbuka selama pengambilan.

## 3. Kasus pengujian utama

### UJI-01 — Izin dan pembacaan sensor

**Langkah:**

1. Buka aplikasi dan pilih **Cek Sensor**.
2. Izinkan lokasi presisi ketika diminta.
3. Pastikan GPS aktif dan tunggu pembacaan di area terbuka.
4. Amati koordinat, altitude, akurasi, dan status barometer.

**Hasil yang diharapkan:**

- Koordinat dan akurasi GNSS muncul setelah memperoleh fix.
- Altitude tampil jika dilaporkan perangkat.
- Tekanan tampil jika barometer tersedia; perangkat tanpa barometer menampilkan
  status tidak tersedia dan masih dapat memakai GNSS.
- Izin BLE yang tampil tidak berarti BLE ranging sudah tersedia.

### UJI-02 — Membuat dan membuka kembali proyek

**Langkah:**

1. Buat proyek bernama `Uji Lapangan`.
2. Isi deskripsi singkat. Biarkan benchmark kosong untuk uji GNSS awal.
3. Kembali ke halaman utama.
4. Tutup aplikasi sepenuhnya, buka lagi, lalu buka proyek tersebut.

**Hasil yang diharapkan:** proyek dan informasi yang diisi tetap tersimpan.

### UJI-03 — Memulai sesi Single Device

**Langkah:**

1. Pada detail proyek, tekan **Mulai Survey**.
2. Pilih **Single Device (1 HP)** dan peran **Rover**.
3. Tekan **Mulai** dan tunggu posisi GNSS muncul.

**Hasil yang diharapkan:** layar survei terbuka dengan mode Single, kode sesi,
status sensor, peta, dan tombol **Catat Titik (GNSS)**.

### UJI-04 — Capture GNSS sampai selesai

**Langkah:**

1. Tempatkan HP diam pada lokasi uji.
2. Tekan **Catat Titik (GNSS)**.
3. Isi kode `UJI-001`, layer `tanah`, deskripsi, dan tinggi HP yang sudah diukur.
4. Tekan **Mulai Sampling**.
5. Amati jumlah sampel, progress, dan kualitas sampai sampling selesai.

**Hasil yang diharapkan:**

- Sampel valid bertambah; aplikasi meminta pembaruan GNSS setiap 1 detik.
  Frekuensi aktual tetap bergantung pada perangkat dan kondisi penerimaan.
- Sampling berjalan 60 detik. Jika sampel kurang dari 15, sampling dilanjutkan
  hingga cukup atau mencapai batas 120 detik.
- Hasil menampilkan jumlah sampel, rata-rata koordinat, dan kualitas.
- Simpan hanya tersedia jika minimal 15 sampel valid dan sumber tinggi tersedia.
- Jika hasil belum memadai, penguji mendapat informasi untuk mengulang sampling.

Catat: durasi aktual, jumlah sampel, akurasi horizontal, dan kualitas hasil.

### UJI-05 — Menyimpan titik

**Langkah:**

1. Setelah UJI-04 memenuhi syarat, tekan **Simpan Titik**.
2. Periksa daftar titik dan peta.
3. Buka detail titik `UJI-001`.

**Hasil yang diharapkan:**

- Titik muncul sekali di daftar dan peta.
- Kode, layer, deskripsi, koordinat, tinggi, tinggi tongkat, metode, dan kualitas
  sesuai data yang dimasukkan serta hasil capture.
- Tanpa kalibrasi benchmark, metode adalah GNSS dan datum tinggi adalah elipsoid.
- Tinggi titik adalah altitude GNSS hasil averaging dikurangi tinggi HP/tongkat.

### UJI-06 — Persistensi titik setelah aplikasi ditutup

**Langkah:**

1. Catat nilai koordinat dan tinggi `UJI-001`.
2. Tutup aplikasi sepenuhnya dan buka kembali.
3. Buka `Uji Lapangan` dan periksa titiknya.

**Hasil yang diharapkan:** titik tetap tersimpan dengan nilai yang sama.

### UJI-07 — Beberapa titik pada peta

**Langkah:**

1. Pindah ke dua lokasi berbeda dan ulangi capture untuk `UJI-002` dan `UJI-003`.
2. Periksa jumlah titik, posisi marker, arah utara, dan skala peta.
3. Bandingkan susunan marker dengan arah perpindahan di lapangan.

**Hasil yang diharapkan:** ketiga titik tampil dan peta menyesuaikan cakupannya.
Posisi relatif mengikuti perpindahan dalam batas akurasi GNSS perangkat.
Jarak perpindahan yang lebih kecil daripada ketidakpastian GNSS tidak dapat
menjadi bukti kesalahan peta.

### UJI-08 — Ekspor CSV

**Langkah:**

1. Kembali ke detail proyek dan pilih **Ekspor → Ekspor CSV**.
2. Pilih aplikasi penerima, lalu simpan atau kirim file.
3. Buka file di spreadsheet.
4. Cocokkan jumlah baris dan nilai setiap titik dengan aplikasi.

**Hasil yang diharapkan:**

- File CSV berhasil dibuat dan dapat dibagikan ke aplikasi penerima.
- Jumlah baris data sama dengan jumlah titik aktif proyek.
- Kode, koordinat, metode, kualitas, dan tinggi sesuai aplikasi.
- Kolom `height_m` dan `height_reference` tersedia.
- Titik GNSS memakai `ellipsoidal`; titik GNSS + barometer memakai `benchmark`.

Jika share sheet tidak menemukan penerima, pasang aplikasi penerima dan ulangi.
Catat kegagalan membuat file terpisah dari ketiadaan aplikasi penerima.

### UJI-09 — Ekspor GeoJSON

**Langkah:**

1. Pilih **Ekspor → Ekspor GeoJSON** pada detail proyek.
2. Simpan file dan buka di QGIS sebagai layer vektor.
3. Periksa jumlah fitur, tabel atribut, dan koordinat titik.

**Hasil yang diharapkan:**

- File terbaca sebagai FeatureCollection dengan fitur Point.
- Jumlah fitur sama dengan jumlah titik aktif proyek.
- Urutan koordinat adalah longitude, latitude, lalu Z jika tersedia.
- Properties memuat `height_m` dan `height_reference`.
- Untuk titik GNSS, Z memakai tinggi elipsoid yang telah dikurangi tinggi tongkat.
- Untuk titik benchmark, geometri memakai longitude/latitude; tinggi benchmark
  disimpan pada properties, bukan sebagai Z WGS84.

### UJI-10 — Survei tanpa internet

**Langkah:**

1. Matikan Wi-Fi dan data seluler; biarkan GPS tetap aktif.
2. Buat atau buka proyek, lakukan capture, simpan titik, lalu ekspor ke penyimpanan lokal.

**Hasil yang diharapkan:** alur inti, database, peta lokal, dan pembuatan file tetap
berfungsi. Pengiriman melalui aplikasi yang membutuhkan internet dapat menunggu
koneksi tersedia. Fix GNSS awal dapat membutuhkan waktu lebih lama.

## 4. Kasus gangguan dan validasi

### UJI-11 — Sampel kurang

1. Mulai capture dan hentikan sebelum 15 sampel valid terkumpul.
2. Periksa tombol **Simpan Titik**.

**Harapan:** peringatan sampel kurang muncul; tombol simpan nonaktif.
Tidak ada titik baru yang tersimpan. Pengambilan dapat diulang.

### UJI-12 — GPS mati atau izin lokasi ditolak

1. Matikan GPS atau cabut izin lokasi melalui pengaturan Android.
2. Buka survei atau coba mulai capture.
3. Pulihkan GPS dan izin lokasi presisi.
4. Tekan **Restart GNSS** pada layar survei jika pembacaan belum pulih.

**Harapan:** aplikasi menampilkan kondisi lokasi/izin dan tidak crash.
Setelah izin serta GPS dipulihkan, pembacaan baru dapat diterima.
Capture tidak dimulai dari fix yang berusia lebih dari 10 detik.

### UJI-13 — Input wajib dan tinggi HP

1. Selesaikan sampling yang memenuhi syarat.
2. Kosongkan kode titik, lalu coba simpan.
3. Uji tinggi HP kosong, negatif, nol, lebih dari 5 meter, dan teks bukan angka.
4. Isi kode dan tinggi yang valid, lalu simpan.

**Harapan:** input tidak valid ditolak dengan pesan. Data valid dapat disimpan.
Tinggi HP pada capture Single harus lebih dari 0 dan paling besar 5 meter.

### UJI-14 — Menghapus titik

1. Hapus satu titik percobaan melalui menu titik dan konfirmasi.
2. Periksa daftar dan peta, lalu ekspor ulang.

**Harapan:** titik yang dihapus tidak muncul di daftar, peta, atau ekspor terbaru.

## 5. Fitur tambahan

### UJI-15 — Barometer dan benchmark

**Syarat:** HP memiliki barometer dan tersedia benchmark dengan tinggi diketahui.
Jika tidak terpenuhi, tandai **Tidak berlaku**.

1. Pada benchmark, buka **Kalibrasi Base / Barometer**.
2. Isi tinggi benchmark dan simpan kalibrasi tekanan base.
3. Ambil titik dengan posisi sensor dan tinggi HP/tongkat tercatat.
4. Periksa metode, tinggi, dan ekspor.
5. Ulangi pada posisi sensor lebih tinggi atau lebih rendah yang diketahui.

**Harapan:** metode menjadi GNSS + barometer dan referensi tinggi `benchmark`.
Tinggi mengikuti `tinggi benchmark + beda tinggi tekanan − tinggi HP/tongkat`.
Catat apakah benchmark merujuk posisi sensor ketika tekanan base diambil.
Cuaca dan drift tekanan dapat memengaruhi hasil; catat waktu kalibrasi.

### UJI-16 — Virtual Anchor dengan input manual

**Syarat:** tersedia minimal tiga koordinat anchor WGS84 yang diketahui dan
jarak horizontal dari target ke setiap anchor. Susun anchor tidak segaris.

1. Buat sesi **Virtual Anchor (2 HP)**.
2. Tambahkan minimal tiga anchor melalui **Tambah Anchor**.
3. Isi latitude, longitude, dan tinggi elipsoid setiap anchor.
4. Pilih **Trilaterasi**, lalu isi kode target, tinggi tongkat, dan jarak horizontal
   ke setiap anchor. Solver yang tersedia menghitung posisi horizontal 2D.
5. Periksa hasil dan titik yang disimpan.
6. Ulangi dengan jarak tidak valid atau geometri buruk.

**Harapan:** input valid dan solusi yang layak dapat disimpan; input tidak valid,
solusi berkualitas buruk, atau tidak konvergen ditolak.

Koordinat anchor dari satu fix GNSS biasa mengandung ketidakpastian dan tidak
setara dengan titik kontrol terukur. Fitur ini belum mengambil jarak lewat BLE.
Ketinggian bukan hasil trilaterasi 3D.

### UJI-17 — Status Network

1. Buka dialog setup sesi.
2. Periksa pilihan **Network (3 HP)**.

**Harapan:** pilihan ditandai belum tersedia dan tidak dapat dipilih.
BLE discovery, ranging, dan pertukaran observasi tiga HP belum menjadi bagian
pengujian penerimaan versi ini.

## 6. Rekap hasil

Isi hasil aktual setelah setiap kasus dijalankan. Jangan menandai lulus hanya
karena halaman atau tombol tersedia.

| ID | Fitur | Status | Hasil aktual / bukti |
|---|---|---|---|
| UJI-01 | Izin dan sensor | Belum diuji | |
| UJI-02 | Proyek tersimpan | Belum diuji | |
| UJI-03 | Sesi Single | Belum diuji | |
| UJI-04 | Capture GNSS | Belum diuji | |
| UJI-05 | Simpan titik | Belum diuji | |
| UJI-06 | Persistensi titik | Belum diuji | |
| UJI-07 | Peta beberapa titik | Belum diuji | |
| UJI-08 | CSV dan berbagi file | Belum diuji | |
| UJI-09 | GeoJSON di QGIS | Belum diuji | |
| UJI-10 | Offline | Belum diuji | |
| UJI-11 | Sampel kurang | Belum diuji | |
| UJI-12 | GPS dan izin bermasalah | Belum diuji | |
| UJI-13 | Validasi input | Belum diuji | |
| UJI-14 | Hapus titik | Belum diuji | |
| UJI-15 | Barometer dan benchmark | Belum diuji | |
| UJI-16 | Virtual Anchor manual | Belum diuji | |
| UJI-17 | Status Network | Belum diuji | |

## 7. Formulir laporan masalah

Salin formulir ini untuk setiap kegagalan.

```text
ID kasus:
Model HP / versi Android:
Versi APK / commit:
Tanggal dan waktu:
Langkah untuk mengulang:
Hasil yang diharapkan:
Hasil aktual:
Pesan error:
Kondisi GPS / internet / sensor:
Screenshot atau video:
Frekuensi kejadian: selalu / kadang-kadang
```

## 8. Kriteria penerimaan dan batas bukti

Alur Single diterima jika UJI-01 sampai UJI-14 lulus pada HP fisik yang diuji.
Barometer dan Virtual Anchor dinilai terpisah sesuai syarat perangkat dan data.
Simpan bukti ekspor, screenshot, serta rekap hasil bersama identitas versi APK.

Sebagai bukti awal pengembangan, pemeriksaan sebelumnya menghasilkan:

- Analyzer tanpa temuan dan 41 tes otomatis lulus.
- APK debug berhasil dibangun.
- Emulator mendapat 54 sampel dalam 60 detik, menyimpan titik, dan mempertahankannya
  setelah aplikasi dibuka ulang.
- CSV dan GeoJSON dibuat pada emulator. Share sheet terbuka, tetapi emulator
  tidak memiliki aplikasi penerima file.

Hasil emulator tersebut tidak menggantikan pengujian sensor, akurasi lapangan,
pembukaan file di spreadsheet/QGIS, atau pengiriman file pada HP fisik.
