// coverage:ignore-file

import 'package:erni_mobile/ui/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  AppThemeData get appTheme => Theme.of(this).extension<AppThemeData>()!;

  ThemeData get materialTheme => Theme.of(this);
}
