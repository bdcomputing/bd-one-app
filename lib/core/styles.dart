import 'package:flutter/material.dart';

// App Color Palette - Synchronized with Tailwind Config
class AppColors {
  // Primary Colors (Teal/Cyan from Tailwind)
  static const Color primary = Color(0xFF0C3A37); // primary.DEFAULT
  static const Color primary50 = Color(0xFFB9FDF9);
  static const Color primary100 = Color(0xFF58F9F2);
  static const Color primary200 = Color(0xFF4DDDD7);
  static const Color primary300 = Color(0xFF42C0BA);
  static const Color primary400 = Color(0xFF36A29E);
  static const Color primary500 = Color(0xFF2C8985);
  static const Color primary600 = Color(0xFF226E6B);
  static const Color primary700 = Color(0xFF185451);
  static const Color primary800 = Color(0xFF0F3D3B);
  static const Color primary900 = Color(0xFF052220);
  static const Color primary950 = Color(0xFF031615);
  static const Color primaryDark = Color(0xFF052220); // primary.900

  // Secondary Colors (Green from Tailwind)
  static const Color secondary = Color(0xFF34B44B); // secondary.DEFAULT
  static const Color secondary50 = Color(0xFFD6FEDA);
  static const Color secondary100 = Color(0xFF92FC9F);
  static const Color secondary200 = Color(0xFF46E963);
  static const Color secondary300 = Color(0xFF3DD058);
  static const Color secondary400 = Color(0xFF34B44B);
  static const Color secondary500 = Color(0xFF29943C);
  static const Color secondary600 = Color(0xFF1E752E);
  static const Color secondary700 = Color(0xFF145720);
  static const Color secondary800 = Color(0xFF0C3D15);
  static const Color secondary900 = Color(0xFF042309);
  static const Color secondary950 = Color(0xFF021504);
  static const Color secondaryDark = Color(0xFF1E752E); // secondary.600

  // Accent Colors (Lime from Tailwind)
  static const Color accent = Color(0xFFE6FD49); // accent.DEFAULT
  static const Color accent50 = Color(0xFFE6FD49);
  static const Color accent100 = Color(0xFFDBF146);
  static const Color accent200 = Color(0xFFC0D43C);
  static const Color accent300 = Color(0xFFA6B733);
  static const Color accent400 = Color(0xFF8C9B29);
  static const Color accent500 = Color(0xFF748021);
  static const Color accent600 = Color(0xFF5C6618);
  static const Color accent700 = Color(0xFF434B0F);
  static const Color accent800 = Color(0xFF2E3308);
  static const Color accent900 = Color(0xFF1A1E03);
  static const Color accent950 = Color(0xFF101201);

  // Sage Colors (Neutral/Earth tones)
  static const Color sage50 = Color(0xFFF4F4F1);
  static const Color sage100 = Color(0xFFE7E8DF);
  static const Color sage200 = Color(0xFFD0D3C3);
  static const Color sage300 = Color(0xFFB2B79F);
  static const Color sage400 = Color(0xFF979D7F);
  static const Color sage500 = Color(0xFF798062);
  static const Color sage600 = Color(0xFF5F654B);
  static const Color sage700 = Color(0xFF4A4F3C);
  static const Color sage800 = Color(0xFF3D4133);
  static const Color sage900 = Color(0xFF36392E);
  static const Color sage950 = Color(0xFF1B1D16);

  // Coal Colors (Dark theme)
  static const Color coal100 = Color(0xFF15171C);
  static const Color coal200 = Color(0xFF13141A);
  static const Color coal300 = Color(0xFF111217);
  static const Color coal400 = Color(0xFF0F1014);
  static const Color coal500 = Color(0xFF0D0E12);
  static const Color coal600 = Color(0xFF0B0C10);
  static const Color coalBlack = Color(0xFF000000);

  // Semantic Colors
  static const Color background = Colors.white;
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);
  static const Color success = secondary; // Use secondary green for success
  static const Color warning = Color(0xFFF59E0B);
  static const Color dark = Color(0xFF212328);

  // Text Colors
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnPrimary = Colors.white;
  static const Color border = Color(0xFFE0E0E0);
}

// Spacing Scale
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

// Border Radius Scale
class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 9999.0;
}

/// Responsive text scale helper
double responsiveFontSize(BuildContext context, double baseSize) {
  final width = MediaQuery.of(context).size.width;
  // Example breakpoints: <360: small, <480: medium, else: large
  if (width < 360) {
    return baseSize * 0.82;
  } else if (width < 480) {
    return baseSize * 0.92;
  } else {
    return baseSize;
  }
}

/// Responsive Text Styles
class AppTextStyles {
  static TextStyle headline1(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(context, 22),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static TextStyle headline2(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(context, 18),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static TextStyle subtitle1(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(context, 15),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static TextStyle body1(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(context, 13),
    color: AppColors.textPrimary,
  );
  static TextStyle body2(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(context, 12),
    color: AppColors.textSecondary,
  );
  static TextStyle button(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(context, 13),
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 1.0,
  );
  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(context, 10),
    color: AppColors.textSecondary,
  );
}

// Responsive ThemeData builder
ThemeData appTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.compact,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: AppColors.primaryDark,
      onPrimaryContainer: AppColors.textOnPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnPrimary,
      secondaryContainer: AppColors.secondaryDark,
      onSecondaryContainer: AppColors.textOnPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.headline1(context),
      displayMedium: AppTextStyles.headline2(context),
      titleMedium: AppTextStyles.subtitle1(context),
      bodyLarge: AppTextStyles.body1(context),
      bodyMedium: AppTextStyles.body2(context),
      labelLarge: AppTextStyles.button(context),
      bodySmall: AppTextStyles.caption(context),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: 0,
      titleTextStyle: AppTextStyles.headline2(context),
      iconTheme: const IconThemeData(color: AppColors.textOnPrimary, size: 20),
      toolbarHeight: 40,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(64, 32),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        textStyle: AppTextStyles.button(context),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
      ),
      labelStyle: TextStyle(
        color: AppColors.textSecondary,
        fontSize: responsiveFontSize(context, 12),
      ),
    ),
  );
}
