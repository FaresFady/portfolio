import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Global theme mode notifier for Dark / Light mode switching.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

class AppColors {
  AppColors._();

  static bool get isDark => themeNotifier.value == ThemeMode.dark;

  static Color get background => isDark ? const Color(0xFF10161D) : const Color(0xFFF8FAFC);
  static Color get panel => isDark ? const Color(0xFF171F27) : const Color(0xFFFFFFFF);
  static Color get panelAlt => isDark ? const Color(0xFF131A21) : const Color(0xFFF1F5F9);
  static Color get line => isDark ? const Color(0x17EDEFEF) : const Color(0xFFE2E8F0);
  static Color get text => isDark ? const Color(0xFFEDEFEF) : const Color(0xFF0F172A);
  static Color get muted => isDark ? const Color(0xFF93A2AC) : const Color(0xFF475569);
  static Color get accent => isDark ? const Color(0xFFE8A33D) : const Color(0xFFD97706);
  static Color get accentSoft => isDark ? const Color(0xFFF2C777) : const Color(0xFFB45309);
  static Color get stackText => isDark ? const Color(0xFFC9B99A) : const Color(0xFF78350F);
  static const Color primaryBtnText = Color(0xFF1B1304);
  static Color get navBackground => isDark ? const Color(0xDC10161D) : const Color(0xF5FFFFFF);
  static const Color success = Color(0xFF22C55E); // Glowing green for availability
  static const Color flutterBlue = Color(0xFF04A9F4);
  static Color get inputBackground => isDark ? const Color(0xFF131A21) : const Color(0xFFFFFFFF);
  static Color get cardBorder => isDark ? const Color(0x1FEDEFEF) : const Color(0xFFE2E8F0);
  static Color get cardBorderHover => isDark ? const Color(0x66E8A33D) : const Color(0xFFD97706);
  static Color get accentGlow => isDark ? const Color(0x33E8A33D) : const Color(0x22D97706);

  static List<BoxShadow> get cardShadow => isDark
      ? const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ]
      : const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 14,
            offset: Offset(0, 3),
          ),
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ];
}

class AppTypography {
  AppTypography._();

  static TextStyle heading({
    double fontSize = 30,
    FontWeight fontWeight = FontWeight.w500,
    Color? color,
    double? height,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.fraunces(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.text,
      letterSpacing: -0.01 * fontSize,
      height: height,
      fontStyle: fontStyle,
    );
  }

  static TextStyle body({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double height = 1.6,
  }) {
    return GoogleFonts.ibmPlexSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.text,
      height: height,
    );
  }

  static TextStyle mono({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.ibmPlexMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.accent,
      height: height,
    );
  }
}

class AppDimensions {
  AppDimensions._();

  static const double maxContentWidth = 1080.0;
  static const double mobileBreakpoint = 780.0;
  static const double desktopHorizontalPadding = 32.0;
  static const double mobileHorizontalPadding = 20.0;
  static const double navHeight = 72.0;
}

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    canvasColor: const Color(0xFFF8FAFC),
    textTheme: GoogleFonts.ibmPlexSansTextTheme(
      ThemeData(brightness: Brightness.light).textTheme,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF10161D),
    canvasColor: const Color(0xFF10161D),
    textTheme: GoogleFonts.ibmPlexSansTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
  );
}

