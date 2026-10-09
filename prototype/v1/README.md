# v1 — PKN Microlearning Web Prototype & Device Preview

Prototipe web interaktif aplikasi **PKN Healing Mobile App** yang dijalankan di browser dengan wrapper [`device_preview`](https://pub.dev/packages/device_preview). Memungkinkan evaluasi antarmuka, pengujian alur persona, dan iterasi cepat lintas perangkat (iPhone 13, iPad, Android) secara langsung tanpa emulator fisik.

Basis kode mobile kanonikal native tetap dipertahankan di [`prototype/v0/`](../v0/).

---

## Fitur yang Aktif di Prototipe v1

1. 🎯 **Alur Onboarding JTBD 4 Langkah**: Diagnostik amanah peran tarbiyah (Ayah, Ibu, Guru Karakter, Mudir, Santri, Mandiri) dengan komputasi arketipe otomatis.
2. 💡 **Kartu Wawasan Aktivasi (`ActivationalInsightScreen`)**: Rekomendasi pilar MOC awal pasca-diagnostik.
3. 📰 **Feed Penjelajahan Berbasis Kartu (*Deepstash Model*)**: Filter 6 Pilar MOC (`P1` s.d. `P6`), pencarian teks, dan bookmarking luring.
4. 📚 **Pemain Pelajaran Interaktif 5 Langkah (*Google Primer Model*)**: Dukungan `TextStepView`, `MultipleChoiceStepView`, `SwipePollStepView`, dan `FillInBlankStepView`.
5. 📊 **Laporan Pertumbuhan Adab Kualitatif (`AdabGrowthReportScreen`)**: Rubrik evaluasi adab non-gamifikasi (`BT - MT - BK - MM`).
6. 📱 **Mobile Device Preview Toolbar**:
   - Pemilihan bingkai perangkat (Apple iPhone 13 default, Android, Tablet).
   - Pengalihan orientasi (Portrait / Landscape).
   - Pratinjau tema (Dark Mode / Light Mode).
   - Simulasi keyboard virtual dan accessibility font scaling.
7. 💾 **Persistensi Luring**: Menggunakan `SharedPreferences` yang terpetakan otomatis ke browser `localStorage`.
8. 🔬 **Minimal Sandbox Demo**: Tersedia modul hello-world terisolasi di [`lib/demo/hello_world_app.dart`](lib/demo/hello_world_app.dart).

---

## Menjalankan Pratinjau Lokal

Dari root repositori:

```bash
cd prototype/v1
flutter pub get

# Jalankan server web lokal dengan Device Preview
flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8181
```

Akses antarmuka di: **`http://localhost:8181`**

> **Catatan:**
> - Di mesin lokal ini, biner SDK berada di `/home/abuhafi/flutter/bin/flutter`.
> - Untuk hot restart, tekan `r` pada terminal yang sedang menjalankan flutter.
> - Pada mode rilis (`kReleaseMode`), wrapper `DevicePreview` dinonaktifkan secara otomatis dan aplikasi merender layar penuh.

---

## Verifikasi Kualitas & Pengujian Otomatis

```bash
# 1. Analisis statis linter (target: 0 issues)
flutter analyze

# 2. Rangkaian uji otomatis (target: 13/13 passing)
flutter test
```

