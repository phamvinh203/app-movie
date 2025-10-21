import 'package:flutter/material.dart';

class AppColors {
  //  Core brand colors
  static const primary = Color(0xffE21221);
  static const primaryLight = Color(0xffF54B56);
  static const primaryDark = Color(0xffA50E18);

  //  Backgrounds
  static const background = Color(0xff1D1E22);
  static const secondBackground = Color(0xff181A20);
  static const cardBackground = Color(0xff24262B);
  static const surface = Color(0xff2A2C31);

  //  Text colors
  static const textPrimary = Color(0xffFFFFFF);
  static const textSecondary = Color(0xffB0B3B8);
  static const textDisabled = Color(0xff6E6E6E);
  static const textError = Color(0xffFF6B6B);

  //  Border & Divider
  static const border = Color(0xff3A3B3F);
  static const divider = Color(0xff2E2F33);

  //  State colors
  static const success = Color(0xff00C851);
  static const warning = Color(0xffFFBB33);
  static const error = Color(0xffFF4444);
  static const info = Color(0xff33B5E5);

  // Neutral gray scale (useful for text, icons, etc.)
  static const gray100 = Color(0xffF5F5F5);
  static const gray200 = Color(0xffE0E0E0);
  static const gray300 = Color(0xffBDBDBD);
  static const gray400 = Color(0xff9E9E9E);
  static const gray500 = Color(0xff757575);
  static const gray600 = Color(0xff616161);
  static const gray700 = Color(0xff424242);
  static const gray800 = Color(0xff303030);
  static const gray900 = Color(0xff212121);

  // 🔵 Accent / Secondary tones
  static const accentBlue = Color(0xff3B82F6);
  static const accentPurple = Color(0xff8B5CF6);
  static const accentGreen = Color(0xff22C55E);
  static const accentYellow = Color(0xffFACC15);
  static const accentPink = Color(0xffEC4899);

  // 🌈 Gradient helpers
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xffE21221), Color(0xffA50E18)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xff1D1E22), Color(0xff181A20)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xff00C851), Color(0xff007E33)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
