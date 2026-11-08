# Roadmap Pengerjaan TopoSurvey

Dokumen ini adalah rencana eksekusi teknis untuk mewujudkan [PRD](./PRD.md) menjadi aplikasi Android yang berfungsi, dapat didemokan dengan 2–3 HP, dan dirilis sebagai APK melalui GitHub Actions.

| Field | Keterangan |
|---|---|
| Produk | TopoSurvey |
| Versi Roadmap | 1.0 |
| Tanggal | 2 November 2026 |
| Durasi | 20 hari kerja (4 minggu) + buffer |
| Model Pengerjaan | Solo developer, full-time setara 6–8 jam/hari |
| Status | Disetujui untuk eksekusi |

---

## 1. Tujuan Roadmap

1. Menghasilkan MVP yang benar-benar membaca sensor asli, menghitung, menyimpan, dan mengekspor data.
2. Menyelesaikan jalur demo utama 3 HP (network adjustment) dan jalur cadangan 2 HP (virtual anchor).
3. Menjaga aplikasi tetap offline-first tanpa backend.
4. Menghasilkan APK release otomatis melalui GitHub Actions.
5. Menyediakan bukti validasi lapangan dan dokumentasi yang cukup untuk demo tugas.

## 2. Asumsi & Batasan

- Tersedia 3 HP Android untuk demo; 1 HP tambahan dapat dipinjam.
- Pengembangan awal dapat dilakukan dengan 2 HP; HP ketiga dipakai paling lambat sebelum milestone M4.
- Minimal satu HP memiliki barometer; jika tidak, tinggi memakai fallback GNSS.
- Area uji tersedia (kampus/halaman) dan tidak bergantung pada internet.
- Tersedia pita ukur, tongkat/penyangga HP, dan lokasi anchor yang cukup lapang.
- GitHub Actions aktif dan keystore release dapat dibuat.
- Fitur opsional (OSM, foto titik, DXF) hanya dikerjakan jika core selesai lebih cepat.
- Jika dikerjakan part-time, kalikan estimasi hari dengan 1,5–2.

---

## 3. Ringkasan Timeline

| Minggu | Hari | Milestone | Fokus | Hasil Utama |
|---|---|---|---|---|
| 1 | 1–2 | M0 | Fondasi & CI | Repo siap, APK debug dari Actions, sensor spike |
| 1 | 3–5 | M1 | Single-device | GNSS + barometer + capture + ekspor |
| 2 | 6–8 | M2 | BLE ranging | Scan/advertise, kalibrasi, estimasi jarak |
| 2 | 9–11 | M3 | Solver & virtual anchor | Trilaterasi 2 HP berfungsi |
| 3 | 12–14 | M4 | Network 3 HP | Sesi 3 HP dan network adjustment |
| 3 | 15–17 | M5 | Validasi lapangan | Uji 3 HP, perbaikan, dokumentasi |
| 4 | 18–19 | M6 | Release | APK signed, auto-tag, release |
| 4 | 20 | Buffer | Demo & cadangan | Dry run, video backup, finalisasi |

```text
Hari kerja    1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
M0 Fondasi    █  █
M1 Single        █  █  █
M2 BLE                  █  █  █
M3 Solver                      █  █  █
M4 Network                             █  █  █
M5 Validasi                                   █  █  █
M6 Release                                            █  █
Buffer                                                      █
```

---

## 4. Detail Pekerjaan

### M0 — Fondasi & CI (Hari 1–2)

**Tujuan:** memastikan fondasi proyek, build APK, dan asumsi perangkat tervalidasi sebelum fitur besar dikerjakan.

**Tugas:**

- [ ] M0-01 Inisialisasi repo Git dan proyek Flutter, `minSdk 26`, package name final.
- [ ] M0-02 Susun struktur folder: `core`, `data`, `domain`, `features`, `services`.
- [ ] M0-03 Pasang Riverpod, go_router, Drift awal, tema, dan halaman kosong.
- [ ] M0-04 Buat skema database awal: projects, sessions, devices, epochs, observations, points.
- [ ] M0-05 Buat `ci.yml`: format, analyze, test, build debug APK, upload artifact.
- [ ] M0-06 Buat `release.yml` dan `auto-tag.yml`; siapkan keystore + GitHub Secrets.
- [ ] M0-07 **Sensor spike di 3 HP:** cek GNSS, barometer, BLE scan, dan BLE advertise.
- [ ] M0-08 Catat hasil perangkat di `docs/DEVICES.md`: model, Android, barometer, advertising.
- [ ] M0-09 Buat README awal, konvensi branch, dan template issue/PR.

**Output:** repo siap, APK debug terunduh dari Actions, daftar kemampuan 3 HP.

**Definition of Done:**
- CI hijau dan artifact APK tersedia.
- Minimal satu HP berhasil advertise dan satu HP berhasil scan saat spike.
- Status barometer tiap HP diketahui.
- Keystore release tersimpan sebagai secret, tidak masuk repo.

---

### M1 — Single-Device Survey (Hari 3–5)

**Tujuan:** aplikasi dapat mengambil data nyata dan mengekspornya tanpa BLE.

**Tugas:**

- [ ] M1-01 Alur izin lokasi, notifikasi, dan foreground service.
- [ ] M1-02 Implementasi GNSS service: live fix, accuracy, satellites, timestamp.
- [ ] M1-03 Implementasi GNSS averaging: 60–120 sampel, outlier rejection, std dev.
- [ ] M1-04 Implementasi barometer: stream tekanan, cek ketersediaan, fallback GNSS.
- [ ] M1-05 Kalibrasi base pressure dan input tinggi tongkat.
- [ ] M1-06 Repository proyek/sesi + penyimpanan observasi mentah.
- [ ] M1-07 UI capture titik: progress, kualitas, kode, layer, deskripsi.
- [ ] M1-08 Peta lokal offline: grid ENU, skala, arah utara, marker titik.
- [ ] M1-09 Daftar titik dan detail titik.
- [ ] M1-10 Ekspor CSV dan GeoJSON + share sheet.
- [ ] M1-11 Unit test konversi geodesi dan perhitungan rata-rata.
- [ ] M1-12 Uji di 1 HP fisik dengan data asli.

**Output:** APK yang bisa mencatat dan mengekspor titik GNSS/barometer.

**Definition of Done:**
- Titik tersimpan setelah aplikasi ditutup dan dibuka kembali.
- CSV/GeoJSON valid dan dapat dibuka di Excel/QGIS.
- Barometer terbaca atau fallback ditandai jelas.
- Tidak ada data dummy pada alur utama.

---

### M2 — BLE Ranging & Kalibrasi (Hari 6–8)

**Tujuan:** dua HP dapat saling menemukan dan mengukur jarak secara terkontrol.

**Tugas:**

- [ ] M2-01 Implementasi advertising: service UUID, device short ID, payload awal.
- [ ] M2-02 Implementasi scanner: discovery, RSSI stream, filter duplikat.
- [ ] M2-03 Sampling RSSI 20–60 detik, simpan sampel mentah.
- [ ] M2-04 Filter median/MAD + exponential moving average/Kalman.
- [ ] M2-05 Wizard kalibrasi RSSI@1m dan path-loss exponent.
- [ ] M2-06 Estimasi jarak + estimasi error.
- [ ] M2-07 UI daftar perangkat: nama, peran, RSSI, jarak, status.
- [ ] M2-08 Uji jarak 1 m, 5 m, dan 10 m dengan pita ukur.
- [ ] M2-09 Uji advertising + scanning bersamaan di tiap HP.
- [ ] M2-10 Siapkan fallback GATT/window bergantian jika diperlukan.

**Output:** dua HP saling terdeteksi dan jarak BLE tercatat.

**Definition of Done:**
- Perangkat terdeteksi dalam ≤ 10 detik pada kondisi normal.
- Jarak 1 m/5 m/10 m dapat diukur dan selisihnya terdokumentasi.
- Parameter kalibrasi tersimpan per perangkat.
- Ada jalur fallback yang jelas jika advertising tidak stabil.

---

### M3 — Solver Trilaterasi & Virtual Anchor (Hari 9–11)

**Tujuan:** mode 2 HP benar-benar menghasilkan titik trilaterasi.

**Tugas:**

- [ ] M3-01 Implementasi WGS84 ↔ ECEF ↔ ENU dan round-trip test.
- [ ] M3-02 Implementasi WLS trilaterasi dengan Gauss-Newton/Levenberg-Marquardt.
- [ ] M3-03 Inisialisasi solver dari GNSS/centroid dan penanganan divergensi.
- [ ] M3-04 Robust loss (Huber) dan penolakan outlier jarak.
- [ ] M3-05 Hitung residual RMS, kovarians, dan quality flag.
- [ ] M3-06 UI input anchor manual/koordinat lokal yang diketahui.
- [ ] M3-07 Alur virtual anchor: rover diam, anchor pindah 3 posisi.
- [ ] M3-08 UI hasil: posisi, residual, geometri, kualitas, simpan titik.
- [ ] M3-09 Unit test solver: tanpa noise, dengan noise, outlier, geometri buruk.
- [ ] M3-10 Uji lapangan 2 HP dengan layout segitiga yang diukur pita ukur.

**Output:** demo 2 HP yang menghasilkan titik dari tiga jarak.

**Definition of Done:**
- Solver menghasilkan posisi pada data sintetis dan data lapangan.
- Hasil menampilkan residual dan quality flag.
- Titik dapat disimpan dan diekspor.
- Hasil 2 HP dapat dijelaskan sebagai fallback resmi demo.

---

### M4 — Network Mode 3 HP (Hari 12–14)

**Tujuan:** tiga HP bekerja dalam satu sesi, saling bertukar observasi, dan menghasilkan posisi teradjust.

**Tugas:**

- [ ] M4-01 Finalisasi payload BLE 23 byte: encoder, decoder, validasi versi.
- [ ] M4-02 Orkestrasi epoch: countdown, start/stop, window sampling.
- [ ] M4-03 Pertukaran observasi GNSS, baro, dan jarak antar-HP.
- [ ] M4-04 Penanganan perangkat hilang/terputus sementara.
- [ ] M4-05 Implementasi network adjustment 3 perangkat.
- [ ] M4-06 Tampilkan status tiap perangkat dan kelengkapan observasi.
- [ ] M4-07 Simpan hasil per epoch dan cegah duplikasi.
- [ ] M4-08 Uji integrasi 3 HP: minimal 5 epoch.
- [ ] M4-09 Uji skenario jatuh tempo: 1 HP keluar saat sampling.
- [ ] M4-10 Dokumentasikan batasan mode 3 HP.

**Output:** sesi network 3 HP yang berfungsi dan menghasilkan titik.

**Definition of Done:**
- Ketiga HP menyelesaikan satu epoch dan bertukar observasi.
- Network adjustment menghasilkan tiga posisi dengan quality flag.
- Tidak ada data loss saat satu HP keluar sementara.
- Hasil dapat diekspor dan dihitung ulang.

---

### M5 — Validasi Lapangan & Polish (Hari 15–17)

**Tujuan:** membuktikan aplikasi bekerja di lapangan dan memperbaiki masalah yang ditemukan.

**Tugas:**

- [ ] M5-01 Susun protokol uji lapangan dan formulir pencatatan.
- [ ] M5-02 Uji 3 HP di area terbuka: minimal 10 titik/epoch.
- [ ] M5-03 Catat jarak BLE vs pita ukur, residual, waktu per titik, baterai.
- [ ] M5-04 Uji repeatability: ulangi 3 kali pada titik yang sama.
- [ ] M5-05 Bandingkan hasil fusi dengan GNSS mentah; jika ada referensi, bandingkan juga.
- [ ] M5-06 Perbaiki bug kritis dan error handling.
- [ ] M5-07 Polish UI: status kualitas, peringatan, empty state, loading.
- [ ] M5-08 Validasi CSV/GeoJSON di QGIS dan Excel.
- [ ] M5-09 Tulis SOP survey dan laporan kualitas/akurasi.
- [ ] M5-10 Siapkan daftar known issues dan batasan.
- [ ] M5-11 Uji aplikasi minimal 30 menit tanpa crash.

**Output:** laporan uji lapangan, aplikasi stabil, dokumentasi survei.

**Definition of Done:**
- Acceptance criteria demo terpenuhi.
- Ada angka akurasi/repeatability yang jujur, bukan klaim tanpa data.
- Known issues terdokumentasi.
- SOP dapat diikuti orang lain tanpa penjelasan tambahan.

---

### M6 — Release & Persiapan Demo (Hari 18–19)

**Tujuan:** merilis APK final dan memastikan demo berjalan mulus.

**Tugas:**

- [ ] M6-01 Naikkan versi ke `1.0.0+1`.
- [ ] M6-02 Pastikan signing release dan secrets benar.
- [ ] M6-03 Jalankan `release.yml`; verifikasi APK universal dan split-per-ABI.
- [ ] M6-04 Verifikasi auto-tag membuat tag `v1.0.0`.
- [ ] M6-05 Tulis release notes dan update README.
- [ ] M6-06 Pasang APK dari GitHub Release di ketiga HP.
- [ ] M6-07 Susun skrip demo 10–15 menit.
- [ ] M6-08 Rekam video backup demo.
- [ ] M6-09 Siapkan APK cadangan di perangkat lokal.
- [ ] M6-10 Dry run demo penuh dengan 3 HP.

**Output:** APK release, dokumentasi, skrip demo, video backup.

**Definition of Done:**
- APK release terpasang dan berjalan di 3 HP.
- APK dapat diunduh dari GitHub Release.
- Auto-tag dan release berjalan dari push ke `main`/tag.
- Dry run demo selesai tanpa hambatan kritis.

---

## 5. Critical Path

Urutan yang tidak boleh dilompati:

```text
M0 Fondasi
   ↓
M1 GNSS + penyimpanan + ekspor
   ↓
M2 BLE ranging + kalibrasi
   ↓
M3 Solver + virtual anchor
   ↓
M4 Network 3 HP
   ↓
M5 Validasi lapangan
   ↓
M6 Release + demo
```

Aturan:

- M2 tidak boleh dimulai sebelum penyimpanan observasi M1 stabil.
- M4 tidak boleh dimulai sebelum solver M3 lulus unit test.
- HP ketiga harus tersedia paling lambat Hari 12.
- Keystore dan secrets harus siap paling lambat Hari 5.
- Lokasi uji lapangan harus dikonfirmasi paling lambat Hari 10.
- Fitur opsional tidak boleh menggeser critical path.

---

## 6. Quality Gates

| Gate | Hari | Kriteria Lulus | Jika Gagal |
|---|---|---|---|
| G0 Fondasi | 2 | CI APK + sensor spike 3 HP | Perbaiki setup/CI sebelum lanjut |
| G1 Single | 5 | Capture + ekspor data asli | Tunda BLE, stabilkan penyimpanan |
| G2 BLE | 8 | Jarak 1/5/10 m terukur | Fallback GATT/window; dokumentasikan |
| G3 Solver | 11 | Trilaterasi 2 HP berhasil | Perbaiki solver sebelum network |
| G4 Network | 14 | Sesi 3 HP + adjustment | Demo 2 HP; network masuk known issue |
| G5 Lapangan | 17 | Uji 10 titik + laporan | Perbaiki bug kritis; kurangi fitur opsional |
| G6 Release | 19 | APK signed + release | Rilis debug terbatas + video backup |

---

## 7. Dependensi & Kebutuhan

| Kebutuhan | Dibutuhkan Pada | Status |
|---|---|---|
| 3 HP Android (minimal Android 8) | M4, Hari 12 | Tersedia 2, 1 dipinjam |
| HP dengan barometer | M1, Hari 3 | Dicek saat M0-07 |
| Dukungan BLE advertising | M2, Hari 6 | Dicek saat M0-07 |
| Pita ukur 10–30 m | M2/M3 | Perlu disiapkan |
| Tongkat/penyangga HP | M1/M5 | Perlu disiapkan |
| Lokasi uji lapangan | M5, Hari 15 | Perlu dikonfirmasi |
| Repo GitHub + Actions | M0, Hari 1 | Perlu disiapkan |
| Keystore release | M0, Hari 2 | Perlu dibuat |
| Flutter SDK + Android SDK | M0 | Tersedia |
| Waktu fokus 6–8 jam/hari | Sepanjang proyek | Asumsi |

---

## 8. Rencana Fallback

| Risiko | Trigger | Fallback |
|---|---|---|
| BLE advertising bersamaan tidak stabil | Gagal di M2 Hari 7 | Window scan/advertise bergantian, GATT, atau satu HP jadi advertiser |
| Barometer tidak tersedia | M0-07 | GNSS altitude, quality flag rendah, dokumentasikan |
| HP ketiga tidak bisa dipinjam | Hari 12 | Demo resmi 2 HP virtual anchor; network diuji dengan simulasi/log |
| Network adjustment tidak stabil | G4 Hari 14 | Kunci mode 2 HP; network jadi pengembangan lanjutan |
| Akurasi lapangan buruk | M5 | Laporkan RMSE apa adanya; tekankan fungsi dan metode |
| Waktu melewati buffer | Hari 17 | Potong OSM/foto/DXF; jangan potong offline, ekspor, release |
| APK release gagal | M6 | Rilis APK debug + dokumentasi; perbaiki signing setelahnya |

---

## 9. Strategi Tracking

- Gunakan GitHub Issues dengan label `M0`–`M6`, `bug`, `docs`, `blocked`.
- Gunakan GitHub Projects: Backlog → In Progress → Blocked → Review → Done.
- Satu branch per milestone: `feat/m1-single-device`, `feat/m2-ble`, dan seterusnya.
- Commit kecil dan sering; PR ke `main` setelah quality gate lulus.
- Tag hanya pada rilis yang sudah lolos G6.
- Catat hasil uji lapangan di `docs/FIELD-TEST.md` (dibuat saat M5).
- Catat kemampuan perangkat di `docs/DEVICES.md` (dibuat saat M0).

---

## 10. Rencana Demo

**Durasi:** 10–15 menit.

1. Perkenalkan masalah: GNSS HP ±10 m, satu HP tidak cukup untuk trilaterasi.
2. Tunjukkan 3 HP dan layar Cek Sensor (GNSS, BLE, barometer).
3. Demo utama: 3 HP di tiga titik, jalankan epoch, tunjukkan pertukaran BLE, hasil network adjustment, dan quality flag.
4. Demo cadangan: 2 HP virtual anchor dengan tiga posisi berjarak diketahui.
5. Tunjukkan peta lokal, daftar titik, dan ekspor CSV/GeoJSON.
6. Buka hasil di QGIS/Excel.
7. Tunjukkan GitHub Actions dan GitHub Release APK.
8. Sampaikan batasan: akurasi bukan RTK, datum lokal jika tanpa benchmark, dan peran BLE sebagai penguat geometri relatif.

**Checklist sebelum demo:**
- [ ] Ketiga HP terisi daya > 60%.
- [ ] APK release terpasang di semua HP.
- [ ] Izin lokasi dan BLE sudah diberikan.
- [ ] Barometer/fallback sudah diketahui.
- [ ] Layout anchor dan pita ukur siap.
- [ ] Lokasi demo sudah diuji dan cukup lapang.
- [ ] Video backup tersedia.
- [ ] APK cadangan tersedia offline.
- [ ] Internet hanya disiapkan untuk menampilkan GitHub, bukan kebutuhan aplikasi.

---

## 11. Definisi Selesai Keseluruhan

Proyek dinyatakan selesai jika:

- [ ] Aplikasi berjalan offline di 3 HP Android fisik.
- [ ] Mode Network 3 HP menghasilkan titik dengan quality flag.
- [ ] Mode Virtual Anchor 2 HP menghasilkan titik trilaterasi.
- [ ] Data mentah tersimpan, dapat dihitung ulang, dan diekspor.
- [ ] CSV/GeoJSON valid di Excel/QGIS.
- [ ] APK release signed tersedia di GitHub Releases.
- [ ] Auto-tag dan release berjalan dari GitHub Actions.
- [ ] Dokumentasi tersedia: README, PRD, roadmap, SOP survey, laporan uji.
- [ ] Demo dry run berhasil dan video backup tersedia.
