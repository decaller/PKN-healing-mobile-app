# Analisis Kelayakan Flutter & Rekomendasi Ekstensi: Prototype v2 (Earth-Tree)

> **Dokumen Evaluasi Arsitektur & Desain**  
> **Target Layar:** `prototype/v2/design` (Home Screen Multi-Serial Carousel Light & Dark Mode)  
> **Design System:** Earth-Tree Specification (`prototype/v2/design/earth_tree/DESIGN.md`)  
> **Status Kelayakan di Flutter:** **100% Layak (Fully Feasible)** dengan penyesuaian arsitektural terukur.

---

## 1. Ringkasan Eksekutif

Desain pada `prototype/v2/design` menyajikan antarmuka beranda edukasi parenting Islami dengan estetika **Earth-Tree**:
* Palet warna membumi (sand-ecru, mineral basalt, batu kali, langit cerah *Celestial Sky*, dan hijau kanopi *Meadow Green*).
* Tipografi ganda bergaya editorial sastra: **Merriweather** (Serif) untuk Display/Heading dan **Plus Jakarta Sans** (Sans-serif) untuk fungsionalitas UI.
* 8 seksi utama dengan struktur berlapis: Header salam, Search Bar dinamis + tombol PTT Walkie-Talkie, 3 Carousel horizontal (*Highlights*, *Langkah Harian*, *Cerita Interaktif*), Bento Grid fitur, Grid 3-kolom instrumen praktis, tumpukan rekomendasi, serta dock navigasi mengambang berkaca (*frosted glass*).

**Kesimpulan:**  
Seluruh komponen visual dan interaksi ini **sangat dapat direalisasikan di Flutter**. Engine grafis Flutter (Impeller/Skia) memberi keunggulan mutlak dibanding browser web dalam mengontrol radius lekukan organik (*river-pebble roundness*), bayangan ambient yang sangat halus (*sedimentary elevation*), serta konsistensi tipografi lintas platform Android dan iOS.

---

## 2. Rekomendasi Ekstensi Flutter yang Dibutuhkan

Istilah *ekstensi Flutter* mencakup 3 aspek penting untuk implementasi v2 ini:
1. **Dart Packages / Plugins (Dependensi `pubspec.yaml`)**
2. **Flutter `ThemeExtension` & Dart Extensions (`BuildContext` Helpers)**
3. **IDE / VS Code Extensions (Alat Produktivitas Pengembang)**

---

### A. Rekomendasi Dart Packages & Plugins (`pubspec.yaml`)

Untuk mereplikasi interaksi HTML/CSS v2 ke Flutter secara optimal tanpa menulis ulang utilitas dari nol:

| Nama Paket | Versi Rekomendasi | Peran Spesifik dalam Desain v2 |
|---|---|---|
| **`forui`** | `^0.11.1` | **Fondasi Komponen UI.** Komponen UI utama (button, sheet, form field, badge, bottom bar). Sudah diadopsi di `prototype/v3` dengan tema Earth-Tree (`prototype/v3/lib/core/theme/earth_tree_forui.dart`). |
| **`iconoir_flutter`** | `^7.10.1` | **Standar Ikon Ekosistem Forui.** Ikon resmi pilihan dari ekosistem Forui (mendukung integrasi Forui Create). Menyediakan lebih dari 1.500 ikon vektor garis halus (*clean line-stroke*) yang sangat serasi dengan estetika tactile Earth-Tree. |
| **`carousel_slider`** / **`CarouselView`** | `^5.0.0` (atau bawaan Flutter 3.24+) | **Wajib.** Untuk 3 carousel horizontal (*Highlights*, *Aktivitas*, dan *Cerita Interaktif*). Memastikan perilaku *snap scrolling* terasa presisi di mobile tanpa lag gesture. |
| **`smooth_page_indicator`** | `^1.2.0` | **Wajib.** Di bawah carousel Cerita Interaktif terdapat indikator titik/kapsul (`w-5 h-1.5` aktif vs lingkaran kecil non-aktif). Paket ini menangani interpolasi animasi perpindahan halaman secara sangat mulus. |
| **`cached_network_image`** | `^3.4.1` | **Wajib.** Untuk banner rasio 16:9 pada *Highlights* dan avatar profil. Mencegah download ulang saat scroll, mendukung placeholder transisi halus dan cache luring. |
| **`flutter_animate`** | `^4.5.2` | **Sangat Dianjurkan.** Memberikan mikro-interaksi Earth-Tree: denyut status "Siap mendengar kapan saja", efek tekan mengecil (*scale 95%*) pada tombol Walkie-Talkie, dan transisi fade/slide teks ticker. |
| **`flutter_staggered_grid_view`** | `^0.7.0` | **Sangat Dianjurkan.** Membangun *Bento Grid Fitur Utama* (1 kartu penuh lebar di atas + 4 kartu bento 2-kolom di bawah) secara responsif dan bebas resiko overflow. |
| **`flutter_riverpod`** | `^2.6.1` | **Arsitektur State.** Mengelola siklus rotasi dynamic ticker pertanyaan, milestone status cerita interaktif (BT-MT-BK-MM), dan status perekaman suara PTT. |
| **`google_fonts`** | `^6.2.1` (atau aset lokal) | **Tipografi.** Memuat keluarga font `Merriweather` dan `Plus Jakarta Sans`. |

---

### B. Standar Ikon Ekosistem Forui: Iconoir (`iconoir_flutter`)

Desain v2 **Earth-Tree** mengusung filosofi *Organic Tactility* dan *Serene Editorial Modernism* (menyerupai batu kali halus, serat kertas alami, dan garis batas 1px yang tenang). Penggunaan **Iconoir** yang didukung secara native oleh ekosistem Forui memiliki keunggulan:
1. **Ketebalan Garis Konsisten (Stroke 1.5px/2px):** Memberikan tampilan tenang (*mindful*), tidak membebani mata (*low visual noise*), dan serasi dengan border tipis `1px solid rgba(118, 116, 109, 0.18)` milik Earth-Tree.
2. **Kesesuaian dengan Komponen Forui:** Komponen `FButton`, `FBadge`, dan `FHeader` dari pustaka Forui dapat menerima widget ikon secara langsung (`prefix: iconoir.Search(width: 18, height: 18)`).
3. **Penyelarasan Warna Otomatis:** Iconoir di Flutter dirender sebagai widget vektor SVG murni sehingga warna dapat langsung mengikat ke token tema (`color: context.earthTree.celestialSky`).

#### Tabel Pemetaan Simbol Prototipe v2 (HTML Material Symbols $\rightarrow$ Forui Iconoir)

| Simbol Prototipe Web | Konteks Penggunaan di Beranda v2 | Widget Pengganti di `iconoir_flutter` |
|---|---|---|
| `search` | Kolom pencarian utama | `iconoir.Search` |
| `graphic_eq` | Tombol PTT Curhat Cepat AI & Bento Sanctuary | `iconoir.SoundWave` / `iconoir.Voice` |
| `location_on` | Lokasi masjid/daurah pada Highlights | `iconoir.PinAlt` / `iconoir.MapPin` |
| `menu_book` / `auto_stories` | Khazanah Syakilah & Modul Wiki PKN | `iconoir.Book` / `iconoir.Page` |
| `videocam` | Sesi Webinar Interaktif | `iconoir.VideoCamera` |
| `mic` | Latihan Resonansi Suara Rendah (3 Mnt) | `iconoir.Mic` |
| `bedtime` | Muhasabah & Refleksi Pengasuhan | `iconoir.HalfMoon` |
| `sports_esports` | Kisah RPG Pintu Maghrib Zaid | `iconoir.Gamepad` |
| `sensors` / `psychology` | Badge AI Sanctuary & Tafsir Bakat 40 | `iconoir.Brain` / `iconoir.ElectronicsChip` |
| `bolt` | SOP P3K Tantrum 10 Detik | `iconoir.Flash` |
| `balance` | Kalkulator Mizan Fitrah | `iconoir.Scale` |
| `bar_chart` | Rapor Analisis Bakat TB-40 | `iconoir.GraphUp` / `iconoir.StatsReport` |
| `record_voice_over` | Deteksi Suara & Intonasi | `iconoir.Voice` |
| `front_hand` / `favorite` | Doa Penenang Hisnul Muslim | `iconoir.Heart` / `iconoir.HandBrake` |
| `explore` | Kamus Adab & Glosarium | `iconoir.Compass` |
| `home` | Tab Navigasi Beranda | `iconoir.Home` |
| `calendar_month` | Tab Navigasi Agenda & Acara | `iconoir.Calendar` |
| `lock` / `lock_clock` | Enkripsi On-Device Amanah | `iconoir.Lock` |
| `check_circle` | Milestone Selesai (Validasi Emosi) | `iconoir.CheckCircle` |
| `hourglass_top` | Milestone Berjalan (Dialog TB-40) | `iconoir.Hourglass` |
| `print` | Program Generator Siap Cetak | `iconoir.Printer` |


---

### C. Rekomendasi Flutter `ThemeExtension` & Dart Language Extensions

Untuk menghindari *hardcoded hex color* (seperti `rgb(54, 50, 48)` pada prototipe web) dan memastikan tema **Earth-Tree** berganti secara mulus antara Terang (*Sand/Meadow*) dan Gelap (*Basalt/Granite*):

#### 1. `ThemeExtension<EarthTreeColors>`
Memetakan token warna alami Earth-Tree ke context tema Flutter:

```dart
@immutable
class EarthTreeColors extends ThemeExtension<EarthTreeColors> {
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color celestialSky;
  final Color meadowCanopy;
  final Color ancientBark;
  final Color tactileBorder;

  const EarthTreeColors({
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.celestialSky,
    required this.meadowCanopy,
    required this.ancientBark,
    required this.tactileBorder,
  });

  @override
  EarthTreeColors copyWith({ ... }) => ...;

  @override
  EarthTreeColors lerp(ThemeExtension<EarthTreeColors>? other, double t) {
    if (other is! EarthTreeColors) return this;
    return EarthTreeColors(
      surfaceContainerLowest: Color.lerp(surfaceContainerLowest, other.surfaceContainerLowest, t)!,
      surfaceContainerLow: Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t)!,
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      surfaceContainerHigh: Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t)!,
      celestialSky: Color.lerp(celestialSky, other.celestialSky, t)!,
      meadowCanopy: Color.lerp(meadowCanopy, other.meadowCanopy, t)!,
      ancientBark: Color.lerp(ancientBark, other.ancientBark, t)!,
      tactileBorder: Color.lerp(tactileBorder, other.tactileBorder, t)!,
    );
  }
}
```

#### 2. `BuildContext` Syntactic Sugar Extensions
Mempermudah penulisan kode di seluruh widget:

```dart
extension EarthTreeContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  EarthTreeColors get earthTree => theme.extension<EarthTreeColors>()!;
  
  /// Helper responsif breakpoint mobile
  bool get isCompactMobile => MediaQuery.of(this).size.width < 380;
}
```

---

### D. Rekomendasi Ekstensi Editor / IDE (VS Code & Android Studio)

Untuk tim developer yang mengerjakan implementasi Flutter ini:

1. **Flutter & Dart Extension (`Dart-Code.flutter`)**: Toolchain resmi untuk Hot Reload, Hot Restart, DevTools Widget Inspector, dan profiling performa.
2. **Flutter Riverpod Snippets (`robert-brunhage.flutter-riverpod-snippets`)**: Mempercepat scaffolding Provider, ConsumerStatefulWidget, dan Notifier.
3. **Color Highlight (`naumovs.color-highlight`)**: Memvisualisasikan token warna Earth-Tree langsung di dalam editor kode.
4. **Error Lens (`usernamehw.errorlens`)**: Menampilkan lint error dan potensi overflow layout secara inline tanpa harus menunggu kompilasi.
5. **Pubspec Assist (`jeroen-meijer.pubspec-assist`)**: Mempermudah penambahan paket Flutter terbaru langsung dari command palette editor.

---

## 3. Keputusan Arsitektur: Zero-Material, Zero-Cupertino & Evaluasi `fluttersdk_wind`

### A. Penolakan Tema Material dan Cupertino (Zero-Material & Zero-Cupertino)
Proyek ini **secara tegas TIDAK MENGGUNAKAN tema bawaan Material Design maupun Cupertino (iOS)**:
* **Bukan Tema Material 3:** Tidak ada ripple effect agresif, tidak ada Floating Action Button (FAB) standar Google, tidak ada pewarnaan dinamis tonal M3 yang ungu/biru korporat, dan tidak ada surface tint default Android.
* **Bukan Tema Cupertino:** Tidak menggunakan widget kaku bergaya stock iOS (seperti segmented control default Apple atau font San Francisco) yang bertolak belakang dengan atmosfer hangat menenangkan *Earth-Tree*.
* **Solusi Tunggal: Forui (`forui: ^0.11.1`) Platform-Agnostic Engine:**  
  Seluruh antarmuka dibungkus menggunakan `FTheme` dari pustaka **Forui** (terinspirasi dari filosofi `shadcn/ui`), dengan token warna, tipografi, dan gaya yang 100% dipasok dari spesifikasi **Earth-Tree** (`earthTreeLight` & `earthTreeDark`). Tampilan menjadi netral platform (*unopinionated*), tenang, dan berkarakter khas di semua perangkat tanpa bias OS.

---

### B. Apakah Kita Membutuhkan `fluttersdk_wind`?

> **Kesimpulan:** **TIDAK DIBUTUHKAN (dan TIDAK DIREKOMENDASIKAN).**

Meskipun prototipe web v2 (`code.html`) dirancang menggunakan class utility Tailwind CSS, mengadopsi paket `fluttersdk_wind` ke dalam proyek Flutter ini **sangat tidak disarankan** karena 5 alasan teknis:

#### 1. Tumpang Tindih Paradigma (*Conflict of Paradigm*) dengan Forui
* Proyek ini sudah menetapkan **Forui** sebagai sistem komponen utamanya. Forui menggunakan paradigma **Component-Driven & Strongly-Typed Dart** (`FButton`, `FCard`, `FBadge`, `FTextField`).
* `fluttersdk_wind` menggunakan paradigma **Utility-First String-Based** (`WDiv(className: 'p-4 bg-white rounded-xl')`, `WButton`).
* Menggabungkan keduanya akan memecah arsitektur kode: developer akan bingung memilih antara komponen Forui atau widget Wind, merusak konsistensi basis kode.

#### 2. Hilangnya *Type Safety* dan *Compile-Time Autocomplete*
* Di Flutter murni dan Forui, compiler Dart memeriksa setiap token warna, padding, dan konfigurasi saat kompilasi (`context.earthTree.celestialSky`, `PknSpacing.md`). Jika ada salah ketik, compiler langsung memberi peringatan.
* Di `fluttersdk_wind`, styling ditulis dalam bentuk string mentah: `className: 'p-space-md bg-surface-cntainer'`. Kesalahan ketik (typo) **tidak dapat dideteksi oleh compiler**, melainkan baru ketahuan saat aplikasi dijalankan (*silent rendering failure* atau error runtime).

#### 3. *Runtime String Parsing Overhead* (Penurunan Performa Mobile)
* Flutter tidak memiliki CSS compiler bawaan seperti browser web. Setiap kali widget dengan `fluttersdk_wind` dirender, pustaka tersebut harus membedah string `className` (melakukan regex splitting, string tokenization, dan map lookup) untuk membangun pohon widget Flutter.
* Pada halaman beranda v2 yang sangat panjang (8 seksi, puluhan chip, dan 3 carousel horizontal), parsing string di runtime akan menambah alokasi memori dan beban CPU yang tidak perlu, berpotensi memicu *frame drop* (jank) saat di-scroll.

#### 4. Pemetaan Tailwind ke Flutter / Forui Sangat Sederhana Tanpa Pustaka Tambahan
* Translasi dari class Tailwind prototipe v2 ke Dart / Forui bersifat langsung (*direct mapping*):

| Tailwind Class di Prototipe v2 | Ekuivalen Native Flutter / Forui (Tanpa Wind) |
|---|---|
| `bg-surface-container` | `color: context.earthTree.surfaceContainer` |
| `rounded-xl` | `borderRadius: BorderRadius.circular(16)` (atau `PknRadius.xl`) |
| `p-space-md` | `padding: const EdgeInsets.all(16)` |
| `gap-space-sm` | `SizedBox(width: 12)` / `spacing: 12` |
| `flex flex-col justify-between` | `Column(mainAxisAlignment: MainAxisAlignment.spaceBetween)` |
| `aspect-[16/9]` | `AspectRatio(aspectRatio: 16 / 9)` |
| `line-clamp-2` | `maxLines: 2, overflow: TextOverflow.ellipsis` |
| `active:scale-95` | `FButton(tappableStyle: ...)` atau `GestureDetector` + `AnimatedScale` |

#### 5. Risiko Stabilitas & *Dependency Lock-in*
* `fluttersdk_wind` adalah paket pihak ketiga baru (maintainer `fluttersdk.com`) yang belum menjadi standar komunitas, berisiko ditinggalkan (*abandoned*) ketika Flutter merilis update SDK besar di masa mendatang.
* Sebaliknya, Forui memiliki ekosistem yang terstruktur rapi, berfokus murni pada arsitektur Flutter modern, dan didukung komunitas luas sebagai standar platform-agnostic UI.

---

## 4. Penyesuaian Arsitektural & UX yang Diperlukan (Adjustments Needed)

Membawa prototipe v2 langsung tanpa penyesuaian akan menimbulkan kendala teknis dan pengalaman pengguna. Berikut adalah daftar penyesuaian yang wajib dilakukan:

### 1. Penyesuaian Performa Rendering: Batasi `BackdropFilter`
* **Masalah:** Prototipe HTML menggunakan `backdrop-blur-xl` di header dan bottom navigation. Pada HP Android kelas menengah ke bawah, nesting `BackdropFilter` memicu *raster thread jank* (penurunan frame rate signifikan).
* **Penyesuaian Flutter:**
  * Batasi `BackdropFilter` hanya pada dock navigasi bawah.
  * Pada scroll body dan header, gunakan warna permukaan semi-transparan solid dengan alpha 92%–95% (`surface.withValues(alpha: 0.95)`).
  * Hindari menerapkan filter blur di dalam kartu scrollable list.

### 2. Penyesuaian Scrolling & Gestur Layar
* **Masalah:** Prototipe v2 menumpuk **3 carousel horizontal** di dalam satu halaman vertikal. Di perangkat mobile, sapuan horizontal kartu dapat bertabrakan dengan gestur kembali (*back swipe edge gesture*) bawaan iOS atau Android.
* **Penyesuaian Flutter:**
  * Berikan margin padding horizontal minimal 16 dp sebelum kartu carousel pertama agar gestur tepi layar OS tidak terganggu.
  * Gunakan `padEnds: false` pada `PageController` atau gunakan `CarouselView` bawaan Flutter.
  * Pasang `PageStorageKey` pada setiap carousel agar posisi gulir tidak ter-reset saat pengguna berpindah tab navigasi bawah.

### 3. Penyesuaian Aksesibilitas & Dynamic Font Scaling
* **Masalah:** Prototipe web menggunakan tinggi kartu statis (contoh: `min-h-[130px]`, `w-64`, `w-[310px]`). Jika pengguna Android/iOS mengaktifkan ukuran teks besar (1.3x–1.5x) di pengaturan sistem, kartu akan langsung melempar error kuning-hitam `RenderFlex overflowed`.
* **Penyesuaian Flutter:**
  * Hindari pembatasan tinggi kaku `Container(height: 130)`.
  * Gunakan `IntrinsicHeight` atau biarkan kartu menyesuaikan tinggi secara fleksibel sesuai isi.
  * Berikan `TextOverflow.ellipsis` dan `maxLines` yang terukur pada judul.
  * Bungkus micro-chips status milestone dalam `Wrap` alih-alih `Row` kaku.

### 4. Penyesuaian Siklus Hidup Timer (Memory Leak Prevention)
* **Masalah:** Ticker rotasi pertanyaan parenting di prototipe menggunakan `setInterval` global JavaScript.
* **Penyesuaian Flutter:**
  * Harus dibungkus dalam `ConsumerStatefulWidget` atau Riverpod `TimerNotifier`.
  * Timer **wajib** dibatalkan di metode `dispose()` agar tidak terus berjalan saat layar tidak aktif.
  * Gunakan `AnimatedSwitcher` dengan transisi fade & slide untuk efek pergantian teks yang menenangkan (*thuma'ninah*).

### 5. Penyesuaian Offline-First & Font Bundling (Kepatuhan Manhaj)
* **Masalah:** Prototipe HTML bergantung pada CDN online Google Fonts.
* **Penyesuaian Flutter:**
  * Berdasarkan prinsip *Amanah* dan *Zero Cloud Leak* di dokumentasi PKN, aplikasi harus dapat berjalan luring (misalnya saat orang tua di pesawat atau masjid tanpa sinyal).
  * Bundel berkas font `Merriweather` (.ttf) dan `Plus Jakarta Sans` (.ttf) secara lokal di `assets/fonts/` dalam `pubspec.yaml`, bukan mengandalkan download jaringan saat runtime.

---

### 6. Audit UX: Menekan Beban Kognitif (Anti-Slop & Zero-Fluff)

Mengacu pada pedoman `DESIGN_SYSTEM.md` (*"Rekayasa Kognitif Zero-Fluff: Menekan beban mental orang tua yang lelah setelah bekerja"*) dan `DESIGN_SKILLS_ANTI_SLOP.md`:

* **Gejala Duplikasi pada Prototipe v2:**
  Halaman beranda v2 memiliki tinggi gulir lebih dari 3.200 dp dengan 8 seksi vertikal. Terdapat duplikasi jalan masuk (*entry point*) yang berlebihan:
  1. **AI Curhat:** Muncul di Search Bar (tombol PTT), Bento Grid #1, Rekomendasi #1, dan Tab Navigasi Bawah #3.
  2. **Wiki PKN:** Muncul di Bento Grid #2, Rekomendasi #4, dan Tab Navigasi Bawah #4.
  3. **Agenda Acara:** Muncul di Highlights #1, Bento Grid #3, Rekomendasi #2, dan Tab Navigasi Bawah #2.
  4. **Cerita Interaktif:** Muncul di Aktivitas #4, Bento Grid #4, dan Carousel #6.
  5. **Tools P3K:** Muncul di Bento Grid #5, Grid Instrumen #7, dan Rekomendasi #3.

* **Rekomendasi Perampingan Struktur Beranda untuk Flutter:**
  1. **Hapus Seksi Rekomendasi (Promo Stack) di Bawah:** Seksi ini 100% menduplikasi fitur yang sudah dipromosikan di atasnya.
  2. **Posisikan P3K Tantrum Lebih Strategis:** Sebagai instrumen darurat 10 detik, letakkan P3K di bagian atas (bisa di bawah Search Bar) agar orang tua yang menghadapi anak tantrum tidak perlu menggulir ke seksi 7.
  3. **Penyatuan Bento Grid & Instrumen:** Jadikan Bento Grid sebagai ringkasan progres aktif, bukan sekadar peluncur menu duplikat.
  4. **Target Sentuh Micro-Chips:** Jadikan status chip milestone pada kartu Cerita Interaktif (`Validasi Emosi` ✓, `Kontak Mata` ✓, `Dialog TB-40` ⏳) sebagai **indikator visual pasif** (*read-only*), sementara tombol utama `Lanjutkan Episode` tetap menjadi target sentuh primer dengan tinggi minimal 48 dp.

---

## 5. Contoh Pola Implementasi Widget Kunci

### A. Dynamic Search Bar & Walkie-Talkie Button (Forui + Iconoir)
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class SearchTickerBar extends ConsumerStatefulWidget {
  const SearchTickerBar({super.key});

  @override
  ConsumerState<SearchTickerBar> createState() => _SearchTickerBarState();
}

class _SearchTickerBarState extends ConsumerState<SearchTickerBar> {
  static const _questions = [
    "Bagaimana merespon anak tantrum saat maghrib?",
    "Cara menumbuhkan fitrah kepemimpinan anak?",
    "SOP mengatasi anak mogok shalat berjamaah?",
    "Menangani kecemasan ibu saat balita menolak makan?",
    "Kapan saat tepat memulai dialog fitrah seksualitas?",
  ];

  int _currentIndex = 0;
  Timer? _tickerTimer;

  @override
  void initState() {
    super.initState();
    _tickerTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) {
        setState(() => _currentIndex = (_currentIndex + 1) % _questions.length);
      }
    });
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.tactileBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A2C2825),
            offset: Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        children: [
          // Ikon Search dari Iconoir (ekosistem Forui)
          iconoir.Search(
            width: 20,
            height: 20,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                _questions[_currentIndex],
                key: ValueKey<int>(_currentIndex),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Tombol PTT Curhat Cepat dengan Iconoir SoundWave
          Material(
            color: colors.celestialSky,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                HapticFeedback.mediumImpact();
                _showVoiceCurhatBottomSheet(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const iconoir.SoundWave(
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                    if (!context.isCompactMobile) ...[
                      const SizedBox(width: 6),
                      Text(
                        "Curhat Cepat",
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showVoiceCurhatBottomSheet(BuildContext context) {
    // Menampilkan bottom sheet dialog suara AI Sanctuary
  }
}
```

---

## 6. Ringkasan Tindak Lanjut (Next Steps)

1. **Konfigurasi Dependensi:** Tambahkan `forui`, `iconoir_flutter`, `carousel_slider` (atau siapkan `CarouselView`), `smooth_page_indicator`, dan `flutter_animate` ke proyek target.
2. **Setup Token Tema:** Lengkapi `ThemeExtension<EarthTreeColors>` dan `AppTypography` dengan font lokal `Merriweather` dan `Plus Jakarta Sans`.
3. **Penyusunan Komponen:** Bangun widget modular di folder fitur:
   * `search_ticker_bar.dart` (menggunakan `iconoir.Search` dan `iconoir.SoundWave`)
   * `highlights_carousel.dart` (menggunakan `iconoir.PinAlt` dan `iconoir.Book`)
   * `multi_serial_story_card.dart` (menggunakan `iconoir.CheckCircle`, `iconoir.Hourglass`, `iconoir.Lock`)
   * `p3k_quick_action_grid.dart` (menggunakan `iconoir.Flash`, `iconoir.Scale`, `iconoir.GraphUp`, `iconoir.Voice`, `iconoir.Heart`, `iconoir.Compass`)
4. **Perampingan Beranda:** Satukan ke dalam `HomeScreen` (`CustomScrollView`) dengan menghilangkan redundansi kartu promosi bawah agar tujuan *Zero-Fluff* tercapai.

