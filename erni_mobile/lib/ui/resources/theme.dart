import 'package:erni_mobile/ui/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

abstract class ColorSchemes {
  static const Color seed = Color(0xFF6750A4);

  static const Color darkBlue = Color(0xff033778);

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: darkBlue,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD6E2FF),
    onPrimaryContainer: Color(0xFF001A43),
    secondary: Color(0xFF02AADB),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFBDE9FF),
    onSecondaryContainer: Color(0xFF001F2A),
    tertiary: Color(0xFF895100),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDCB8),
    onTertiaryContainer: Color(0xFF2C1700),
    error: Color(0xFFB3261E),
    errorContainer: Color(0xFFF9DEDC),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410E0B),
    background: Color(0xFFFBFDFE),
    onBackground: Color(0xFF191C1D),
    surface: Color(0xFFFBFDFE),
    onSurface: Color(0xFF191C1D),
    surfaceVariant: Color(0xFFE7E0EC),
    onSurfaceVariant: Color(0xFF49454F),
    outline: Color(0xFF79747E),
    onInverseSurface: Color(0xFFEFF1F2),
    inverseSurface: Color(0xFF2E3132),
    inversePrimary: Color(0xFFACC7FF),
    shadow: Color(0xFF000000),
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFACC7FF),
    onPrimary: Color(0xFF002E6B),
    primaryContainer: Color(0xFF0C448E),
    onPrimaryContainer: Color(0xFFD6E2FF),
    secondary: Color(0xFF69D3FF),
    onSecondary: Color(0xFF003548),
    secondaryContainer: Color(0xFF004D66),
    onSecondaryContainer: Color(0xFFBDE9FF),
    tertiary: Color(0xFFFFB865),
    onTertiary: Color(0xFF492900),
    tertiaryContainer: Color(0xFF683C00),
    onTertiaryContainer: Color(0xFFFFDCB8),
    error: Color(0xFFF2B8B5),
    errorContainer: Color(0xFF8C1D18),
    onError: Color(0xFF601410),
    onErrorContainer: Color(0xFFF9DEDC),
    background: Color(0xFF191C1D),
    onBackground: Color(0xFFE1E3E4),
    surface: Color(0xFF191C1D),
    onSurface: Color(0xFFE1E3E4),
    surfaceVariant: Color(0xFF49454F),
    onSurfaceVariant: Color(0xFFCAC4D0),
    outline: Color(0xFF938F99),
    onInverseSurface: Color(0xFF191C1D),
    inverseSurface: Color(0xFFE1E3E4),
    inversePrimary: Color(0xFF305DA8),
    shadow: Color(0xFF000000),
  );
}

abstract class AppThemes {
  static AppThemeData get lightTheme => _baseTheme(ColorSchemes.light).copyWith(brightness: Brightness.light);

  static AppThemeData get darkTheme => _baseTheme(ColorSchemes.dark).copyWith(brightness: Brightness.dark);

  static AppThemeData _baseTheme(ColorScheme colorScheme) {
    return AppThemeData(
      brightness: colorScheme.brightness,
      edgeInsets: const EdgeInsetsData(
        containerPadding: EdgeInsets.all(24),
      ),
      rawDimensions: RawDimensionsData(
        cornerRadius: 24,
        maxWidth: 512,
      ),
    );
  }
}

abstract class MaterialAppThemes {
  static ThemeData get lightTheme => _createBaseTheme(AppThemes.lightTheme, ColorSchemes.light);

  static ThemeData get darkTheme => _createBaseTheme(AppThemes.darkTheme, ColorSchemes.dark);

  static ThemeData _createBaseTheme(AppThemeData base, ColorScheme colorScheme) {
    return ThemeData(
      extensions: [base],
      brightness: base.brightness,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        color: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        surfaceTintColor: colorScheme.surfaceTint,
        shadowColor: colorScheme.shadow,
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(base.rawDimensions.cornerRadius)),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(base.rawDimensions.cornerRadius),
            topRight: Radius.circular(base.rawDimensions.cornerRadius),
          ),
        ),
      ),
      visualDensity: VisualDensity.standard,
      fontFamily: 'Source Sans Pro',
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(base.rawDimensions.cornerRadius)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: colorScheme.secondary,
          minimumSize: const Size(80, 40),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(base.rawDimensions.cornerRadius)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          primary: colorScheme.secondary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(base.rawDimensions.cornerRadius)),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: colorScheme.secondary,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(base.rawDimensions.cornerRadius)),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 57,
          height: 1.1,
          letterSpacing: -0.25,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 45,
          height: 1.1,
          letterSpacing: 0,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 36,
          height: 1.1,
          letterSpacing: 0,
        ),
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 32,
          height: 1.1,
          letterSpacing: 0,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 28,
          height: 1.1,
          letterSpacing: 0,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 24,
          height: 1.1,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 22,
          height: 1.1,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 1.1,
          letterSpacing: 0.1,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.1,
          letterSpacing: 0.1,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.1,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          height: 1.1,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          height: 1.1,
          letterSpacing: 0.5,
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.1,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.1,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.1,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
