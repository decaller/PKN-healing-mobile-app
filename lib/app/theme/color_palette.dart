import 'package:flutter/material.dart';

/// PKN Color palette designed for high legibility, Nabawiyah executive elegance,
/// qualitative adab indicators (BT, MT, BK, MM), and 6 Pilar MOC categorization.
class AppColors {
  AppColors._();

  // Dark Mode Neutrals
  static const Color darkBackground = Color(0xFF0B132B); // Deep Nabawi Slate
  static const Color darkSurface = Color(0xFF151D3B);
  static const Color darkSurfaceElevated = Color(0xFF1C274C);
  static const Color darkBorder = Color(0xFF2A3764);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // Light Mode Neutrals
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);

  // Brand & Accent Colors (Nabawiyah Theme)
  static const Color brandGold = Color(0xFFD4AF37); // Nabawi Gold
  static const Color brandPrimary = Color(0xFF0D9488); // Deep Teal / Fitrah Emerald
  static const Color brandPrimaryDark = Color(0xFF0F766E);
  static const Color brandAccent = Color(0xFF10B981); // Emerald Green
  static const Color brandSecondary = Color(0xFF6366F1); // Indigo

  // Qualitative Adab Rubric Colors (BT - MT - BK - MM)
  static const Color adabBT = Color(0xFFEF4444); // 🔴 Belum Terlihat
  static const Color adabMT = Color(0xFFF59E0B); // 🟡 Mulai Terlihat
  static const Color adabBK = Color(0xFF10B981); // 🟢 Berkembang Konsisten
  static const Color adabMM = Color(0xFF3B82F6); // 🔵 Membudaya Mandiri

  // Callout Box Backgrounds & Accents
  static const Color calloutTldr = Color(0xFF0D9488); // TL;DR 10 Detik
  static const Color calloutWarning = Color(0xFFF59E0B); // Batas Toleransi Syar'i
  static const Color calloutTip = Color(0xFF10B981); // Resep Praktis

  // Status & Interactive Feedback
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // 6 Pilar MOC & Domain Accent Colors
  static const Color pilarMulai = Color(0xFF6366F1); // P1: Mulai di Sini (Indigo)
  static const Color pilarTumbuh = Color(0xFF0EA5E9); // P2: Fase Tumbuh Kembang (Sky Blue)
  static const Color pilarBakat = Color(0xFF8B5CF6); // P3: Fitrah & Bakat TB-40 (Purple)
  static const Color pilarKeluarga = Color(0xFFF43F5E); // P4: Praktik Keluarga (Rose/Coral)
  static const Color pilarLembaga = Color(0xFF10B981); // P5: Lembaga & Guru (Emerald)
  static const Color pilarDalil = Color(0xFFD4AF37); // P6: Khazanah Dalil (Gold)

  // Backward compatibility / Domain mapping
  static Color getDomainColor(String domain) {
    switch (domain.toLowerCase()) {
      case 'mulai di sini':
      case 'p1':
      case 'manhaj':
        return pilarMulai;
      case 'fase tumbuh kembang':
      case 'p2':
      case 'perkembangan':
      case 'usia':
        return pilarTumbuh;
      case 'fitrah & bakat':
      case 'tb-40':
      case 'p3':
      case 'bakat':
      case 'syakilah':
      case 'strategy':
        return pilarBakat;
      case 'praktik keluarga':
      case 'p4':
      case 'keluarga':
      case 'parenting':
      case 'marketing':
      case 'leadership':
        return pilarKeluarga;
      case 'lembaga & guru':
      case 'p5':
      case 'pendidik':
      case 'kbm':
      case 'finance':
        return pilarLembaga;
      case 'khazanah dalil':
      case 'p6':
      case 'dalil':
      case 'product':
      default:
        return pilarDalil;
    }
  }

  static Color getAdabColor(String level) {
    switch (level.toUpperCase()) {
      case 'BT':
        return adabBT;
      case 'MT':
        return adabMT;
      case 'BK':
        return adabBK;
      case 'MM':
        return adabMM;
      default:
        return brandPrimary;
    }
  }
}
