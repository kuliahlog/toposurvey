# Product Requirement Document (PRD)

## TopoSurvey — Alat Survey Topografi Android Berbasis Flutter

| Field | Keterangan |
|---|---|
| Nama Produk | TopoSurvey (working title) |
| Jenis Produk | Aplikasi Android untuk pengumpulan titik survey topografi |
| Platform | Android 8.0+ (API 26+), Flutter |
| Versi Dokumen | 1.0 |
| Status | Disetujui untuk implementasi MVP |
| Tanggal | 2 November 2026 |
| Pemilik Produk | Tim Pengembang TopoSurvey |
| Reviewer | Dosen Pengampu Sistem Informasi Geografis |
| Sumber Kebutuhan | Tugas survey topografi: titik ketinggian, trilaterasi/multilaterasi, minimal 3 HP, BLE, GitHub Actions |

---

## 1. Ringkasan Eksekutif

TopoSurvey adalah aplikasi Android yang digunakan untuk mengumpulkan titik survey topografi (koordinat horizontal dan ketinggian) menggunakan minimal tiga ponsel Android. Karena akurasi GNSS ponsel umumnya hanya sekitar 5–10 meter, aplikasi menggabungkan:

1. **GNSS averaging** untuk posisi absolut.
2. **BLE RSSI ranging** untuk jarak relatif antar-ponsel.
3. **Barometer** untuk beda ketinggian relatif.
4. **Weighted least-squares multilateration / network adjustment** untuk menghasilkan posisi yang lebih konsisten.

Aplikasi bersifat **offline-first** dan tidak bergantung pada server. Data antar-ponsel dipertukarkan melalui BLE advertising/GATT. Hasil survey dapat dilihat pada peta lokal offline dan diekspor ke CSV/GeoJSON. Build APK dilakukan otomatis melalui GitHub Actions dengan auto-tag dan GitHub Release.

---

## 2. Latar Belakang & Masalah

### 2.1 Latar Belakang

Praktikum Sistem Informasi Geografis membutuhkan alat survey topografi berbasis Android. GNSS pada ponsel memiliki keterbatasan akurasi, terutama pada sumbu vertikal. Oleh karena itu diperlukan metode pengukuran berjaring yang memanfaatkan beberapa ponsel dan sensor tambahan.

### 2.2 Masalah

- GNSS ponsel tidak cukup akurat untuk pengukuran topografi detail.
- Satu ponsel tidak dapat melakukan trilaterasi karena tidak memiliki pasangan pengukuran jarak.
- Belum tersedia alat survey topografi sederhana yang dapat bekerja offline di lapangan.
- Proses build dan distribusi APK secara manual menyulitkan pengujian di beberapa perangkat.

### 2.3 Kesesuaian dengan Tugas

| Ketentuan Tugas | Pemenuhan |
|---|---|
| Titik ketinggian setiap permukaan | Capture titik X/Y/Z dengan kode, layer, deskripsi, dan tinggi tongkat |
| GPS akurasi ±10 m → trilaterasi/multilaterasi | Fusi GNSS + BLE RSSI + barometer dengan WLS |
| Pengumpulan titik minimal 3 HP | Mode Network 3 perangkat; fallback 2 HP virtual anchor |
| BLE memperkuat data | Kalibrasi RSSI, filter, ranging, pertukaran observasi via BLE |
| GitHub Workflow auto tag dan release APK | CI, auto-tag, signed release APK |

---

## 3. Tujuan Produk

### 3.1 Tujuan

1. Menyediakan aplikasi Android yang benar-benar berfungsi untuk mengambil data sensor nyata, menghitung posisi, dan mengekspor hasil survey.
2. Mendemonstrasikan trilaterasi/multilaterasi menggunakan minimal 3 ponsel.
3. Menyediakan fallback yang tetap dapat didemokan dengan 2 ponsel (mode virtual anchor).
4. Menjamin aplikasi inti dapat berjalan tanpa internet.
5. Menghasilkan APK yang dapat dipasang langsung melalui GitHub Releases.
6. Menyediakan dokumentasi pengukuran dan laporan kualitas hasil.

### 3.2 Metrik Keberhasilan

| Metrik | Target |
|---|---|
| Aplikasi berjalan di 3 HP fisik | Ya |
| Survey offline tanpa server | Ya |
| Titik hasil trilaterasi 2 HP virtual anchor | Ya, dengan minimal 3 anchor |
| Titik hasil network adjustment 3 HP | Ya, dengan quality flag |
| Ekspor CSV/GeoJSON dapat dibuka di Excel/QGIS | Ya |
| Release APK otomatis dari tag Git | Ya |
| Crash saat sesi 30 menit | Tidak ada crash fatal |
| Repeatability horizontal antar-sesi | Dilaporkan; target internal ≤ 3 m |

### 3.3 Non-Goals

- Akurasi centimeter atau setara RTK/total station.
- Dukungan iOS.
- Pembuatan kontur, TIN, atau model permukaan otomatis di dalam aplikasi.
- Integrasi dengan alat ukur eksternal pada MVP.
- Backend cloud, akun pengguna, atau dashboard web.
- Peta offline dengan tile penuh; OSM online hanya opsi.
- Ekspor DXF pada MVP (masuk backlog).
- Sinkronisasi lebih dari 3 perangkat pada MVP.

---

## 4. Pengguna & Persona

| Persona | Kebutuhan Utama | Pain Point |
|---|---|---|
| Operator Rover | Mengambil titik cepat, melihat kualitas fix | Tidak tahu apakah data cukup baik |
| Operator Base/Anchor | Menempatkan HP di titik kontrol, memastikan BLE aktif | Sinyal BLE tidak stabil, lupa kalibrasi |
| Mahasiswa/Dosen Evaluator | Melihat bukti pengukuran, ekspor data, laporan | Sulit memverifikasi hasil tanpa data mentah |
| Pengguna Single-Phone | Mencatat titik dengan GNSS/barometer | Tidak bisa trilaterasi, akurasi terbatas |

---

## 5. Lingkup Produk

### 5.1 Mode Operasi

| Mode | Jumlah HP | Metode | Status MVP |
|---|---|---|---|
| Single | 1 | GNSS averaging + barometer; tanpa trilaterasi | Wajib sebagai fallback |
| Virtual Anchor | 2 | HP anchor dipindah ke minimal 3 posisi berjarak diketahui; HP rover menghitung trilaterasi | Wajib sebagai fallback demo |
| Network | 3 | Semua HP saling mengukur RSSI; GNSS + jarak + barometer diadjust bersama | Wajib, target utama demo |

### 5.2 Ruang Lingkup MVP

- Manajemen proyek dan sesi survey.
- Pemeriksaan sensor dan izin Android.
- GNSS live, averaging, dan quality control.
- Barometer: ketersediaan sensor, pembacaan tekanan, tinggi relatif, kalibrasi base.
- BLE scan/advertise, kalibrasi RSSI, estimasi jarak, pertukaran observasi.
- Solver trilaterasi dan network adjustment.
- Penyimpanan lokal seluruh observasi mentah dan hasil hitung.
- Peta lokal offline berbasis koordinat ENU.
- Ekspor CSV, GeoJSON, dan backup JSON.
- Diagnostik dan log.
- CI/CD GitHub Actions, auto-tag, release APK.

### 5.3 Di Luar MVP

- Cloud sync dan multi-user.
- Lebih dari 3 perangkat dalam satu sesi.
- Tile peta offline.
- Pengolahan kontur/TIN.
- DXF dan format CAD.
- Kalibrasi otomatis sensor barometer tingkat lanjut.
- Dukungan iOS.

---

## 6. Alur Pengguna

### 6.1 Setup Survey 3 HP (Mode Network)

1. Pengguna membuat proyek, menentukan nama dan datum lokal.
2. Aplikasi menampilkan **Cek Sensor** pada tiap HP: GNSS, BLE, barometer.
3. Pengguna membuat sesi mode Network dan memilih peran perangkat.
4. Ketiga HP ditempatkan pada tiga titik yang membentuk segitiga.
5. Pengguna menjalankan kalibrasi RSSI (HP berdekatan pada jarak 1 m).
6. Pengguna menekan **Mulai Epoch**; ketiga HP melakukan sampling GNSS, RSSI, dan barometer selama 60–120 detik.
7. Setiap HP menyiarkan observasi ringkas melalui BLE; seluruh HP menyusun data observasi.
8. Solver menjalankan network adjustment; hasil posisi dan quality flag ditampilkan.
9. Pengguna menyimpan tiga titik survey.
10. Perangkat dipindah ke blok titik berikutnya dan langkah 6–9 diulang.
11. Setelah selesai, pengguna mengekspor CSV/GeoJSON dan backup JSON.

### 6.2 Demo 2 HP (Virtual Anchor)

1. Pengguna menyiapkan tiga posisi anchor dengan jarak yang diketahui menggunakan pita ukur, misalnya segitiga sama sisi 5 m.
2. HP A ditempatkan di titik target dan bertindak sebagai rover.
3. HP B ditempatkan di posisi anchor 1, melakukan GNSS averaging, lalu menyiarkan posisinya.
4. HP A mengambil sampel RSSI ke HP B dan menyimpan jarak estimasi.
5. Langkah 3–4 diulang untuk anchor 2 dan anchor 3.
6. HP A menghitung trilaterasi menggunakan tiga jarak dan tiga koordinat anchor.
7. Hasil ditampilkan lengkap dengan residual, geometri, dan quality flag.
8. Posisi lokal digeoreferensi menggunakan GNSS HP A, lalu diekspor.

### 6.3 Survey 1 HP (Fallback)

1. Pengguna membuat proyek dan sesi mode Single.
2. Aplikasi mengambil GNSS averaging dan barometer.
3. Titik disimpan sebagai `GNSS + baro` atau `GNSS only`.
4. Aplikasi menampilkan peringatan bahwa hasil belum memenuhi syarat trilaterasi.

---

## 7. Kebutuhan Fungsional

Prioritas: **M** = Must, **S** = Should, **C** = Could.

### 7.1 Proyek & Datum

| ID | Kebutuhan | Prioritas | Kriteria Terima |
|---|---|---|---|
| FR-PRJ-01 | Membuat, membuka, dan menghapus proyek survey | M | Proyek tersimpan lokal dan muncul di daftar |
| FR-PRJ-02 | Menentukan origin proyek dan sistem koordinat tampilan (WGS84/UTM) | M | Origin otomatis dari fix pertama atau input manual |
| FR-PRJ-03 | Input tinggi benchmark/known point (opsional) | S | Tinggi ortometrik dapat dikalibrasi |
| FR-PRJ-04 | Menampilkan datum lokal dan status tinggi (relatif/absolut) | M | Setiap titik memiliki label datum |
| FR-PRJ-05 | Menyimpan pengaturan proyek (satuan, format koordinat) | S | Pengaturan bertahan setelah aplikasi ditutup |

### 7.2 Sesi & Perangkat

| ID | Kebutuhan | Prioritas | Kriteria Terima |
|---|---|---|---|
| FR-SES-01 | Memilih mode Single, Virtual Anchor, atau Network | M | Mode tersimpan pada sesi |
| FR-SES-02 | Menentukan peran perangkat (base/anchor/rover) | M | Peran tampil pada layar sesi |
| FR-SES-03 | Membuat sesi dengan kode sesi dan short device ID | M | Perangkat lain dapat menemukan sesi |
| FR-SES-04 | Menampilkan status perangkat yang terdeteksi | M | Nama, peran, RSSI, dan status terlihat |
| FR-SES-05 | Memulai dan menghentikan epoch pengukuran dengan countdown | M | Sampling berjalan serentak pada semua HP |
| FR-SES-06 | Pertukaran observasi antar-HP melalui BLE | M | Data GNSS, baro, dan jarak diterima perangkat lain |
| FR-SES-07 | Fallback pertukaran data melalui file JSON | S | Proyek dapat digabung manual jika BLE gagal |
| FR-SES-08 | Menampilkan peringatan jika perangkat kurang dari mode yang dipilih | M | Aplikasi tidak memulai solver dengan data kurang |

### 7.3 Sensor & Akuisisi

| ID | Kebutuhan | Prioritas | Kriteria Terima |
|---|---|---|---|
| FR-SEN-01 | Layar Cek Sensor: GNSS, BLE, barometer | M | Status tersedia/tidak tersedia dan nilai live tampil |
| FR-SEN-02 | Alur izin lokasi, BLE scan/connect/advertise, dan foreground service | M | Izin diminta dengan alasan yang jelas |
| FR-GNSS-01 | Menampilkan fix live: lat, lon, altitude, accuracy, satellites | M | Nilai diperbarui minimal tiap 2 detik |
| FR-GNSS-02 | GNSS averaging 60–120 detik dengan outlier rejection | M | Rata-rata, std dev, dan jumlah sampel ditampilkan |
| FR-GNSS-03 | Menolak fix yang tidak stabil atau jumlah sampel kurang | M | Tombol simpan nonaktif/peringatan tampil |
| FR-GNSS-04 | Menyimpan GPS ellipsoidal height dan horizontal/vertical accuracy | M | Data mentah tersimpan |
| FR-BARO-01 | Membaca tekanan barometer secara kontinu | M | Tekanan hPa tampil dan berubah |
| FR-BARO-02 | Menghitung tinggi relatif terhadap base | M | Beda tinggi ditampilkan dalam meter |
| FR-BARO-03 | Kalibrasi base pressure dan koreksi drift berkala | S | Pembacaan base diambil ulang selama sesi |
| FR-BARO-04 | Fallback ke GNSS altitude jika barometer tidak ada | M | Status kualitas diturunkan dan diberi label |
| FR-BARO-05 | Input tinggi tongkat/HP di atas titik | M | Tinggi titik = tinggi sensor − tinggi tongkat |
| FR-BLE-01 | Advertising dan scanning BLE dengan service UUID dan device ID | M | Perangkat lain terdeteksi dalam 10 detik |
| FR-BLE-02 | Sampling RSSI 20–60 detik dengan filter median/Kalman | M | Nilai RSSI mentah dan terfilter disimpan |
| FR-BLE-03 | Kalibrasi RSSI pada jarak 1 m dan path-loss exponent | M | Parameter kalibrasi tersimpan per perangkat |
| FR-BLE-04 | Estimasi jarak dari RSSI | M | Jarak dan estimasi error tampil |
| FR-BLE-05 | Menyiarkan GNSS, tinggi baro, dan hasil ranging secara ringkas | M | Payload diterima dan diparse perangkat lain |
| FR-BLE-06 | Fallback GATT read/connect jika advertising tidak mendukung | C | Data tetap dapat dipertukarkan |

### 7.4 Positioning

| ID | Kebutuhan | Prioritas | Kriteria Terima |
|---|---|---|---|
| FR-POS-01 | Konversi WGS84 ↔ ECEF ↔ ENU lokal | M | Uji round-trip dalam toleransi 1 mm |
| FR-POS-02 | Trilaterasi WLS dengan minimal 3 anchor | M | Solusi konvergen dan residual ditampilkan |
| FR-POS-03 | Network adjustment 3 perangkat dengan GNSS prior dan jarak BLE | M | Ketiga posisi teradjust bersama |
| FR-POS-04 | Menghitung quality flag: good/fair/poor | M | Berdasarkan residual, geometri, jumlah anchor, dan akurasi |
| FR-POS-05 | Menghitung ulang titik dari observasi mentah | S | Hasil lama tidak menimpa data mentah |
| FR-POS-06 | Mendukung anchor manual/koordinat lokal yang diketahui | M | Diperlukan untuk demo virtual anchor |
| FR-POS-07 | Fusi ketinggian GNSS + barometer | M | Ketinggian akhir dan sumbernya ditampilkan |
| FR-POS-08 | Menolak solusi dengan geometri buruk (GDOP tinggi) | M | Titik tidak tersimpan sebagai hasil valid |

### 7.5 Titik Survey

| ID | Kebutuhan | Prioritas | Kriteria Terima |
|---|---|---|---|
| FR-PT-01 | Menyimpan titik dengan kode, layer, deskripsi, dan tinggi tongkat | M | Titik muncul di daftar dan peta |
| FR-PT-02 | Menampilkan progress capture dan estimasi kualitas sebelum simpan | M | Pengguna dapat membatalkan |
| FR-PT-03 | Mengedit dan menghapus titik | S | Perubahan tercatat dan dapat diekspor ulang |
| FR-PT-04 | Melampirkan foto titik | C | Foto tersimpan lokal dan dirujuk pada ekspor |
| FR-PT-05 | Menampilkan sumber metode titik (GNSS/trilaterasi/network) | M | Terlihat di detail dan ekspor |

### 7.6 Peta

| ID | Kebutuhan | Prioritas | Kriteria Terima |
|---|---|---|---|
| FR-MAP-01 | Peta lokal offline berbasis ENU dengan grid, skala, dan arah utara | M | Titik dan anchor tampil tanpa internet |
| FR-MAP-02 | Mewarnai titik berdasarkan kualitas dan menampilkan anchor | M | Legenda tersedia |
| FR-MAP-03 | Opsi basemap OSM online | C | Dapat dimatikan; aplikasi tetap berfungsi offline |
| FR-MAP-04 | Menampilkan jarak antar-anchor dan skala grafis | S | Berguna untuk verifikasi geometri |

### 7.7 Ekspor & Diagnostik

| ID | Kebutuhan | Prioritas | Kriteria Terima |
|---|---|---|---|
| FR-EXP-01 | Ekspor CSV titik survey | M | Kolom koordinat, tinggi, akurasi, metode, waktu |
| FR-EXP-02 | Ekspor GeoJSON Point Z | M | Dapat dibuka di QGIS |
| FR-EXP-03 | Backup/restore proyek dalam JSON | S | Seluruh observasi dan hasil dapat dipulihkan |
| FR-EXP-04 | Membagikan file ekspor melalui share sheet Android | M | File dapat dikirim ke aplikasi lain |
| FR-DIAG-01 | Log diagnostik GNSS/BLE/baro dan ekspor log | S | Berguna untuk debugging lapangan |
| FR-DIAG-02 | Laporan kualitas sesi: residual, jumlah sampel, perangkat | S | Dapat dilampirkan pada laporan praktikum |

---

## 8. Kebutuhan Non-Fungsional

| ID | Kebutuhan | Target |
|---|---|---|
| NFR-01 | Offline-first | Seluruh fungsi inti berjalan tanpa internet |
| NFR-02 | Performa solver | < 2 detik untuk 3 perangkat pada perangkat mid-range |
| NFR-03 | Ketahanan data | Setiap sampel disimpan; tidak hilang saat aplikasi ditutup |
| NFR-04 | Akurasi | Target internal horizontal ≤ 3 m dan vertikal ≤ 1,5 m; hasil aktual dilaporkan |
| NFR-05 | Kompatibilitas | Android 8.0+ dengan BLE; diuji pada minimal 3 perangkat fisik |
| NFR-06 | Baterai | Sesi 30 menit tidak menghabiskan lebih dari 40% baterai |
| NFR-07 | Usability | Alur mulai capture maksimal 3 tap dari layar sesi |
| NFR-08 | Bahasa | Antarmuka berbahasa Indonesia |
| NFR-09 | Privasi | Tidak ada data lokasi yang dikirim ke server |
| NFR-10 | Keamanan | APK release ditandatangani; keystore tidak masuk repositori |
| NFR-11 | Maintainability | `flutter analyze` bersih; modul solver memiliki unit test |
| NFR-12 | Ukuran APK | Universal APK < 60 MB; split-per-ABI disediakan |
| NFR-13 | Aksesibilitas | Tombol utama minimal 48 dp, kontras memadai |
| NFR-14 | Reliabilitas BLE | Sesi tetap berjalan meski satu perangkat terputus sementara |
| NFR-15 | Observability | Log lokal untuk GNSS, BLE, dan barometer |

---

## 9. Arsitektur Sistem

### 9.1 Gambaran Umum

```
┌──────────────────────────────────────────────────────────────┐
│                    Flutter UI (Riverpod + go_router)         │
│  Projects │ Session │ Map │ Capture │ Points │ Diagnostics   │
└──────────────────────────────┬───────────────────────────────┘
                               │
┌──────────────────────────────▼───────────────────────────────┐
│                         Domain Layer                         │
│  Survey point │ Session │ Positioning engine │ Quality       │
└───────┬──────────────────┬──────────────────┬────────────────┘
        │                  │                  │
┌───────▼───────┐  ┌───────▼───────┐  ┌───────▼───────────────┐
│ GNSS service  │  │ BLE service   │  │ Barometer service     │
│ geolocator    │  │ BLE central + │  │ sensors_plus          │
│               │  │ peripheral    │  │                       │
└───────┬───────┘  └───────┬───────┘  └───────┬───────────────┘
        │                  │                  │
┌───────▼──────────────────▼──────────────────▼───────────────┐
│                  Repository / Local Database                  │
│                 Drift (SQLite), file storage                  │
└──────────────────────────────┬───────────────────────────────┘
                               │
┌──────────────────────────────▼───────────────────────────────┐
│                Export: CSV, GeoJSON, JSON backup              │
└──────────────────────────────────────────────────────────────┘
```

### 9.2 Stack Teknologi

| Komponen | Teknologi | Alasan |
|---|---|---|
| Framework | Flutter stable 3.x, Dart 3.x | Satu codebase Android, ekosistem sensor lengkap |
| State management | `flutter_riverpod` | Testable, granular, cocok untuk stream sensor |
| Routing | `go_router` | Navigasi deklaratif |
| Database | `drift` + SQLite | Relasi data survey, query, migrasi |
| GNSS | `geolocator` | Lokasi, akurasi, permission |
| BLE | `bluetooth_low_energy` | Mendukung central dan peripheral/advertising |
| Barometer | `sensors_plus` | Stream tekanan hPa |
| Peta | `CustomPainter` + opsional `flutter_map` | Peta lokal offline sederhana; OSM opsional |
| Koordinat | Implementasi ECEF/ENU + `proj4dart` untuk UTM | Kontrol penuh atas matematika |
| Izin | `permission_handler` | Alur izin Android modern |
| QR (opsional) | `mobile_scanner`/`qr_flutter` | Pairing sesi, tidak wajib MVP |
| Testing | `flutter_test`, `mocktail` | Unit dan widget test |
| CI/CD | GitHub Actions | Build APK, auto-tag, release |

### 9.3 Prinsip Arsitektur

- **Local-first:** database lokal adalah sumber kebenaran; tidak ada server pada MVP.
- **Raw-first:** observasi mentah selalu disimpan sebelum dihitung.
- **Pure solver:** mesin posisi adalah Dart murni tanpa dependensi UI sehingga mudah diuji.
- **Interface-driven:** layanan GNSS/BLE/baro memiliki abstraksi agar dapat dimock.
- **Fail-soft:** jika barometer/BLE tidak tersedia, aplikasi tetap berjalan dengan quality flag lebih rendah.

### 9.4 Protokol BLE MVP

Setiap perangkat melakukan advertising dan scanning. Payload dirancang ringkas agar muat pada legacy advertising 31 byte.

| Field | Ukuran | Keterangan |
|---|---|---|
| Protocol version | 1 byte | Versi protokol |
| Device short ID | 1 byte | ID unik dalam sesi |
| Flags | 1 byte | Peran, baro tersedia, status valid |
| Latitude | 4 byte | int32, skala 1e-7 derajat |
| Longitude | 4 byte | int32, skala 1e-7 derajat |
| Ellipsoidal altitude | 3 byte | signed, satuan cm |
| Horizontal accuracy | 1 byte | satuan dm |
| Relative baro height | 2 byte | signed, satuan cm |
| Peer 1 ID + distance | 1 + 2 byte | jarak RSSI atau 0xFFFF jika tidak ada |
| Peer 2 ID + distance | 1 + 2 byte | jarak RSSI atau 0xFFFF jika tidak ada |
| **Total payload** | **23 byte** | Muat dalam manufacturer data legacy |

- Advertising interval: 200–500 ms saat capture.
- Scan mode: low-latency saat capture, balanced saat idle.
- Jika perangkat tidak mendukung advertising bersamaan dengan scanning, gunakan window bergantian atau fallback GATT.
- Detail lengkap protokol akan dituangkan dalam ICD terpisah sebelum implementasi BLE.

---

## 10. Model Data

| Entitas | Field Utama | Relasi |
|---|---|---|
| `projects` | id, name, description, origin_lat, origin_lon, origin_ellip_h, datum_mode, geoid_offset, benchmark_height, crs, created_at, updated_at | 1:N sessions |
| `sessions` | id, project_id, mode, code, master_device_id, started_at, ended_at, status | N:1 project, 1:N epochs |
| `devices` | id, session_id, short_id, role, name, android_version, has_barometer, rssi_at_1m, path_loss_n, last_seen_at | N:1 session |
| `epochs` | id, session_id, index, started_at, ended_at, status | N:1 session, 1:N observations |
| `gnss_observations` | id, epoch_id, device_id, lat, lon, ellip_h, accuracy_h, accuracy_v, satellites, sample_count, std_lat, std_lon, std_alt, created_at | N:1 epoch |
| `ble_measurements` | id, epoch_id, observer_device_id, peer_short_id, rssi_samples_json, rssi_filtered, distance_m, distance_sigma, created_at | N:1 epoch |
| `baro_observations` | id, epoch_id, device_id, pressure_hpa, relative_height_m, base_pressure_hpa, created_at | N:1 epoch |
| `anchors` | id, session_id, device_id, label, lat, lon, ellip_h, ortho_h, accuracy_h, accuracy_v, source, is_fixed, created_at | N:1 session |
| `survey_points` | id, project_id, session_id, epoch_id, code, layer, description, lat, lon, ortho_h, accuracy_h, accuracy_v, method, quality, status, pole_height, photo_path, created_at, updated_at | N:1 project/session/epoch |
| `diagnostic_logs` | id, session_id, device_id, category, message, payload_json, created_at | N:1 session |

Aturan data:

- Semua ID menggunakan UUID.
- Waktu menggunakan UTC dan ditampilkan dalam waktu lokal.
- Observasi mentah tidak boleh dihapus saat perhitungan ulang.
- Titik yang dihapus menggunakan soft delete agar dapat dipulihkan.

---

## 11. Algoritma & Perhitungan

### 11.1 Konversi Koordinat

1. WGS84 (lat, lon, ellipsoidal height) → ECEF.
2. ECEF → ENU relatif terhadap origin proyek.
3. Solver bekerja di bidang ENU (meter).
4. Hasil ENU → ECEF → WGS84 untuk penyimpanan/ekspor.
5. Untuk tampilan UTM, gunakan `proj4dart`.

### 11.2 GNSS Averaging

- Kumpulkan 60–120 sampel.
- Buang sampel dengan akurasi buruk atau di luar 2σ.
- Hitung rata-rata, standar deviasi, jumlah sampel, dan durasi.
- Tolak titik jika std dev horizontal > ambang atau sampel valid < 30.

### 11.3 RSSI ke Jarak

Kalibrasi perangkat pada jarak 1 m:

```
d = 10 ^ ((RSSI_1m - RSSI) / (10 * n))
```

- `RSSI_1m` diukur dari median 30–60 sampel.
- `n` default 2.0–2.7, dapat dikalibrasi.
- Filter: median + MAD, lalu exponential moving average/Kalman.
- Simpan jumlah sampel dan varians untuk bobot.

### 11.4 Trilaterasi WLS

Minimalkan:

```
Σ wi (||p - ai|| - di)^2 + wg ||p - g||^2
```

- `ai` = posisi anchor, `di` = jarak BLE, `g` = posisi GNSS rover.
- `wi = 1 / σi^2`, `wg = 1 / σg^2`.
- Selesaikan dengan Gauss-Newton/Levenberg-Marquardt.
- Inisialisasi dari GNSS atau centroid anchor.
- Minimal 3 anchor tidak segaris untuk solusi 2D.
- Hitung kovarians `(J^T W J)^-1` dan residual RMS.

### 11.5 Network Adjustment 3 Perangkat

- Unknown: posisi ENU ketiga perangkat pada satu epoch.
- Observasi:
  - GNSS prior tiap perangkat.
  - Jarak BLE pairwise (A-B, A-C, B-C).
  - Beda tinggi barometer opsional.
- Selesaikan joint WLS.
- Gunakan robust loss (Huber) untuk mengurangi pengaruh outlier RSSI.
- Jika satu perangkat dijadikan base dengan koordinat tetap, gauge tetap terdefinisi.

### 11.6 Ketinggian

```
h_rel = 44330 * (1 - (P / P_base)^(1/5.255))
```

- Tinggi titik = tinggi base + `h_rel` − tinggi tongkat.
- Base pressure dikalibrasi ulang berkala untuk mengurangi drift cuaca.
- GNSS altitude adalah ellipsoidal; koreksi geoid memakai offset lokal atau benchmark.
- Tanpa benchmark, hasil diberi label **local datum/relative**.

### 11.7 Quality Flag

| Flag | Kriteria Indikatif |
|---|---|
| Good | ≥ 4 anchor/jarak, residual RMS rendah, GDOP baik, GNSS stabil |
| Fair | 3 anchor, residual sedang, barometer fallback, GNSS cukup |
| Poor | < 3 anchor, geometri buruk, residual tinggi, GNSS tidak stabil |

Angka ambang final ditentukan saat kalibrasi lapangan dan didokumentasikan.

---

## 12. Rancangan UI

| Layar | Konten Utama | Aksi |
|---|---|---|
| Daftar Proyek | Nama, tanggal, jumlah titik | Buat, buka, hapus |
| Detail Proyek | Origin, datum, benchmark, daftar sesi | Mulai sesi, ekspor |
| Cek Sensor | GNSS, BLE, barometer, izin | Tes sensor, minta izin |
| Setup Sesi | Mode, peran, kode sesi, perangkat terdeteksi | Mulai sesi |
| Kalibrasi | RSSI@1m, path-loss, tinggi tongkat, base pressure | Simpan kalibrasi |
| Peta Survey | Plot ENU, grid, skala, utara, titik, anchor, legenda | Pilih titik, mulai capture |
| Capture Titik | Progress GNSS/RSSI/baro, kualitas, kode/layer/deskripsi | Simpan, batal |
| Daftar Titik | Kode, koordinat, tinggi, metode, kualitas | Edit, hapus, ekspor |
| Diagnostik | Log GNSS/BLE/baro, residual solver | Ekspor log |
| Pengaturan | Satuan, format koordinat, OSM on/off | Simpan |

Prinsip UI:

- Status kualitas selalu terlihat sebelum menyimpan titik.
- Warna: hijau (good), kuning (fair), merah (poor).
- Peringatan jelas jika mode tidak terpenuhi (misalnya HP < 3 pada mode Network).
- Tidak ada istilah teknis tanpa penjelasan singkat.

---

## 13. CI/CD & Release

### 13.1 Workflow

| Workflow | Trigger | Isi |
|---|---|---|
| `ci.yml` | Pull request | Format, analyze, test, build debug APK, artifact |
| `release.yml` | Push tag `v*` atau manual | Test, build signed APK universal + split-per-ABI, GitHub Release |
| `auto-tag.yml` | Push ke `main` | Baca versi `pubspec.yaml`, buat tag `vX.Y.Z` jika belum ada |

### 13.2 Langkah Release

1. Checkout repository.
2. Setup Java 17 dan Flutter stable.
3. `flutter pub get`.
4. `dart format --set-exit-if-changed .`
5. `flutter analyze`.
6. `flutter test`.
7. Validasi versi `pubspec.yaml` terhadap tag.
8. Decode keystore dari GitHub Secrets.
9. `flutter build apk --release` dan `--split-per-abi`.
10. Buat GitHub Release, unggah APK, dan generate release notes.

### 13.3 Secrets

| Secret | Fungsi |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | Keystore release dalam base64 |
| `KEYSTORE_PASSWORD` | Password keystore |
| `KEY_ALIAS` | Alias key |
| `KEY_PASSWORD` | Password key |

### 13.4 Versioning

- Format: `MAJOR.MINOR.PATCH+BUILD` pada `pubspec.yaml`.
- Tag Git: `vMAJOR.MINOR.PATCH`.
- Contoh: versi `1.0.0+1` → tag `v1.0.0`.
- Keystore dan password tidak boleh masuk repositori.

---

## 14. Rencana Pengujian

### 14.1 Unit Test

- Konversi WGS84 → ECEF → ENU → WGS84 (round-trip).
- Solver trilaterasi tanpa noise (hasil eksak).
- Solver dengan noise dan outlier.
- Network adjustment 3 perangkat.
- Model RSSI dan kalibrasi.
- Rumus barometer.
- Quality flag dan penolakan solusi buruk.

### 14.2 Integration/Widget Test

- Alur izin dan status sensor.
- Stream GNSS/BLE/baro palsu.
- Simulasi sesi 3 perangkat.
- Penyimpanan dan pemulihan proyek.
- Ekspor CSV/GeoJSON.

### 14.3 Uji Lapangan

Skenario 3 HP:

1. Siapkan tiga HP dengan aplikasi terpasang.
2. Bentuk segitiga anchor dengan pita ukur; catat jarak sebenarnya.
3. Lakukan 5–10 epoch/titik.
4. Bandingkan jarak BLE dengan jarak pita ukur.
5. Bandingkan posisi hasil fusi dengan GNSS mentah dan, jika ada, titik referensi.
6. Ulangi pengukuran 3 kali untuk repeatability.
7. Catat waktu per titik, baterai, dan kegagalan BLE.

Skenario 2 HP:

1. Siapkan tiga posisi anchor berjarak diketahui.
2. Pindahkan HP anchor ke tiap posisi.
3. Ukur satu titik target dengan rover.
4. Verifikasi hasil solver terhadap koordinat lokal yang diketahui.

### 14.4 Acceptance Criteria Demo

- [ ] APK terpasang di 3 HP Android fisik.
- [ ] Aplikasi berjalan offline tanpa server.
- [ ] Mode Network menghasilkan titik dengan quality flag.
- [ ] Mode Virtual Anchor 2 HP menghasilkan titik trilaterasi.
- [ ] Data mentah tersimpan dan dapat dihitung ulang.
- [ ] Ekspor CSV/GeoJSON dapat dibuka di Excel/QGIS.
- [ ] Aplikasi tidak kehilangan data saat ditutup paksa.
- [ ] Release APK dibuat otomatis oleh GitHub Actions.
- [ ] Dokumentasi SOP survey dan laporan kualitas tersedia.

---

## 15. Milestone & Timeline

| Milestone | Fokus | Deliverable | Estimasi |
|---|---|---|---|
| M0 | Fondasi | Scaffold Flutter, database, CI debug APK | 2 hari |
| M1 | Single-device | GNSS averaging, barometer, capture, peta lokal, ekspor | 3 hari |
| M2 | BLE ranging | Scan/advertise, kalibrasi, estimasi jarak | 3 hari |
| M3 | Trilaterasi | Solver WLS, mode virtual anchor 2 HP | 3 hari |
| M4 | Multi-device | Mode Network 3 HP, pertukaran observasi, quality | 3 hari |
| M5 | Validasi | Uji lapangan 3 HP, perbaikan, UI polish, dokumentasi | 3 hari |
| M6 | Release | Signing, auto-tag, release APK v1.0 | 1 hari |

Total estimasi: ±18 hari kerja. Buffer risiko 20%.

---

## 16. Risiko & Mitigasi

| Risiko | Dampak | Mitigasi |
|---|---|---|
| RSSI BLE berisik dan multipath | Akurasi rendah | Kalibrasi, median/Kalman, robust WLS, quality flag |
| Advertising dan scanning bersamaan tidak stabil | Perangkat tidak saling melihat | Uji perangkat, window bergantian, fallback GATT |
| Barometer tidak tersedia | Tinggi kurang akurat | Fallback GNSS altitude, label kualitas rendah |
| GNSS vertikal buruk | Tinggi absolut meleset | Barometer relatif, benchmark opsional, dokumentasi |
| Tidak ada benchmark | Datum tidak absolut | Mode datum lokal, input benchmark nanti |
| Sinkronisasi waktu antar-HP | Epoch tidak konsisten | Countdown, window sampling, data statis |
| Baterai/foreground restriction | Sesi terputus | Foreground service, wake lock, optimasi sampling |
| Kehilangan data saat crash | Data survey hilang | Simpan per sampel, transaksi database, backup JSON |
| Keystore bocor | APK tidak aman | Keystore hanya di GitHub Secrets |
| Scope melebar | Deadline terlewat | Kunci MVP; fitur C masuk backlog |

---

## 17. Asumsi & Ketergantungan

- Tersedia minimal 3 HP Android untuk demo; 1 HP tambahan dapat dipinjam.
- Android 8.0+ dengan dukungan BLE advertising/scanning.
- Minimal satu HP memiliki barometer; jika tidak, fallback GNSS.
- Area survey terbuka dengan pandangan langit yang cukup.
- Tersedia pita ukur untuk layout anchor dan tinggi tongkat.
- Tidak ada internet di lapangan; aplikasi inti harus tetap berjalan.
- GitHub Actions dan Git tersedia untuk repositori proyek.
- Flutter stable dan Android SDK tersedia di mesin pengembang.
- Tidak ada backend, akun, atau layanan pihak ketiga pada MVP.

---

## 18. Keputusan & Pertanyaan Terbuka

### 18.1 Keputusan yang Sudah Diambil

| Keputusan | Nilai |
|---|---|
| Backend | Tidak ada, offline-first |
| Jumlah HP target | 3 HP; fallback 2 HP; 1 HP hanya mode Single |
| Metode utama | GNSS + BLE RSSI + barometer + WLS |
| Map utama | Plot lokal offline; OSM opsional |
| Benchmark | Opsional; datum lokal untuk demo |
| Build | GitHub Actions, auto-tag, release APK |

### 18.2 Pertanyaan Terbuka

| Pertanyaan | Dampak | Rencana |
|---|---|---|
| Nama aplikasi final | Branding | Tetap `TopoSurvey` sampai ada keputusan |
| Model/versi Android 3 HP | Kompatibilitas BLE/baro | Dicatat saat uji perangkat |
| Ketersediaan barometer | Kualitas sumbu Z | Dicek lewat layar Cek Sensor |
| Ambang quality flag final | Validitas hasil | Ditentukan setelah uji lapangan |
| Apakah DXF/OSM masuk sebelum deadline | Scope | Masuk backlog, hanya jika waktu cukup |
| Format laporan hasil survey | Dokumentasi | CSV/GeoJSON + laporan PDF terpisah |

---

## 19. Glosarium

| Istilah | Definisi |
|---|---|
| GNSS | Global Navigation Satellite System (GPS, GLONASS, Galileo, dll.) |
| BLE | Bluetooth Low Energy |
| RSSI | Received Signal Strength Indicator |
| Trilaterasi | Penentuan posisi dari jarak ke tiga atau lebih titik known |
| Multilaterasi | Generalisasi trilaterasi dengan lebih dari tiga pengukuran dan solusi least-squares |
| WLS | Weighted Least Squares |
| ECEF | Earth-Centered, Earth-Fixed |
| ENU | East-North-Up, koordinat lokal |
| Geoid | Permukaan ekuipotensial yang mendekati mean sea level |
| Tinggi ellipsoidal | Tinggi terhadap ellipsoid referensi GNSS |
| Tinggi ortometrik | Tinggi terhadap geoid/mean sea level |
| Anchor | Titik referensi dengan koordinat diketahui |
| Virtual anchor | Posisi anchor yang diperoleh dengan memindahkan satu perangkat ke beberapa titik |
| Epoch | Satu jendela pengukuran serentak |
| Network adjustment | Penyesuaian bersama seluruh posisi dan observasi dalam satu jaringan |
| GDOP | Geometric Dilution of Precision |
| Quality flag | Status kualitas hasil: good/fair/poor |
| MVP | Minimum Viable Product |
| APK | Android Package Kit |

---

## 20. Persetujuan

| Peran | Nama | Tanggal | Status |
|---|---|---|---|
| Pemilik Produk | Tim Pengembang TopoSurvey | 2 November 2026 | Disetujui |
| Reviewer | Dosen Pengampu SIG | — | Menunggu |
| Pengembang | Tim Pengembang TopoSurvey | 2 November 2026 | Disetujui |

Dokumen ini menjadi acuan implementasi MVP. Perubahan lingkup harus dicatat sebagai revisi PRD dengan nomor versi baru.
