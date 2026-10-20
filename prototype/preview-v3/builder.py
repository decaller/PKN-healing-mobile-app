#!/usr/bin/env python3
import json
import re

html_path = "prototype/preview-v3/index.html"

with open(html_path, "r", encoding="utf-8") as f:
    content = f.read()

# 1. Update Title
content = content.replace(
    "<title>PKN Mobile v2 — Interactive Design Preview</title>",
    "<title>PKN Mobile v3 — Edisi Tips Praktis & P3K Krisis 3 Menit</title>"
)

# 2. Replace Action Card 2 (Curhat AI) with "Tips Praktis 3 Menit"
old_card_2 = """            <!-- Action Card 2: Ruang Qalbu (Curhat AI) -->
            <div onclick="openCurhatModal()" class="cursor-pointer p-3.5 rounded-2xl bg-gradient-to-br from-pine-600 to-pine-700 text-white shadow-md active:scale-98 transition flex flex-col justify-between h-[108px] relative overflow-hidden group">
              <div class="flex justify-between items-start">
                <span class="material-symbols-outlined text-[24px]">spa</span>
                <span class="text-[10px] font-bold uppercase tracking-wider bg-white/20 px-2 py-0.5 rounded-full backdrop-blur-sm">Ruang Qalbu</span>
              </div>
              <div>
                <h3 class="text-sm font-bold leading-tight">Curhat Batin AI</h3>
                <p class="text-[11px] text-white/80 line-clamp-1 mt-0.5">Bicara tanpa dihakimi</p>
              </div>
              <span class="material-symbols-outlined absolute -right-2 -bottom-2 text-white/10 text-[64px] pointer-events-none group-hover:scale-110 transition">graphic_eq</span>
            </div>"""

new_card_2 = """            <!-- Action Card 2: Tips Praktis Harian (Solusi 3 Menit & Script Siap Pakai) -->
            <div onclick="openTipsModal()" class="cursor-pointer p-3.5 rounded-2xl bg-gradient-to-br from-pine-700 via-pine-600 to-emerald-700 text-white shadow-md active:scale-98 transition flex flex-col justify-between h-[108px] relative overflow-hidden group border border-pine-500/30">
              <div class="flex justify-between items-start">
                <span class="material-symbols-outlined text-[24px]">quick_reference</span>
                <span class="text-[10px] font-bold uppercase tracking-wider bg-white/20 px-2 py-0.5 rounded-full backdrop-blur-sm">7 Kluster • 9 Solusi</span>
              </div>
              <div>
                <h3 class="text-sm font-bold leading-tight">Tips Praktis 3 Menit</h3>
                <p class="text-[11px] text-white/85 line-clamp-1 mt-0.5">SOP &amp; Script Kalimat Siap Pakai</p>
              </div>
              <span class="material-symbols-outlined absolute -right-2 -bottom-2 text-white/10 text-[64px] pointer-events-none group-hover:scale-110 transition">menu_book</span>
            </div>"""

if old_card_2 in content:
    content = content.replace(old_card_2, new_card_2)
    print("✓ Replaced Action Card 2 on homescreen with Tips Praktis 3 Menit!")
else:
    card_regex = r'<!-- Action Card 2: Ruang Qalbu \(Curhat AI\) -->[\s\S]*?<\/div>\s*<\/div>'
    content = re.sub(card_regex, new_card_2, content, count=1)
    print("✓ Replaced Card 2 via regex!")

# 3. Upgrade P3K Krisis: Add Safety Guardrail Banner & 3-Role Triage Switcher
old_p3k_triage = """          <!-- Dual Triage Switcher: Siapa yang sedang genting? -->
          <div class="space-y-1.5">
            <div class="flex justify-between items-center text-[10px] font-bold text-basalt-400 dark:text-sand-400 uppercase tracking-wider px-1">
              <span>Siapa yang Sedang Genting?</span>
              <span id="p3k-target-badge" class="text-pine-600 dark:text-pine-400 font-bold">👶 Mode Anak</span>
            </div>
            <div class="grid grid-cols-2 p-1 bg-sand-100 dark:bg-basalt-800 rounded-2xl gap-1">
              <button id="p3k-tab-anak" onclick="setP3kTarget('anak')" class="py-2.5 px-3 rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 bg-white dark:bg-basalt-900 text-pine-700 dark:text-pine-300 shadow-sm">
                <span>👶 Anak Mengamuk</span>
              </button>
              <button id="p3k-tab-ortu" onclick="setP3kTarget('ortu')" class="py-2.5 px-3 rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 text-basalt-500 dark:text-sand-400 hover:text-basalt-900">
                <span>🧘 Saya Mau Meledak</span>
              </button>
            </div>
          </div>"""

new_p3k_triage = """          <!-- Red Flag / Medical Safety Guardrail Banner -->
          <div class="p-2.5 rounded-xl bg-red-50 dark:bg-red-950/70 border border-red-200 dark:border-red-800/80 text-[10.5px] text-red-700 dark:text-red-300 flex items-start gap-2 shadow-sm">
            <span class="material-symbols-outlined text-[18px] shrink-0 text-red-600 dark:text-red-400 mt-0.5">health_and_safety</span>
            <div>
              <span class="font-extrabold uppercase tracking-wide">Protokol Keselamatan Fisik &amp; Jiwa (Hifzhun Nafs):</span>
              Bila ada ancaman bahaya fisik langsung, melukai diri, atau darurat medis, utamakan keselamatan fisik seketika &amp; segera hubungi bantuan medis/keluarga terdekat.
            </div>
          </div>

          <!-- Triple Triage Switcher: 3 Sasaran Genting (Anak, Ortu, Guru) -->
          <div class="space-y-1.5">
            <div class="flex justify-between items-center text-[10px] font-bold text-basalt-400 dark:text-sand-400 uppercase tracking-wider px-1">
              <span>Siapa yang Sedang Genting?</span>
              <span id="p3k-target-badge" class="text-pine-600 dark:text-pine-400 font-bold">👶 Mode Anak</span>
            </div>
            <div class="grid grid-cols-3 p-1 bg-sand-100 dark:bg-basalt-800 rounded-2xl gap-1">
              <button id="p3k-tab-anak" onclick="setP3kTarget('anak')" class="py-2 px-1 rounded-xl text-[11px] font-bold transition flex items-center justify-center gap-1 bg-white dark:bg-basalt-900 text-pine-700 dark:text-pine-300 shadow-sm">
                <span>👶 Anak</span>
              </button>
              <button id="p3k-tab-ortu" onclick="setP3kTarget('ortu')" class="py-2 px-1 rounded-xl text-[11px] font-bold transition flex items-center justify-center gap-1 text-basalt-500 dark:text-sand-400 hover:text-basalt-900">
                <span>🧘 Ortu Burnout</span>
              </button>
              <button id="p3k-tab-guru" onclick="setP3kTarget('guru')" class="py-2 px-1 rounded-xl text-[11px] font-bold transition flex items-center justify-center gap-1 text-basalt-500 dark:text-sand-400 hover:text-basalt-900">
                <span>🏫 Guru/Kelas</span>
              </button>
            </div>
          </div>"""

if old_p3k_triage in content:
    content = content.replace(old_p3k_triage, new_p3k_triage)
    print("✓ Successfully replaced P3K triage with 3 roles and safety guardrail!")
else:
    triage_regex = r'<!-- Dual Triage Switcher:[\s\S]*?<\/div>\s*<\/div>\s*<\/div>'
    content = re.sub(triage_regex, new_p3k_triage, content, count=1)
    print("✓ Replaced P3K Triage via regex!")

# 4. Add deep-link to Kasus 3 in Subview Anak
old_anak_transisi = """            <!-- Tombol Transisi ke Fase Stabil Anak -->
            <div class="pt-2">
              <button onclick="p3kGoToStabil()" class="w-full py-4 rounded-2xl bg-pine-600 hover:bg-pine-700 active:scale-98 text-white font-bold text-xs shadow-lg flex items-center justify-center gap-2 transition">
                <span class="material-symbols-outlined text-[20px]">check_circle</span>
                <span>Alhamdulillah, Anak Sudah Tenang ➔</span>
              </button>
              <p class="text-[10px] text-basalt-400 dark:text-sand-500 text-center mt-1.5">
                Ketuk tombol di atas jika badai emosi sudah reda untuk membaca panduan adab & doa
              </p>
            </div>"""

new_anak_transisi = """            <!-- Deep Link ke Cetak Biru Kasus 3 -->
            <div class="pt-1">
              <button onclick="closeModal('modal-p3k'); openTipDetail('kasus-3')" class="w-full py-2.5 px-3 rounded-xl bg-sand-100 hover:bg-sand-200 dark:bg-basalt-800 dark:hover:bg-basalt-700 text-pine-700 dark:text-pine-300 font-bold text-[11px] border border-pine-200 dark:border-pine-800 flex items-center justify-center gap-2 transition active:scale-98">
                <span class="material-symbols-outlined text-[16px]">menu_book</span>
                <span>Buka Tips 3 Menit: Kasus 3 (Tantrum Balita) ➔</span>
              </button>
            </div>

            <!-- Tombol Transisi ke Fase Stabil Anak -->
            <div class="pt-1">
              <button onclick="p3kGoToStabil()" class="w-full py-3.5 rounded-2xl bg-pine-600 hover:bg-pine-700 active:scale-98 text-white font-bold text-xs shadow-lg flex items-center justify-center gap-2 transition">
                <span class="material-symbols-outlined text-[18px]">check_circle</span>
                <span>Alhamdulillah, Anak Sudah Tenang ➔</span>
              </button>
              <p class="text-[10px] text-basalt-400 dark:text-sand-500 text-center mt-1.5">
                Ketuk tombol di atas jika badai emosi sudah reda untuk membaca panduan adab &amp; doa
              </p>
            </div>"""

if old_anak_transisi in content:
    content = content.replace(old_anak_transisi, new_anak_transisi)
    print("✓ Added deep link in Subview Anak!")

# 5. Add deep-link to Kasus 1 in Subview Ortu
old_ortu_transisi = """            <!-- Tombol Transisi ke Fase Stabil Ortu -->
            <div class="pt-2">
              <button onclick="p3kGoToStabil()" class="w-full py-4 rounded-2xl bg-terracotta-600 hover:bg-terracotta-700 active:scale-98 text-white font-bold text-xs shadow-lg flex items-center justify-center gap-2 transition">
                <span class="material-symbols-outlined text-[20px]">self_improvement</span>
                <span>Alhamdulillah, Hati Saya Sudah Tenang ➔</span>
              </button>
              <p class="text-[10px] text-basalt-400 dark:text-sand-500 text-center mt-1.5">
                Ketuk tombol jika detak jantung sudah melambat untuk memulihkan diri & muhasabah
              </p>
            </div>"""

new_ortu_transisi = """            <!-- Deep Link ke Cetak Biru Kasus 1 -->
            <div class="pt-1">
              <button onclick="closeModal('modal-p3k'); openTipDetail('kasus-1')" class="w-full py-2.5 px-3 rounded-xl bg-sand-100 hover:bg-sand-200 dark:bg-basalt-800 dark:hover:bg-basalt-700 text-terracotta-700 dark:text-terracotta-300 font-bold text-[11px] border border-terracotta-200 dark:border-terracotta-800 flex items-center justify-center gap-2 transition active:scale-98">
                <span class="material-symbols-outlined text-[16px]">menu_book</span>
                <span>Buka Tips 3 Menit: Kasus 1 (Parental Burnout) ➔</span>
              </button>
            </div>

            <!-- Tombol Transisi ke Fase Stabil Ortu -->
            <div class="pt-1">
              <button onclick="p3kGoToStabil()" class="w-full py-3.5 rounded-2xl bg-terracotta-600 hover:bg-terracotta-700 active:scale-98 text-white font-bold text-xs shadow-lg flex items-center justify-center gap-2 transition">
                <span class="material-symbols-outlined text-[18px]">self_improvement</span>
                <span>Alhamdulillah, Hati Saya Sudah Tenang ➔</span>
              </button>
              <p class="text-[10px] text-basalt-400 dark:text-sand-500 text-center mt-1.5">
                Ketuk tombol jika detak jantung sudah melambat untuk memulihkan diri &amp; muhasabah
              </p>
            </div>"""

if old_ortu_transisi in content:
    content = content.replace(old_ortu_transisi, new_ortu_transisi)
    print("✓ Added deep link in Subview Ortu!")

# 6. Add Subview Guru and Stabil Guru
subview_guru_html = """          <!-- ---------------------------------------------------------- -->
          <!-- SUB-VIEW C: TARGET GURU & KELAS GADUH (DE-ESKALASI KELAS) -->
          <!-- ---------------------------------------------------------- -->
          <div id="p3k-subview-guru" class="hidden space-y-4">
            <!-- Anchor Visual Kelas -->
            <div class="p-4 rounded-3xl bg-gradient-to-br from-indigo-950 to-basalt-950 text-white text-center space-y-1 shadow-inner border border-indigo-800/80">
              <span class="text-[11px] font-bold text-indigo-300 tracking-wider uppercase block animate-pulse">
                🏫 DE-ESKALASI KELAS • WIBAWA HEBAT TANPA TERIAKAN
              </span>
              <h3 class="text-lg font-bold font-serif text-sand-50 tracking-tight">
                Keheningan Berwibawa (Silent Authority)
              </h3>
              <p class="text-[11px] text-sand-300 opacity-90">
                Tahan bentakan &amp; gebrak meja • Sentuh frekuensi hati murid
              </p>
            </div>

            <!-- 3 Langkah Protokol Aksi Cepat Guru di Kelas (< 3 Menit) -->
            <div class="space-y-2">
              <div class="p-3 rounded-2xl bg-sand-50 dark:bg-basalt-950 border-2 border-indigo-200 dark:border-indigo-900/60 flex items-center gap-3">
                <div class="w-9 h-9 rounded-xl bg-indigo-600 text-white font-bold flex items-center justify-center shrink-0 text-sm shadow">
                  1
                </div>
                <div class="min-w-0">
                  <div class="flex items-center gap-1.5">
                    <h4 class="text-xs font-bold text-basalt-900 dark:text-sand-50">Keheningan Berwibawa 30 Detik</h4>
                    <span class="text-[9px] font-extrabold uppercase px-1.5 py-0.5 rounded bg-indigo-100 dark:bg-indigo-950 text-indigo-700 dark:text-indigo-300">Wibawa Awal</span>
                  </div>
                  <p class="text-[11px] text-basalt-500 dark:text-sand-400">Berdiri tegak di depan tengah kelas, tatap murid dengan senyuman teduh tanpa sepatah kata pun</p>
                </div>
              </div>

              <div class="p-3 rounded-2xl bg-sand-50 dark:bg-basalt-950 border border-sand-200 dark:border-basalt-800 flex items-center gap-3">
                <div class="w-9 h-9 rounded-xl bg-pine-600 text-white font-bold flex items-center justify-center shrink-0 text-sm shadow">
                  2
                </div>
                <div class="min-w-0">
                  <h4 class="text-xs font-bold text-basalt-900 dark:text-sand-50">Gestur Satu Telapak Tangan Terbuka</h4>
                  <p class="text-[11px] text-basalt-500 dark:text-sand-400">Angkat tangan ke atas sebagai kode hening sampai murid saling mengingatkan temannya</p>
                </div>
              </div>

              <div class="p-3 rounded-2xl bg-sand-50 dark:bg-basalt-950 border border-sand-200 dark:border-basalt-800 flex items-center gap-3">
                <div class="w-9 h-9 rounded-xl bg-pine-600 text-white font-bold flex items-center justify-center shrink-0 text-sm shadow">
                  3
                </div>
                <div class="min-w-0">
                  <h4 class="text-xs font-bold text-basalt-900 dark:text-sand-50">Apersepsi Suara Berbisik / Sirah</h4>
                  <p class="text-[11px] text-basalt-500 dark:text-sand-400">Bicara dengan nada desah rendah: kisah rahasia atau sirah Umar bin Khattab ra</p>
                </div>
              </div>
            </div>

            <!-- Deep Link ke Cetak Biru Kasus 7 -->
            <div class="pt-1">
              <button onclick="closeModal('modal-p3k'); openTipDetail('kasus-7')" class="w-full py-2.5 px-3 rounded-xl bg-sand-100 hover:bg-sand-200 dark:bg-basalt-800 dark:hover:bg-basalt-700 text-indigo-700 dark:text-indigo-300 font-bold text-[11px] border border-indigo-200 dark:border-indigo-800 flex items-center justify-center gap-2 transition active:scale-98">
                <span class="material-symbols-outlined text-[16px]">menu_book</span>
                <span>Buka Tips Lengkap: Kasus 7 (De-eskalasi Kelas Gaduh) ➔</span>
              </button>
            </div>

            <!-- Tombol Transisi ke Fase Stabil Guru -->
            <div class="pt-1">
              <button onclick="p3kGoToStabil()" class="w-full py-3.5 rounded-2xl bg-indigo-600 hover:bg-indigo-700 active:scale-98 text-white font-bold text-xs shadow-lg flex items-center justify-center gap-2 transition">
                <span class="material-symbols-outlined text-[18px]">school</span>
                <span>Alhamdulillah, Kelas Sudah Tenang &amp; Fokus ➔</span>
              </button>
            </div>
          </div>"""

# Insert Subview Guru right after Subview Ortu ends
marker_ortu_end = """            <!-- Tombol Transisi ke Fase Stabil Ortu -->
            <div class="pt-1">
              <button onclick="p3kGoToStabil()" class="w-full py-3.5 rounded-2xl bg-terracotta-600 hover:bg-terracotta-700 active:scale-98 text-white font-bold text-xs shadow-lg flex items-center justify-center gap-2 transition">
                <span class="material-symbols-outlined text-[18px]">self_improvement</span>
                <span>Alhamdulillah, Hati Saya Sudah Tenang ➔</span>
              </button>
              <p class="text-[10px] text-basalt-400 dark:text-sand-500 text-center mt-1.5">
                Ketuk tombol jika detak jantung sudah melambat untuk memulihkan diri &amp; muhasabah
              </p>
            </div>
          </div>"""

if marker_ortu_end in content:
    content = content.replace(marker_ortu_end, marker_ortu_end + "\n\n" + subview_guru_html)
    print("✓ Successfully inserted P3K Subview Guru!")
else:
    print("! Notice: marker_ortu_end not found exactly, searching with regex...")
    pattern = r'(<div id="p3k-subview-ortu"[\s\S]*?<\/div>\s*<\/div>\s*)(<\/div>\s*<!-- =+ -->\s*<!-- VIEW 2: KONDISI SUDAH STABIL)'
    content = re.sub(pattern, r'\1' + subview_guru_html + r'\n        \2', content, count=1)
    print("✓ Inserted P3K Subview Guru via regex!")

# Add Stabil Guru section
stabil_guru_html = """          <!-- ---------------------------------------------------------- -->
          <!-- KONTEN STABIL: VERSI GURU & KELAS -->
          <!-- ---------------------------------------------------------- -->
          <div id="p3k-stabil-guru" class="hidden space-y-4">
            <!-- Apresiasi Wibawa Guru -->
            <div class="p-3.5 rounded-2xl bg-indigo-50 dark:bg-indigo-950/60 border border-indigo-200 dark:border-indigo-900 flex items-start gap-3">
              <span class="material-symbols-outlined text-indigo-600 text-[24px] shrink-0 mt-0.5">verified</span>
              <div>
                <h4 class="text-xs font-bold text-indigo-800 dark:text-indigo-200">Alhamdulillah, Wibawa Kelas Berhasil Ditegakkan</h4>
                <p class="text-[11px] text-indigo-700 dark:text-indigo-300 mt-0.5 leading-snug">
                  Anda telah mengendalikan kelas tanpa amarah dan tanpa kekerasan verbal. Keteladanan sabar Anda adalah kurikulum adab terbaik bagi murid.
                </p>
              </div>
            </div>

            <!-- Kaidah Apersepsi Pengajaran -->
            <div class="p-3.5 rounded-2xl bg-ambercustom-50/70 dark:bg-ambercustom-950/40 border border-ambercustom-200 dark:border-ambercustom-900 space-y-1.5">
              <div class="flex items-center gap-1.5 text-ambercustom-700 dark:text-ambercustom-300 text-xs font-bold">
                <span class="material-symbols-outlined text-[18px]">lightbulb</span>
                <span>KAIDAH ADAB: SENTUH HATI SEBELUM PIKIRAN</span>
              </div>
              <p class="text-[11px] text-basalt-700 dark:text-sand-200 leading-relaxed">
                Anak-anak belajar dari siapa yang mereka cintai. Hindari langsung membuka materi pelajaran secara kaku. Luangkan 2 menit apersepsi emosional atau cerita sirah sebelum masuk rumus dan materi.
              </p>
            </div>
          </div>"""

target_btn_tutup = """          <!-- Tombol Tutup Selesai -->
          <button onclick="closeModal('modal-p3k')" class="w-full py-3 rounded-xl bg-basalt-800 dark:bg-basalt-700 text-white font-bold text-xs shadow hover:bg-basalt-900 transition">
            Tutup & Lanjutkan Aktivitas
          </button>"""

if target_btn_tutup in content:
    content = content.replace(target_btn_tutup, stabil_guru_html + "\n\n" + target_btn_tutup)
    print("✓ Added Stabil Guru section!")

# 7. ADD MODALS: modal-tips and modal-tip-detail
new_modals_html = """    <!-- ============================================================== -->
    <!-- MODAL POPUP: KATALOG TIPS PRAKTIS KESEHARIAN (7 KLUSTER • 9 KASUS) -->
    <!-- ============================================================== -->
    <div id="modal-tips" class="hidden absolute inset-0 bg-black/75 backdrop-blur-md z-50 flex items-end md:items-center justify-center p-0 md:p-4 transition-all">
      <div class="w-full max-w-[440px] bg-white dark:bg-basalt-900 rounded-t-[32px] md:rounded-3xl p-5 shadow-2xl max-h-[92vh] overflow-y-auto no-scrollbar animate-in slide-in-from-bottom flex flex-col space-y-4">
        
        <!-- Header Modal Tips -->
        <div class="flex justify-between items-start border-b border-sand-200 dark:border-basalt-800 pb-3">
          <div>
            <div class="flex items-center gap-2">
              <span class="material-symbols-outlined text-pine-600 dark:text-pine-400 text-[22px]">quick_reference</span>
              <h2 class="text-base font-extrabold text-basalt-900 dark:text-sand-50">Tips Praktis Keseharian</h2>
            </div>
            <p class="text-[11px] text-basalt-500 dark:text-sand-400 mt-0.5">
              Solusi 3 Menit Nabawi &amp; Script Siap Pakai (7 Kluster Masalah)
            </p>
          </div>
          <button onclick="closeModal('modal-tips')" class="w-8 h-8 rounded-full bg-sand-100 dark:bg-basalt-800 flex items-center justify-center text-basalt-500 hover:text-basalt-900 transition shrink-0">✕</button>
        </div>

        <!-- Pencarian Cepat Masalah / Trigger -->
        <div class="relative">
          <span class="material-symbols-outlined absolute left-3 top-2.5 text-basalt-400 text-[18px]">search</span>
          <input 
            type="text" 
            id="tips-search-input" 
            oninput="filterTipsCards()" 
            placeholder="Cari: tantrum, gadget, shalat, burnout, gaduh..."
            class="w-full pl-9 pr-8 py-2 text-xs rounded-xl bg-sand-50 dark:bg-basalt-950 border border-sand-200 dark:border-basalt-800 text-basalt-900 dark:text-sand-100 placeholder-basalt-400 focus:outline-none focus:ring-2 focus:ring-pine-500"
          >
          <button onclick="document.getElementById('tips-search-input').value = ''; filterTipsCards();" class="absolute right-2.5 top-2.5 text-[11px] text-basalt-400 hover:text-basalt-600">✕</button>
        </div>

        <!-- Filter Peran / Kategori Chips -->
        <div class="flex gap-1.5 overflow-x-auto no-scrollbar py-0.5 text-xs">
          <button onclick="selectTipsCategory('all')" id="tips-filter-all" class="tips-cat-btn px-3 py-1.5 rounded-full font-bold bg-pine-600 text-white shadow-sm shrink-0 transition">
            Semua (9)
          </button>
          <button onclick="selectTipsCategory('ortu')" id="tips-filter-ortu" class="tips-cat-btn px-3 py-1.5 rounded-full font-bold bg-sand-100 dark:bg-basalt-800 text-basalt-600 dark:text-sand-300 hover:bg-sand-200 shrink-0 transition">
            👶 Ortu &amp; Anak (4)
          </button>
          <button onclick="selectTipsCategory('pribadi')" id="tips-filter-pribadi" class="tips-cat-btn px-3 py-1.5 rounded-full font-bold bg-sand-100 dark:bg-basalt-800 text-basalt-600 dark:text-sand-300 hover:bg-sand-200 shrink-0 transition">
            🧘 Diri &amp; Jiwa (2)
          </button>
          <button onclick="selectTipsCategory('guru')" id="tips-filter-guru" class="tips-cat-btn px-3 py-1.5 rounded-full font-bold bg-sand-100 dark:bg-basalt-800 text-basalt-600 dark:text-sand-300 hover:bg-sand-200 shrink-0 transition">
            🏫 Guru &amp; Kelas (3)
          </button>
        </div>

        <!-- Counter Badge Status -->
        <div class="flex justify-between items-center text-[11px] text-basalt-400 dark:text-sand-400 px-0.5">
          <span id="tips-count-text">Menampilkan 9 solusi praktis</span>
          <span class="text-pine-600 dark:text-pine-400 font-bold flex items-center gap-1">
            <span class="w-1.5 h-1.5 rounded-full bg-pine-500 animate-pulse"></span>
            Format 6 Elemen Baku
          </span>
        </div>

        <!-- Dynamic Case Cards Container -->
        <div id="tips-card-container" class="space-y-2.5">
          <!-- Populated by JavaScript renderTipsCards() -->
        </div>

        <!-- Footer Guidance -->
        <div class="pt-2 border-t border-sand-100 dark:border-basalt-800 text-center">
          <p class="text-[10.5px] text-basalt-400 dark:text-sand-500 leading-snug">
            Disusun dari analisis 1.089 kasus &amp; buku <em>Mendidik Karakter dengan Karakter</em>.
          </p>
        </div>

      </div>
    </div>

    <!-- ============================================================== -->
    <!-- MODAL POPUP: DETAIL CETAK BIRU TIPS 6 ELEMEN ZERO-FLUFF -->
    <!-- ============================================================== -->
    <div id="modal-tip-detail" class="hidden absolute inset-0 bg-black/80 backdrop-blur-md z-50 flex items-end md:items-center justify-center p-0 md:p-4 transition-all">
      <div class="w-full max-w-[460px] bg-white dark:bg-basalt-900 rounded-t-[32px] md:rounded-3xl p-5 shadow-2xl max-h-[94vh] overflow-y-auto no-scrollbar animate-in slide-in-from-bottom flex flex-col space-y-4">
        
        <!-- Header Detail -->
        <div class="flex justify-between items-center border-b border-sand-200 dark:border-basalt-800 pb-3">
          <button onclick="backToTipsCatalog()" class="text-xs font-bold text-pine-600 dark:text-pine-400 flex items-center gap-1 hover:underline">
            <span class="material-symbols-outlined text-[16px]">arrow_back</span>
            <span>Kembali ke Katalog</span>
          </button>
          <button onclick="closeModal('modal-tip-detail')" class="w-8 h-8 rounded-full bg-sand-100 dark:bg-basalt-800 flex items-center justify-center text-basalt-500 hover:text-basalt-900 transition">✕</button>
        </div>

        <!-- Detail Dynamic Content Container -->
        <div id="tip-detail-body" class="space-y-4 text-xs">
          <!-- Injected via openTipDetail() -->
        </div>

        <!-- Bottom Action Bar -->
        <div class="pt-3 border-t border-sand-200 dark:border-basalt-800 flex gap-2">
          <button onclick="markTipPracticed()" id="tip-practice-btn" class="flex-1 py-3 px-3 rounded-2xl bg-pine-600 hover:bg-pine-700 text-white font-bold text-xs shadow-md transition flex items-center justify-center gap-1.5 active:scale-98">
            <span class="material-symbols-outlined text-[18px]">check_circle</span>
            <span id="tip-practice-label">Tandai Sudah Dipraktikkan</span>
          </button>
          <button onclick="backToTipsCatalog()" class="py-3 px-4 rounded-2xl bg-sand-100 hover:bg-sand-200 dark:bg-basalt-800 dark:hover:bg-basalt-700 text-basalt-700 dark:text-sand-300 font-bold text-xs transition">
            Katalog
          </button>
        </div>

      </div>
    </div>
"""

# Place new_modals_html right after modal-curhat or before the last modal
target_modal_place = """    <!-- ============================================================== -->
    <!-- MODAL POPUP: RUANG QALBU PTT WALKIE-TALKIE DEMO -->"""

if target_modal_place in content:
    content = content.replace(target_modal_place, new_modals_html + "\n" + target_modal_place)
    print("✓ Inserted modal-tips and modal-tip-detail before modal-curhat!")
else:
    print("! Notice: target_modal_place not found, inserting before closing modal container...")
    content = content.replace("    <div id=\"modal-pilar\"", new_modals_html + "\n    <div id=\"modal-pilar\"")
    print("✓ Inserted modals before modal-pilar!")

# 8. UPDATE JAVASCRIPT: setP3kTarget, p3kGoToStabil, and TIPS DATA & CONTROLLERS
tips_js_data_and_logic = """
    // =========================================================================
    // 4.1 DATASET 9 CETAK BIRU TIPS PRAKTIS 3 MENIT (ANALISIS 1.089 KASUS PKN)
    // =========================================================================
    const TIPS_CASES = [
      {
        id: "kasus-1",
        clusterId: "C1",
        clusterName: "Burnout & Tazkiyah",
        category: "pribadi",
        categoryLabel: "🧘 Diri & Jiwa",
        roleTag: "Pribadi / Orang Tua",
        title: "Mengatasi Parental Burnout & Mom/Dad Guilt",
        scenario: "Pengasuh kelelahan hebat seharian, lalu membentak anak dan dilanda penyesalan mendalam serta rasa bersalah (guilt) di malam hari.",
        fitrahRoot: "Faqidul syai' la yu'thihi (Jiwa yang kosong tidak bisa memberi air segar). Luapan amarah adalah alarm nafs ammarah yang lelah dan tangki cinta diri sedang defisit.",
        donts: [
          "Menghukum diri dengan larut dalam rasa berdosa tanpa aksi pemulihan konkret.",
          "Membenarkan bentakan dengan dalih 'anak ini memang keterlaluan'.",
          "Melarikan stres ke scrolling medsos berjam-jam yang justru menambah kecemasan batin."
        ],
        protocolSteps: [
          { step: 1, title: "Jeda Fisik (Time-Out Mandiri)", desc: "Ambil wudhu air dingin dan duduk/berbaring sejenak sesuai sunnah saat marah." },
          { step: 2, title: "Tarik Nafas Sadar & Istighfar", desc: "Tarik nafas 4 hitungan, hembuskan 6 hitungan sambil beristighfar 7 kali." },
          { step: 3, title: "Rekonsiliasi Hangat", desc: "Dekati anak, tatap matanya sejajar, pegang tangannya secara lembut." }
        ],
        scripts: {
          ayah: "Nak, tatap mata Ayah ya. Tadi Ayah bicara keras karena lelah dan khilaf. Membentakmu itu salah dan bukan salahmu. Ayah minta maaf dan Ayah sangat menyayangimu.",
          bunda: "Maafkan Bunda ya, Nak. Tadi Bunda sempat meninggikan suara karena badan Bunda lelah sekali. Bunda peluk kamu sekarang ya, Bunda sayang sekali padamu."
        },
        weeklyFollowup: [
          "Alokasikan 15 menit waktu hening (khalwah) di sepertiga malam untuk munajat dan muhasabah.",
          "Musyawarahkan pembagian beban domestik bersama pasangan; pastikan ada jeda istirahat harian minimal 30 menit."
        ]
      },
      {
        id: "kasus-2",
        clusterId: "C1",
        clusterName: "Burnout & Tazkiyah",
        category: "pribadi",
        categoryLabel: "🧘 Diri & Jiwa",
        roleTag: "Pribadi Muslim Dewasa",
        title: "Kelesuan Jiwa, Malas Beramal & Futur",
        scenario: "Pribadi merasa hampa, berat beribadah sunnah, shalat fardhu terasa hambar hanya sekadar menggugurkan kewajiban.",
        fitrahRoot: "Iman mengalami pasang-surut (Yazidu wa yanqush). Kelesuan jiwa terjadi saat hati terpapar noda dosa harian (nukatun sauda') atau terlalu banyak menghitung derita duniawi.",
        donts: [
          "Membebani diri secara mendadak dengan target ibadah raksasa di tengah fase lemah (Ifrath).",
          "Putus asa dari rahmat Allah atau mencap diri munafik (Tafrith)."
        ],
        protocolSteps: [
          { step: 1, title: "Penyegaran Saraf Jasad", desc: "Mandi air hangat atau bersiwak/gosok gigi untuk menyegarkan saraf fisik seketika." },
          { step: 2, title: "Satu Amalan Mikro Terindah", desc: "Lakukan 1 amalan kecil yang disukai: baca 3 ayat Al-Qur'an dengan tadabbur arti, atau sedekah subuh via aplikasi." },
          { step: 3, title: "Afirmasi Doa Nabawi", desc: "Lafalkan doa istighatsah Nabi memohon perbaikan seluruh urusan batin." }
        ],
        scripts: {
          ayah: "« يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ » — 'Wahai Dzat Yang Maha Hidup, dengan rahmat-Mu aku memohon pertolongan. Perbaikilah urusanku dan jangan Engkau serahkan aku pada diriku walau sekejap mata.'",
          bunda: "« يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ » — 'Wahai Dzat Yang Maha Hidup, dengan rahmat-Mu aku memohon pertolongan. Perbaikilah urusanku dan jangan Engkau serahkan aku pada diriku walau sekejap mata.'"
        },
        weeklyFollowup: [
          "Amalkan kaidah Adwamuha wa in qalla: fokus shalat 5 waktu berjamaah tepat waktu selama 7 hari tanpa target sunnah tambahan dulu.",
          "Puasa konsumsi konten media sosial yang memicu hasad/iri hati selama sepekan."
        ]
      },
      {
        id: "kasus-3",
        clusterId: "C5",
        clusterName: "Regulasi Emosi",
        category: "ortu",
        categoryLabel: "👶 Ortu & Anak",
        roleTag: "Ayah & Bunda (Balita 2-7 Th)",
        title: "Ledakan Tantrum Balita di Ruang Publik",
        scenario: "Anak menangis berguling-guling, menjerit, dan membanting barang di mall/toko karena keinginannya ditolak.",
        fitrahRoot: "'Tantrum itu Indah'. Katup pembuangan emosi otomatis balita yang belum memiliki kosakata matang untuk mengekspresikan kekecewaan egosentrisnya.",
        donts: [
          "Membentak balik: 'Diam! Bikin malu orang saja!'",
          "Menyerah dan membelikan mainan tersebut hanya agar anak diam (mengajarkan manipulasi tangisan).",
          "Mengancam dengan kebohongan: 'Nanti kamu ditangkap satpam/polisi lho!'"
        ],
        protocolSteps: [
          { step: 1, title: "Amankan Lokasi", desc: "Bawa anak dengan tenang ke tempat yang lebih sepi dan aman." },
          { step: 2, title: "Rendahkan Posisi Tubuh", desc: "Jongkok sejajar mata anak, pasang wajah tenang tanpa raut panik." },
          { step: 3, title: "Tahan Fisik Lembut", desc: "Dekap anak dari belakang atau pegang kedua tangannya agar tidak membanting barang/melukai diri." },
          { step: 4, title: "Tunggu Reda (Puasa Logika)", desc: "Jangan mendebat logika di puncak emosi anak. Dampingi 1–2 menit sampai tangisnya reda." }
        ],
        scripts: {
          ayah: "Ayah tahu Kakak sangat ingin mainan ini dan kecewa sekali hari ini belum bisa beli. Ayah di samping Kakak, kita peluk sampai nafasmu tenang ya.",
          bunda: "Bunda tahu kamu sangat ingin mainan ini dan sedih sekali. Bunda temani kamu menangis di sini sampai perasaanmu plong dan lega ya, Nak."
        },
        weeklyFollowup: [
          "Terapkan Pre-Agreement (Aqad Sebelum Berangkat): 'Hari ini kita beli susu dan roti, kita tidak beli mainan. Setuju?'. Minta anak mengulangi kesepakatan.",
          "Isi tangki cinta 10 menit pelukan berkualitas setiap pagi sebelum aktivitas."
        ]
      },
      {
        id: "kasus-4",
        clusterId: "C3",
        clusterName: "Kemalasan Ibadah",
        category: "ortu",
        categoryLabel: "👶 Ortu & Anak",
        roleTag: "Ayah & Bunda (Tamyiz 7-10 Th)",
        title: "Anak Mogok Shalat Fardhu Saat Asyik Bermain",
        scenario: "Waktu Maghrib tiba, anak usia 8 tahun menolak diajak shalat dan terus melanjutkan permainan balok atau game.",
        fitrahRoot: "Fase Tamyiz (7–10 th) adalah masa pembiasaan (amr) tanpa kekerasan fisik. Penolakan terjadi karena transisi mendadak memutus aliran dopamin permainannya secara kasar.",
        donts: [
          "Berteriak dari ruang lain: 'Cepat shalat! Nanti disiksa api neraka!'",
          "Merusak atau mematikan mainan anak secara paksa dan kasar.",
          "Memukul anak di bawah usia 10 tahun (pelanggaran hadits Nabi SAW)."
        ],
        protocolSteps: [
          { step: 1, title: "Hadir Fisik di Tempatnya", desc: "Berjalan mendekat ke tempat anak bermain, jangan berteriak dari kejauhan." },
          { step: 2, title: "Apresiasi Karyanya (10 Detik)", desc: "Masya Allah, rapi dan tinggi sekali menara balok yang Kakak bangun." },
          { step: 3, title: "Sentuhan & Peringatan 2 Menit", desc: "Usap punggungnya: Adzan Maghrib sudah panggil kita. Selesaikan 1 langkah ini dalam 2 menit, lalu wudhu bareng ya." },
          { step: 4, title: "Gandeng Tangan Tersenyum", desc: "Setelah 2 menit, ulurkan tangan dengan senyuman dan bimbing ke tempat wudhu." }
        ],
        scripts: {
          ayah: "Kakak, Allah panggil kita untuk shalat Maghrib. Baloknya disimpan di atas meja ini dulu, setelah shalat kita lanjutkan bersama Ayah jadi imammu.",
          bunda: "Sayang, yuk kita sambut panggilan Allah dulu. Mainannya kita istirahatkan sebentar, nanti sehabis shalat Bunda temani lanjut lagi ya."
        },
        weeklyFollowup: [
          "Jadikan shalat agenda keluarga yang membahagiakan: shalat berjamaah, berikan giliran anak melantunkan adzan/iqamah.",
          "Bacakan kisah kepahlawanan shahabat nabi 5 menit setelah shalat berjamaah."
        ]
      },
      {
        id: "kasus-5",
        clusterId: "C4",
        clusterName: "Candu Gadget",
        category: "ortu",
        categoryLabel: "👶 Ortu & Anak",
        roleTag: "Ayah & Bunda (Pra-Baligh 10-14 Th)",
        title: "Anak Menolak Belajar & Kecanduan Gawai",
        scenario: "Anak usia 11 tahun menghabiskan waktu berjam-jam di depan ponsel, menolak belajar, dan marah besar saat ponsel diminta.",
        fitrahRoot: "Gawai berfungsi sebagai 'Aqil-delayer' (membanjiri otak dengan dopamin instan). Anak kecanduan gawai karena tangki cinta di rumah kering atau energi bakat jasadnya tidak tersalurkan ke karya nyata.",
        donts: [
          "Menyita ponsel secara mendadak tanpa kesepakatan tertulis sebelumnya.",
          "Melabeli anak: 'Dasar pemalas, generasi rusak, main HP terus!'",
          "Orang tua sendiri asyik bermain ponsel di depan anak saat menasihati (kemunafikan keteladanan)."
        ],
        protocolSteps: [
          { step: 1, title: "Duduk Berdampingan 30 Detik", desc: "Perhatikan apa yang sedang ia tonton/mainkan tanpa celaan untuk membangun jembatan empati." },
          { step: 2, title: "Sentuhan Pundak Hangat", desc: "Letakkan tangan di pundaknya: 'Seru sekali ya permainannya. Tapi sekarang sudah jam 5 sore sesuai batas waktu kita.'" },
          { step: 3, title: "Hitungan Transisi 60 Detik", desc: "Berikan waktu 60 detik untuk save/checkpoint game, lalu minta taruh di keranjang." }
        ],
        scripts: {
          ayah: "Sesuai kesepakatan keluarga kita, jam 5 sore HP istirahat di kotak pengisian daya. Yuk, temani Ayah cek sepeda dan siram tanaman di halaman.",
          bunda: "Waktu layarnya sudah habis sesuai aqad kita kemarin ya, Kak. Yuk, simpan HP-nya, Bunda butuh bantuan koki hebatmu untuk bikin camilan sore."
        },
        weeklyFollowup: [
          "Restorasi Dopamin Alami: Gantikan waktu layar dengan aktivitas fisik menantang di luar rumah (bersepeda, memanah, berenang, atau proyek kreatif).",
          "Terapkan Device-Free Zone di meja makan dan kamar tidur untuk seluruh keluarga tanpa kecuali."
        ]
      },
      {
        id: "kasus-6",
        clusterId: "C2",
        clusterName: "Tangki Cinta & Saudara",
        category: "ortu",
        categoryLabel: "👶 Ortu & Anak",
        roleTag: "Ayah & Bunda (Multi-Anak)",
        title: "Pertengkaran Sibling Rivalry Antar-Saudara",
        scenario: "Kakak (9 th) dan adik (6 th) berebut mainan, saling menjerit, dan mulai saling dorong atau memukul.",
        fitrahRoot: "Saudara kandung adalah laboratorium sosial pertama. Konflik terjadi akibat perebutan batas wilayah ego dan rasa cemas akan berkurangnya kasih sayang orang tua (defisit tangki cinta).",
        donts: [
          "Langsung menyalahkan anak tertua: 'Kakak kan sudah besar, harus ngalah sama adik!' (memicu luka batin dan dendam laten).",
          "Memaksa anak langsung saling meminta maaf di saat emosi mereka masih mendidih."
        ],
        protocolSteps: [
          { step: 1, title: "Pisahkan Fisik di Tengah", desc: "Berdiri di antara keduanya, rentangkan tangan ke samping dan pisahkan ke jarak aman." },
          { step: 2, title: "Amankan Objek Rebutan", desc: "Simpan benda yang diperebutkan di tempat tinggi tanpa memihak salah satu." },
          { step: 3, title: "Validasi Emosi Bergiliran", desc: "Beri giliran masing-masing berbicara tanpa boleh memotong perkataan saudaranya." }
        ],
        scripts: {
          ayah: "Ayah tahu Kakak kaget mainan diambil, dan Ayah tahu Adik ingin ikut bermain. Tapi memukul dilarang di rumah kita. Kita duduk tenang 3 menit, baru kita bicarakan pembagian waktunya.",
          bunda: "Bunda dengarkan kalian berdua bergantian ya. Kakak cerita dulu tanpa Adik potong, lalu giliran Adik. Kalian berdua sama-sama berharga bagi Bunda."
        },
        weeklyFollowup: [
          "Isi tangki cinta anak sulung secara khusus: beri 'Special Time' 15 menit berdua saja bersama Ayah/Bunda tanpa adik setiap hari.",
          "Buat tabel kesepakatan giliran mainan yang ditandatangani bersama kedua anak."
        ]
      },
      {
        id: "kasus-7",
        clusterId: "C7",
        clusterName: "Dinamika Guru & Kelas",
        category: "guru",
        categoryLabel: "🏫 Guru & Kelas",
        roleTag: "Guru Kelas / Pendidik",
        title: "Murid Berisik, Gaduh & Mengabaikan Guru",
        scenario: "Guru masuk kelas SD/SMP, siswa masih berlarian, teriak-teriak, lempar kertas, dan mengabaikan panggilan guru.",
        fitrahRoot: "Kegaduhan adalah sinyal energi jasad kinestetik anak melimpah dan apersepsi awal belum menyentuh frekuensi hati mereka (sindrom Gurubot yang monoton).",
        donts: [
          "Menggebrak meja atau memukul papan tulis dengan penggaris keras-keras.",
          "Berteriak adu keras dengan suara murid: 'Hei! Diam semua! Jangan berisik!'",
          "Menghukum seluruh kelas akibat ulah beberapa siswa nakal (hukuman kolektif zalim)."
        ],
        protocolSteps: [
          { step: 1, title: "Keheningan Berwibawa (Silent Authority)", desc: "Berdiri tegak di tengah depan kelas, tatap murid satu per satu dengan senyuman tenang tanpa suara selama 30 detik." },
          { step: 2, title: "Sinyal Gestur Tangan Terbuka", desc: "Angkat satu tangan terbuka ke atas (sinyal fokus) hingga murid mulai saling menyenggol dan mengingatkan temannya untuk tenang." },
          { step: 3, title: "Apersepsi Berbisik / Sirah Menggetarkan", desc: "Saat suara kelas mereda 50%, mulailah berbicara dengan suara rendah/berbisik menceritakan cuplikan kisah heroik para shahabat." }
        ],
        scripts: {
          ayah: "Anak-anakku, Ustadz bangga melihat kalian penuh semangat hari ini. Namun di kelas ini, ada hak telinga yang ingin ilmu dan ada hak hati yang ingin tenang. Tarik nafas dalam-dalam... mari simak rahasia keberanian Umar bin Khattab ra.",
          bunda: "Shalih-shalihah, Ustadzah tahu energimu sedang meluap luar biasa. Simpan benda di tanganmu, pasang telinga hatimu... Ustadzah punya kisah yang hanya boleh didengar anak yang duduk tegak."
        },
        weeklyFollowup: [
          "Sisipkan variasi modalitas gerak kinestetik setiap 15 menit (ice breaking gerak fisik, tanya jawab berdiri) agar fitrah gerak tersalurkan legal.",
          "Terapkan kontrak belajar positif yang dirumuskan bersama seluruh murid di awal pekan."
        ]
      },
      {
        id: "kasus-8",
        clusterId: "C6",
        clusterName: "Kedisiplinan & CCTV",
        category: "guru",
        categoryLabel: "🏫 Guru & Kelas",
        roleTag: "Guru Asrama / Musyrif",
        title: "Pelanggaran Disiplin Berulang & 'Kepatuhan CCTV'",
        scenario: "Santri/murid SMP kedapatan merokok, membolos, atau bawa HP terlarang di asrama; hanya tertib ketika ada musyrif/guru di dekatnya.",
        fitrahRoot: "Melanggar aturan sembunyi-sembunyi adalah bukti aturan ditegakkan dengan rasa takut (Khauf semata), bukan kesadaran muraqabatullah (merasa diawasi oleh Allah SWT).",
        donts: [
          "Mempermalukan santri di depan apel seluruh siswa (meruntuhkan muru'ah dan izzah jiwanya).",
          "Memberikan hukuman fisik kurungan atau kekerasan yang meremukkan martabat santri."
        ],
        protocolSteps: [
          { step: 1, title: "Panggil Empat Mata di Ruang Nyaman", desc: "Hindari interogasi di tempat ramai. Bicara empat mata dengan suasana tenang." },
          { step: 2, title: "Sediakan Air Putih & Tanya Kabar Hati", desc: "Tawarkan air minum dan tanyakan kabar keluarganya sebelum membahas pelanggaran: 'Bagaimana kabar ibumu pekan ini?'" },
          { step: 3, title: "Sentuh Fitrah Malunya (Haya')", desc: "Tunjukkan bukti dengan tenang tanpa mencaci maki atau memberi label buruk." }
        ],
        scripts: {
          ayah: "Ustadz memanggilmu bukan untuk membencimu atau mempermalukanmu. Ustadz tahu kamu punya potensi kepemimpinan besar. Tapi perbuatan ini merusak amanah orang tuamu. Mari bicara dari hati ke hati: apa yang sedang kamu cari?",
          bunda: "Ustadzah tahu di balik tindakan ini ada kegelisahan yang belum tuntas kamu ceritakan. Ustadzah menyayangimu dan ingin melindungimu, bukan menghukummu. Ceritakan apa yang sebenarnya kamu rasakan."
        },
        weeklyFollowup: [
          "Terapkan metode EMISOL (Empati, Imajinasi, Solusi): ajak santri merancang sanksi restitusi (misal: adzan subuh, bersihkan perpustakaan) sebagai penebus terhormat.",
          "Beri amanah kepemimpinan kecil untuk membalikkan rasa percaya dirinya."
        ]
      },
      {
        id: "kasus-9",
        clusterId: "C7",
        clusterName: "Dinamika Guru & Kelas",
        category: "guru",
        categoryLabel: "🏫 Guru & Kelas",
        roleTag: "Guru Kelas / Konselor Sekolah",
        title: "Siswa Sangat Pemalu, Pasif & Menolak Berpartisipasi",
        scenario: "Siswa selalu menunduk saat ditunjuk, gemetar saat diminta maju ke depan kelas, dan tidak memiliki teman akrab.",
        fitrahRoot: "Anak memiliki bakat Introvert / Shamt (pendiam) atau Haya' alami (seperti sahabat Utsman bin Affan ra), atau jiwanya pernah terluka akibat ditertawakan saat melakukan kesalahan.",
        donts: [
          "Memaksa anak berbicara di depan kelas secara mendadak sambil mengolok: 'Jangan kuper dong! Masa ditanya begitu saja takut!'",
          "Mengabaikan anak dan hanya memberi panggung kepada murid-murid ekstrovert."
        ],
        protocolSteps: [
          { step: 1, title: "Beri Jalur Menjawab Tertulis", desc: "Berikan kesempatan menulis jawaban di sticky notes atau lembar kecil terlebih dahulu." },
          { step: 2, title: "Apresiasi Personal di Meja", desc: "Dekati mejanya saat murid lain sibuk: 'Jawaban tulisanmu sangat mendalam, Masya Allah.'" },
          { step: 3, title: "Pasangkan Teman Mengayomi", desc: "Dekatkan dengan satu teman sebaya yang bertipe pelindung dan ramah (Al-Ulfah / Ar-Rifq)." }
        ],
        scripts: {
          ayah: "Setiap manusia punya cara bersuara yang berbeda. Ada yang lewat suaranya, ada yang lewat tulisannya yang indah. Ustadz sangat menghargai caramu berpikir dan merenung.",
          bunda: "Tidak apa-apa pelan-pelan ya sayang. Ustadzah tahu hatimu kaya akan gagasan. Tuliskan dulu di sini, kapan pun kamu siap berbicara, Ustadzah akan selalu siap mendengarkan."
        },
        weeklyFollowup: [
          "Libatkan dalam proyek kelompok kecil (hanya berdua) dengan peran analisis data atau riset materi sesuai kekuatan fitrahnya.",
          "Hindari pemanggilan acak mendadak (cold-calling) di depan kelas tanpa aba-aba persiapan pribadi."
        ]
      }
    ];

    // Current State for Tips Modal
    let activeTipsFilter = 'all';
    let currentDetailCase = null;
    let currentDetailVoice = 'ayah';
    let practicedCases = JSON.parse(localStorage.getItem('pkn_practiced_cases') || '[]');

    function openTipsModal() {
      document.getElementById('modal-tips').classList.remove('hidden');
      selectTipsCategory('all');
    }

    function selectTipsCategory(category) {
      activeTipsFilter = category;
      const cats = ['all', 'ortu', 'pribadi', 'guru'];
      cats.forEach(c => {
        const btn = document.getElementById(`tips-filter-${c}`);
        if (!btn) return;
        if (c === category) {
          btn.className = "tips-cat-btn px-3 py-1.5 rounded-full font-bold bg-pine-600 text-white shadow-sm shrink-0 transition";
        } else {
          btn.className = "tips-cat-btn px-3 py-1.5 rounded-full font-bold bg-sand-100 dark:bg-basalt-800 text-basalt-600 dark:text-sand-300 hover:bg-sand-200 shrink-0 transition";
        }
      });
      filterTipsCards();
    }

    function filterTipsCards() {
      const searchVal = (document.getElementById('tips-search-input')?.value || '').toLowerCase().trim();
      const container = document.getElementById('tips-card-container');
      const countText = document.getElementById('tips-count-text');
      if (!container) return;

      const filtered = TIPS_CASES.filter(c => {
        const matchCat = activeTipsFilter === 'all' || c.category === activeTipsFilter;
        const matchQuery = !searchVal || 
          c.title.toLowerCase().includes(searchVal) || 
          c.scenario.toLowerCase().includes(searchVal) || 
          c.clusterName.toLowerCase().includes(searchVal) ||
          c.fitrahRoot.toLowerCase().includes(searchVal);
        return matchCat && matchQuery;
      });

      if (countText) {
        countText.textContent = `Menampilkan ${filtered.length} dari ${TIPS_CASES.length} solusi praktis`;
      }

      if (filtered.length === 0) {
        container.innerHTML = `
          <div class="p-8 text-center text-basalt-400 dark:text-sand-500 space-y-2">
            <span class="material-symbols-outlined text-[36px] text-basalt-300">search_off</span>
            <p class="text-xs font-semibold">Tidak ditemukan solusi dengan kata kunci "${searchVal}"</p>
            <p class="text-[11px]">Coba cari kata kunci lain seperti: tantrum, gadget, shalat, atau burnout.</p>
          </div>
        `;
        return;
      }

      container.innerHTML = filtered.map(c => {
        const isPracticed = practicedCases.includes(c.id);
        const clusterBadgeColor = 
          c.clusterId === 'C1' ? 'bg-amber-100 text-amber-800 dark:bg-amber-950 dark:text-amber-200' :
          c.clusterId === 'C5' ? 'bg-rose-100 text-rose-800 dark:bg-rose-950 dark:text-rose-200' :
          c.clusterId === 'C7' ? 'bg-indigo-100 text-indigo-800 dark:bg-indigo-950 dark:text-indigo-200' :
          c.clusterId === 'C3' ? 'bg-emerald-100 text-emerald-800 dark:bg-emerald-950 dark:text-emerald-200' :
          'bg-pine-100 text-pine-800 dark:bg-pine-950 dark:text-pine-200';

        return `
          <div onclick="openTipDetail('${c.id}')" class="cursor-pointer p-3.5 rounded-2xl bg-sand-50 dark:bg-basalt-950 border border-sand-200 dark:border-basalt-800 hover:border-pine-400 dark:hover:border-pine-600 transition shadow-sm active:scale-98 group space-y-2">
            <div class="flex justify-between items-start gap-2">
              <div class="flex flex-wrap items-center gap-1.5">
                <span class="text-[9.5px] font-extrabold uppercase px-2 py-0.5 rounded-full ${clusterBadgeColor}">
                  ${c.clusterId} • ${c.clusterName}
                </span>
                <span class="text-[10px] text-basalt-400 dark:text-sand-400 font-medium">
                  ${c.categoryLabel}
                </span>
              </div>
              ${isPracticed ? '<span class="text-[10px] font-bold text-pine-600 dark:text-pine-400 bg-pine-50 dark:bg-pine-950 px-1.5 py-0.5 rounded border border-pine-200 dark:border-pine-800 flex items-center gap-0.5"><span class="material-symbols-outlined text-[12px]">done_all</span> Sudah Praktik</span>' : ''}
            </div>

            <div>
              <h3 class="text-xs font-bold text-basalt-900 dark:text-sand-50 group-hover:text-pine-600 dark:group-hover:text-pine-400 transition leading-snug">
                ${c.title}
              </h3>
              <p class="text-[11px] text-basalt-500 dark:text-sand-400 line-clamp-2 mt-1 leading-relaxed">
                <strong class="text-basalt-700 dark:text-sand-300">Pemicu:</strong> ${c.scenario}
              </p>
            </div>

            <div class="flex justify-between items-center pt-1 border-t border-sand-200/60 dark:border-basalt-800/60 text-[10.5px]">
              <span class="text-pine-700 dark:text-pine-300 font-semibold flex items-center gap-1">
                <span class="material-symbols-outlined text-[14px]">timer</span>
                Protokol 3 Menit
              </span>
              <span class="font-bold text-pine-600 dark:text-pine-400 group-hover:translate-x-0.5 transition flex items-center">
                Buka Solusi ➔
              </span>
            </div>
          </div>
        `;
      }).join('');
    }

    function openTipDetail(caseId) {
      const tip = TIPS_CASES.find(c => c.id === caseId);
      if (!tip) return;
      currentDetailCase = tip;
      currentDetailVoice = 'ayah';

      const detailBody = document.getElementById('tip-detail-body');
      if (!detailBody) return;

      const isPracticed = practicedCases.includes(tip.id);
      updatePracticeButtonState(isPracticed);

      renderTipDetailContent();

      document.getElementById('modal-tips').classList.add('hidden');
      document.getElementById('modal-tip-detail').classList.remove('hidden');
    }

    function backToTipsCatalog() {
      document.getElementById('modal-tip-detail').classList.add('hidden');
      document.getElementById('modal-tips').classList.remove('hidden');
      filterTipsCards();
    }

    function setDetailVoice(role) {
      currentDetailVoice = role;
      renderTipDetailContent();
    }

    function renderTipDetailContent() {
      if (!currentDetailCase) return;
      const c = currentDetailCase;
      const detailBody = document.getElementById('tip-detail-body');

      const isGuru = c.category === 'guru';
      const role1Label = isGuru ? "👨‍🏫 Versi Ustadz (Tegas Berwibawa)" : "🧔 Versi Ayah (Wibawa Teduh)";
      const role2Label = isGuru ? "👩‍🏫 Versi Ustadzah (Kasih Mengayomi)" : "🧕 Versi Bunda (Peluk Empati)";

      detailBody.innerHTML = `
        <!-- Judul & Badge Kasus -->
        <div class="space-y-1">
          <div class="flex flex-wrap items-center gap-1.5">
            <span class="text-[10px] font-extrabold uppercase px-2 py-0.5 rounded-full bg-pine-100 dark:bg-pine-950 text-pine-700 dark:text-pine-300">
              ${c.clusterId} • ${c.clusterName}
            </span>
            <span class="text-[10px] text-basalt-500 dark:text-sand-400 font-medium">${c.roleTag}</span>
          </div>
          <h2 class="text-sm font-extrabold text-basalt-900 dark:text-sand-50 leading-tight">
            ${c.title}
          </h2>
        </div>

        <!-- 1. IDENTIFIKASI SKENARIO & PEMICU -->
        <div class="p-3 rounded-2xl bg-sand-50 dark:bg-basalt-950 border border-sand-200 dark:border-basalt-800 space-y-1">
          <div class="flex items-center gap-1.5 text-basalt-800 dark:text-sand-200 font-bold text-[11px]">
            <span class="material-symbols-outlined text-[16px] text-amber-500">crisis_alert</span>
            <span>1. SKENARIO &amp; PEMICU NYATA</span>
          </div>
          <p class="text-[11.5px] text-basalt-700 dark:text-sand-300 leading-relaxed">
            ${c.scenario}
          </p>
        </div>

        <!-- 2. PERSPEKTIF FITRAH (AKAR MASALAH) -->
        <div class="p-3 rounded-2xl bg-pine-50/70 dark:bg-pine-950/40 border border-pine-200 dark:border-pine-900/60 space-y-1">
          <div class="flex items-center gap-1.5 text-pine-800 dark:text-pine-200 font-bold text-[11px]">
            <span class="material-symbols-outlined text-[16px] text-pine-600">psychology</span>
            <span>2. PERSPEKTIF FITRAH (AKAR MASALAH)</span>
          </div>
          <p class="text-[11.5px] text-pine-900 dark:text-pine-100 leading-relaxed font-serif italic">
            "${c.fitrahRoot}"
          </p>
        </div>

        <!-- 3. KESALAHAN FATAL YANG DILARANG (DON'TS) -->
        <div class="p-3 rounded-2xl bg-red-50/70 dark:bg-red-950/40 border border-red-200 dark:border-red-900/60 space-y-1.5">
          <div class="flex items-center gap-1.5 text-red-800 dark:text-red-300 font-bold text-[11px]">
            <span class="material-symbols-outlined text-[16px] text-red-600">block</span>
            <span>3. PANTANGAN KERAS (JANGAN DILAKUKAN!)</span>
          </div>
          <ul class="text-[11px] text-red-950 dark:text-red-100 space-y-1 list-disc pl-4 leading-relaxed">
            ${c.donts.map(d => `<li>${d}</li>`).join('')}
          </ul>
        </div>

        <!-- 4. PROTOKOL RESPON 3 MENIT PERTAMA -->
        <div class="p-3 rounded-2xl bg-sand-100/70 dark:bg-basalt-950 border border-sand-200 dark:border-basalt-800 space-y-2">
          <div class="flex items-center justify-between">
            <span class="flex items-center gap-1.5 font-bold text-basalt-800 dark:text-sand-200 text-[11px]">
              <span class="material-symbols-outlined text-[16px] text-pine-600">timer</span>
              <span>4. PROTOKOL AKSI 3 MENIT PERTAMA</span>
            </span>
            <span class="text-[9.5px] font-bold text-pine-600 bg-pine-100 dark:bg-pine-950 px-2 py-0.5 rounded-full">Urutan Fisik</span>
          </div>
          <div class="space-y-2">
            ${c.protocolSteps.map(ps => `
              <div class="flex items-start gap-2.5 p-2 rounded-xl bg-white dark:bg-basalt-900 border border-sand-200 dark:border-basalt-800">
                <span class="w-5 h-5 rounded-full bg-pine-600 text-white font-bold flex items-center justify-center shrink-0 text-[10px] mt-0.5">
                  ${ps.step}
                </span>
                <div>
                  <h4 class="font-bold text-[11px] text-basalt-900 dark:text-sand-100">${ps.title}</h4>
                  <p class="text-[10.5px] text-basalt-600 dark:text-sand-300 leading-snug mt-0.5">${ps.desc}</p>
                </div>
              </div>
            `).join('')}
          </div>
        </div>

        <!-- 5. SCRIPT VERBATIM SIAP PAKAI -->
        <div class="p-3.5 rounded-2xl bg-gradient-to-br from-pine-900 to-basalt-950 text-white space-y-2.5 shadow-md border border-pine-800">
          <div class="flex justify-between items-center">
            <span class="text-[10.5px] font-extrabold uppercase text-ambercustom-300 tracking-wider flex items-center gap-1">
              <span class="material-symbols-outlined text-[15px]">record_voice_over</span>
              5. KALIMAT VERBATIM SIAP PAKAI
            </span>
            <button onclick="copyVerbatimScript()" class="px-2 py-1 rounded-lg bg-white/20 hover:bg-white/30 text-sand-50 font-bold text-[10px] flex items-center gap-1 transition active:scale-95">
              <span class="material-symbols-outlined text-[12px]">content_copy</span>
              <span>Salin Teks</span>
            </button>
          </div>

          <!-- Dual Voice Selector Toggle -->
          <div class="grid grid-cols-2 p-0.5 bg-black/40 rounded-xl gap-1 text-[10px] font-bold">
            <button onclick="setDetailVoice('ayah')" class="py-1.5 px-2 rounded-lg transition ${currentDetailVoice === 'ayah' ? 'bg-pine-600 text-white shadow' : 'text-sand-300 hover:text-white'}">
              ${role1Label}
            </button>
            <button onclick="setDetailVoice('bunda')" class="py-1.5 px-2 rounded-lg transition ${currentDetailVoice === 'bunda' ? 'bg-pine-600 text-white shadow' : 'text-sand-300 hover:text-white'}">
              ${role2Label}
            </button>
          </div>

          <!-- Script Quote Box -->
          <div class="p-3 rounded-xl bg-white/10 backdrop-blur-sm border border-white/15">
            <p id="current-script-text" class="text-xs text-sand-100 italic leading-relaxed font-serif">
              "${currentDetailCase.scripts[currentDetailVoice]}"
            </p>
          </div>
          <p class="text-[9.5px] text-sand-300 text-center opacity-80">
            Katakan dengan nada suara tenang, tatapan lembut sejajar mata, tanpa emosi menuduh.
          </p>
        </div>

        <!-- 6. TINDAK LANJUT BERTAHAP SEPEKAN (MANHAJ TADARRUJ) -->
        <div class="p-3 rounded-2xl bg-sand-50 dark:bg-basalt-950 border border-sand-200 dark:border-basalt-800 space-y-1.5">
          <div class="flex items-center gap-1.5 text-basalt-800 dark:text-sand-200 font-bold text-[11px]">
            <span class="material-symbols-outlined text-[16px] text-pine-600">calendar_month</span>
            <span>6. TINDAK LANJUT SEPEKAN (HABIT LOOP RESTORASI)</span>
          </div>
          <ul class="text-[11px] text-basalt-700 dark:text-sand-300 space-y-1.5 list-disc pl-4 leading-relaxed">
            ${c.weeklyFollowup.map(wf => `<li>${wf}</li>`).join('')}
          </ul>
        </div>
      `;
    }

    function copyVerbatimScript() {
      if (!currentDetailCase) return;
      const scriptText = currentDetailCase.scripts[currentDetailVoice];
      navigator.clipboard.writeText(scriptText).then(() => {
        showCustomToast("✓ Kalimat verbatim berhasil disalin ke clipboard!");
      }).catch(() => {
        showCustomToast("✓ Script disalin: " + scriptText.slice(0, 30) + "...");
      });
    }

    function markTipPracticed() {
      if (!currentDetailCase) return;
      const id = currentDetailCase.id;
      if (practicedCases.includes(id)) {
        practicedCases = practicedCases.filter(x => x !== id);
        showCustomToast("Tanda praktik dibatalkan.");
        updatePracticeButtonState(false);
      } else {
        practicedCases.push(id);
        showCustomToast("🎉 Masya Allah! Anda mencatat 1 amalan karakter hari ini.");
        updatePracticeButtonState(true);
      }
      localStorage.setItem('pkn_practiced_cases', JSON.stringify(practicedCases));
    }

    function updatePracticeButtonState(isPracticed) {
      const btn = document.getElementById('tip-practice-btn');
      const label = document.getElementById('tip-practice-label');
      if (!btn || !label) return;
      if (isPracticed) {
        btn.className = "flex-1 py-3 px-3 rounded-2xl bg-ambercustom-600 hover:bg-ambercustom-700 text-white font-bold text-xs shadow-md transition flex items-center justify-center gap-1.5 active:scale-98";
        label.textContent = "Batalkan Tanda Praktik";
      } else {
        btn.className = "flex-1 py-3 px-3 rounded-2xl bg-pine-600 hover:bg-pine-700 text-white font-bold text-xs shadow-md transition flex items-center justify-center gap-1.5 active:scale-98";
        label.textContent = "Tandai Sudah Dipraktikkan ✓";
      }
    }

    function showCustomToast(message) {
      let toast = document.getElementById('pkn-global-toast');
      if (!toast) {
        toast = document.createElement('div');
        toast.id = 'pkn-global-toast';
        toast.className = 'fixed top-14 left-1/2 -translate-x-1/2 z-[999] px-4 py-2.5 rounded-2xl bg-basalt-900/95 text-sand-50 text-xs font-semibold shadow-2xl backdrop-blur-md border border-white/20 transition-all duration-300 pointer-events-none opacity-0 translate-y-[-10px]';
        document.body.appendChild(toast);
      }
      toast.textContent = message;
      toast.classList.remove('opacity-0', 'translate-y-[-10px]');
      toast.classList.add('opacity-100', 'translate-y-0');
      setTimeout(() => {
        toast.classList.remove('opacity-100', 'translate-y-0');
        toast.classList.add('opacity-0', 'translate-y-[-10px]');
      }, 2600);
    }
"""

# Update setP3kTarget in JS
old_set_p3k_target = """    function setP3kTarget(target) {
      p3kTarget = target;
      const tabAnak = document.getElementById('p3k-tab-anak');
      const tabOrtu = document.getElementById('p3k-tab-ortu');
      const viewAnak = document.getElementById('p3k-subview-anak');
      const viewOrtu = document.getElementById('p3k-subview-ortu');
      const badge = document.getElementById('p3k-target-badge');

      if (target === 'anak') {
        tabAnak.className = "py-2.5 px-3 rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 bg-white dark:bg-basalt-900 text-pine-700 dark:text-pine-300 shadow-sm";
        tabOrtu.className = "py-2.5 px-3 rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 text-basalt-500 dark:text-sand-400 hover:text-basalt-900";
        viewAnak.classList.remove('hidden');
        viewOrtu.classList.add('hidden');
        if (badge) {
          badge.textContent = '👶 Mode Anak';
          badge.className = 'text-pine-600 dark:text-pine-400 font-bold';
        }
      } else {
        tabOrtu.className = "py-2.5 px-3 rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 bg-white dark:bg-basalt-900 text-terracotta-600 dark:text-terracotta-400 shadow-sm";
        tabAnak.className = "py-2.5 px-3 rounded-xl text-xs font-bold transition flex items-center justify-center gap-1.5 text-basalt-500 dark:text-sand-400 hover:text-basalt-900";
        viewOrtu.classList.remove('hidden');
        viewAnak.classList.add('hidden');
        if (badge) {
          badge.textContent = '🧘 Mode Orang Tua';
          badge.className = 'text-terracotta-600 dark:text-terracotta-400 font-bold';
        }
      }
    }"""

new_set_p3k_target = """    function setP3kTarget(target) {
      p3kTarget = target;
      const tabAnak = document.getElementById('p3k-tab-anak');
      const tabOrtu = document.getElementById('p3k-tab-ortu');
      const tabGuru = document.getElementById('p3k-tab-guru');
      const viewAnak = document.getElementById('p3k-subview-anak');
      const viewOrtu = document.getElementById('p3k-subview-ortu');
      const viewGuru = document.getElementById('p3k-subview-guru');
      const badge = document.getElementById('p3k-target-badge');

      // Reset all views
      if (viewAnak) viewAnak.classList.add('hidden');
      if (viewOrtu) viewOrtu.classList.add('hidden');
      if (viewGuru) viewGuru.classList.add('hidden');

      const inactiveClass = "py-2 px-1 rounded-xl text-[11px] font-bold transition flex items-center justify-center gap-1 text-basalt-500 dark:text-sand-400 hover:text-basalt-900";

      if (tabAnak) tabAnak.className = inactiveClass;
      if (tabOrtu) tabOrtu.className = inactiveClass;
      if (tabGuru) tabGuru.className = inactiveClass;

      if (target === 'anak') {
        if (tabAnak) tabAnak.className = "py-2 px-1 rounded-xl text-[11px] font-bold transition flex items-center justify-center gap-1 bg-white dark:bg-basalt-900 text-pine-700 dark:text-pine-300 shadow-sm";
        if (viewAnak) viewAnak.classList.remove('hidden');
        if (badge) {
          badge.textContent = '👶 Mode Anak';
          badge.className = 'text-pine-600 dark:text-pine-400 font-bold';
        }
      } else if (target === 'ortu') {
        if (tabOrtu) tabOrtu.className = "py-2 px-1 rounded-xl text-[11px] font-bold transition flex items-center justify-center gap-1 bg-white dark:bg-basalt-900 text-terracotta-600 dark:text-terracotta-400 shadow-sm";
        if (viewOrtu) viewOrtu.classList.remove('hidden');
        if (badge) {
          badge.textContent = '🧘 Mode Orang Tua';
          badge.className = 'text-terracotta-600 dark:text-terracotta-400 font-bold';
        }
      } else if (target === 'guru') {
        if (tabGuru) tabGuru.className = "py-2 px-1 rounded-xl text-[11px] font-bold transition flex items-center justify-center gap-1 bg-white dark:bg-basalt-900 text-indigo-600 dark:text-indigo-400 shadow-sm";
        if (viewGuru) viewGuru.classList.remove('hidden');
        if (badge) {
          badge.textContent = '🏫 Mode Guru / Kelas';
          badge.className = 'text-indigo-600 dark:text-indigo-400 font-bold';
        }
      }
    }"""

if old_set_p3k_target in content:
    content = content.replace(old_set_p3k_target, new_set_p3k_target)
    print("✓ Successfully upgraded setP3kTarget in JS!")
else:
    print("! Warning: old_set_p3k_target not matched exactly as string.")

# Update p3kGoToStabil in JS
old_p3k_go_to_stabil = """    function p3kGoToStabil() {
      stopP3kBreathing();
      document.getElementById('p3k-view-genting').classList.add('hidden');
      document.getElementById('p3k-view-stabil').classList.remove('hidden');

      const stabilAnak = document.getElementById('p3k-stabil-anak');
      const stabilOrtu = document.getElementById('p3k-stabil-ortu');
      const stabilTitle = document.getElementById('p3k-stabil-title');

      if (p3kTarget === 'ortu') {
        if (stabilAnak) stabilAnak.classList.add('hidden');
        if (stabilOrtu) stabilOrtu.classList.remove('hidden');
        if (stabilTitle) {
          stabilTitle.textContent = 'Kondisi Stabil • Pemulihan Jiwa Orang Tua';
          stabilTitle.className = 'text-xs font-extrabold uppercase tracking-widest text-terracotta-600 dark:text-terracotta-400';
        }
      } else {
        if (stabilAnak) stabilAnak.classList.remove('hidden');
        if (stabilOrtu) stabilOrtu.classList.add('hidden');
        if (stabilTitle) {
          stabilTitle.textContent = 'Kondisi Stabil • Pemulihan Anak';
          stabilTitle.className = 'text-xs font-extrabold uppercase tracking-widest text-pine-600 dark:text-pine-400';
        }
      }
    }"""

new_p3k_go_to_stabil = """    function p3kGoToStabil() {
      stopP3kBreathing();
      document.getElementById('p3k-view-genting').classList.add('hidden');
      document.getElementById('p3k-view-stabil').classList.remove('hidden');

      const stabilAnak = document.getElementById('p3k-stabil-anak');
      const stabilOrtu = document.getElementById('p3k-stabil-ortu');
      const stabilGuru = document.getElementById('p3k-stabil-guru');
      const stabilTitle = document.getElementById('p3k-stabil-title');

      if (stabilAnak) stabilAnak.classList.add('hidden');
      if (stabilOrtu) stabilOrtu.classList.add('hidden');
      if (stabilGuru) stabilGuru.classList.add('hidden');

      if (p3kTarget === 'ortu') {
        if (stabilOrtu) stabilOrtu.classList.remove('hidden');
        if (stabilTitle) {
          stabilTitle.textContent = 'Kondisi Stabil • Pemulihan Jiwa Orang Tua';
          stabilTitle.className = 'text-xs font-extrabold uppercase tracking-widest text-terracotta-600 dark:text-terracotta-400';
        }
      } else if (p3kTarget === 'guru') {
        if (stabilGuru) stabilGuru.classList.remove('hidden');
        if (stabilTitle) {
          stabilTitle.textContent = 'Kondisi Stabil • Wibawa Kelas Berhasil';
          stabilTitle.className = 'text-xs font-extrabold uppercase tracking-widest text-indigo-600 dark:text-indigo-400';
        }
      } else {
        if (stabilAnak) stabilAnak.classList.remove('hidden');
        if (stabilTitle) {
          stabilTitle.textContent = 'Kondisi Stabil • Pemulihan Anak';
          stabilTitle.className = 'text-xs font-extrabold uppercase tracking-widest text-pine-600 dark:text-pine-400';
        }
      }
    }"""

if old_p3k_go_to_stabil in content:
    content = content.replace(old_p3k_go_to_stabil, new_p3k_go_to_stabil)
    print("✓ Successfully upgraded p3kGoToStabil in JS!")

# Append tips_js_data_and_logic before closing </script>
content = content.replace("  </script>\n</body>", tips_js_data_and_logic + "\n  </script>\n</body>")
print("✓ Appended TIPS_CASES dataset & handlers to script!")

with open(html_path, "w", encoding="utf-8") as f:
    f.write(content)

print("\n🚀 SUCCESS! prototype/preview-v3/index.html fully updated!")
