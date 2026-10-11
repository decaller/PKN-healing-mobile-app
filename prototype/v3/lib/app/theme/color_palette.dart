import 'package:flutter/material.dart';

/// Earth-Tree palette shared by Material, Cupertino, and Forui.
class AppColors {
  AppColors._();

  static const Color lightBackground = Color(0xFFFDF9F0);
  static const Color lightSurface = Color(0xFFF7F3EA);
  static const Color lightSurfaceElevated = Color(0xFFE6E2DA);
  static const Color lightTextPrimary = Color(0xFF1C1C17);
  static const Color lightTextSecondary = Color(0xFF3F4850);
  static const Color lightTextMuted = Color(0xFF707881);
  static const Color lightBorder = Color(0xFFBFC7D2);
  static const Color lightPrimary = Color(0xFF006194);
  static const Color lightPrimarySoft = Color(0xFFCCE5FF);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightSecondary = Color(0xFF006D30);
  static const Color lightSecondaryContainer = Color(0xFF92F5A4);
  static const Color lightOnSecondaryContainer = Color(0xFF007233);
  static const Color lightTertiary = Color(0xFF7E5223);
  static const Color lightError = Color(0xFFBA1A1A);
  static const Color darkBackground = Color(0xFF161A1D);
  static const Color darkSurface = Color(0xFF1E2328);
  static const Color darkSurfaceElevated = Color(0xFF262D34);
  static const Color darkTextPrimary = Color(0xFFEFECE6);
  static const Color darkTextSecondary = Color(0xFFD3CEC4);
  static const Color darkTextMuted = Color(0xFFD3CEC4);
  static const Color darkBorder = Color(0xFF38404A);
  static const Color darkPrimary = Color(0xFF93CCFF);
  static const Color darkPrimarySoft = Color(0xFF004B73);
  static const Color darkOnPrimary = Color(0xFF001D31);
  static const Color darkSecondary = Color(0xFF79DB8D);
  static const Color darkSecondaryContainer = Color(0xFF005323);
  static const Color darkOnSecondaryContainer = Color(0xFF95F8A7);
  static const Color darkTertiary = Color(0xFFF6BB81);
  static const Color darkError = Color(0xFFFFB4AB);

  // Semantic category and rubric colors retain their existing meaning.
  static const Color lightPillar1 = Color(0xFF006194);
  static const Color lightPillar2 = Color(0xFF007BB9);
  static const Color lightPillar3 = Color(0xFF7E5223);
  static const Color lightPillar4 = Color(0xFF9A6A38);
  static const Color lightPillar5 = Color(0xFF006D30);
  static const Color lightPillar6 = Color(0xFF663E0F);
  static const Color darkPillar1 = Color(0xFF93CCFF);
  static const Color darkPillar2 = Color(0xFFCCE5FF);
  static const Color darkPillar3 = Color(0xFFF6BB81);
  static const Color darkPillar4 = Color(0xFFFFDCBE);
  static const Color darkPillar5 = Color(0xFF79DB8D);
  static const Color darkPillar6 = Color(0xFF9A6A38);
  static const Color brandPrimary = lightPrimary;
  static const Color pilarMulai = lightPillar1;
  static const Color pilarTumbuh = lightPillar2;
  static const Color pilarBakat = lightPillar3;
  static const Color pilarKeluarga = lightPillar4;
  static const Color pilarLembaga = lightPillar5;
  static const Color pilarDalil = lightPillar6;
  static const Color brandGold = Color(0xFF9A6A38);
  static const Color brandPrimaryDark = Color(0xFF004B73);
  static const Color brandAccent = lightSecondary;
  static const Color brandSecondary = lightTertiary;
  static const Color adabBT = lightError;
  static const Color adabMT = lightTertiary;
  static const Color adabBK = lightSecondary;
  static const Color adabMM = lightPrimary;
  static const Color calloutTldr = lightPrimary;
  static const Color calloutWarning = lightTertiary;
  static const Color calloutTip = lightSecondary;
  static const Color success = lightSecondary;
  static const Color error = lightError;
  static const Color warning = lightTertiary;
  static const Color info = lightPrimary;

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
