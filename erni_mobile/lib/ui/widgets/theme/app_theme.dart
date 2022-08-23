// coverage:ignore-file

import 'package:flutter/material.dart';

class AppThemeData extends ThemeExtension<AppThemeData> {
  const AppThemeData({
    required this.brightness,
    required this.edgeInsets,
    required this.rawDimensions,
  });

  final Brightness brightness;
  final EdgeInsetsData edgeInsets;
  final RawDimensionsData rawDimensions;

  @override
  AppThemeData copyWith({
    Brightness? brightness,
    EdgeInsetsData? edgeInsets,
    RawDimensionsData? rawDimensions,
  }) {
    return AppThemeData(
      brightness: brightness ?? this.brightness,
      edgeInsets: edgeInsets ?? this.edgeInsets,
      rawDimensions: rawDimensions ?? this.rawDimensions,
    );
  }

  @override
  ThemeExtension<AppThemeData> lerp(ThemeExtension<AppThemeData>? other, double t) {
    return this;
  }
}

class EdgeInsetsData {
  const EdgeInsetsData({required this.containerPadding});

  final EdgeInsets containerPadding;
}

class RawDimensionsData {
  RawDimensionsData({required this.maxWidth, required this.cornerRadius});

  final double maxWidth;
  final double cornerRadius;
}
