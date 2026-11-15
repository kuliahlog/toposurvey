# TopoSurvey

Aplikasi Android untuk mencatat titik survei secara offline dengan GNSS averaging,
barometer opsional, peta lokal ENU, dan ekspor CSV/GeoJSON.

Panduan pengujian HP fisik dan formulir hasil: [Panduan Pengujian](docs/PANDUAN_PENGUJIAN.md).

## Memakai aplikasi

1. Pasang APK, buka **Cek Sensor**, lalu izinkan lokasi presisi dan aktifkan GPS.
2. Buat proyek. Pilih **Mulai Survey → Single Device (1 HP) → Mulai**.
3. Tunggu fix GNSS di area terbuka. Tekan **Catat Titik (GNSS)**.
4. Isi kode titik dan tinggi HP/tongkat di atas titik. Tekan **Mulai Sampling**.
5. Biarkan HP diam dan layar survei terbuka selama 60 detik. Jika sampel masih
   kurang, aplikasi melanjutkan hingga maksimal 120 detik. Diperlukan minimal
   15 sampel valid untuk menyimpan titik.
6. Tekan **Simpan Titik**. Titik muncul pada daftar dan peta proyek.
7. Kembali ke detail proyek. Pilih **Ekspor → CSV / GeoJSON**, lalu bagikan file.

Jika sampel tetap kurang, periksa izin lokasi presisi, aktifkan GPS, dan ulangi di
area terbuka. Fix lama, duplikat, dan koordinat tidak valid tidak dihitung.

## Tinggi dan kualitas

- Tanpa kalibrasi benchmark, tinggi titik menggunakan altitude GNSS dikurangi
  tinggi HP/tongkat. Datum ditandai `ellipsoidal`.
- Jika tersedia barometer, gunakan **Kalibrasi Base / Barometer** pada benchmark
  dengan tinggi diketahui. Tinggi titik berikutnya ditandai `benchmark`.
- CSV memakai kolom `height_m` dan `height_reference`. Kolom lama
  `orthometric_height_m` diganti karena tinggi GNSS bukan tinggi ortometrik.
- GeoJSON menyimpan `height_m` dan `height_reference` dalam properties. Tinggi
  benchmark tidak dimasukkan sebagai Z WGS84; geometri memakai longitude/latitude.
- Warna kualitas menunjukkan kualitas estimasi, bukan jaminan akurasi alat survei profesional.

## Status fitur

- Single Device: GNSS averaging, penyimpanan lokal, daftar titik, peta dan ekspor.
- Virtual Anchor: koordinat dan jarak dimasukkan manual; hasil buruk atau tidak
  konvergen ditolak. Belum ada pengambilan jarak otomatis dari HP lain.
- Network 3 HP dan BLE ranging: belum tersedia; pilihan Network dinonaktifkan.
- JSON sesi: pertukaran anchor dan ringkasan titik; belum merupakan backup penuh
  seluruh observasi mentah.

## Pengembangan

```sh
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

APK: `build/app/outputs/flutter-apk/app-debug.apk`.

Tes alur mencakup capture, simpan ke SQLite, serta ekspor CSV/GeoJSON dengan
pembaruan GNSS setiap 1 dan 5 detik. Validasi sensor dan akurasi lapangan tetap
memerlukan HP Android fisik.
