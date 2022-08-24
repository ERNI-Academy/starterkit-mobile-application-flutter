import 'dart:async';

import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/settings/app_settings_entity.dart';
import 'package:erni_mobile/business/models/settings/language_code.dart';
import 'package:erni_mobile/business/models/settings/language_entity.dart';
import 'package:erni_mobile/common/constants/settings_keys.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/ui/view_models/settings/app_settings_view_model.dart';
import 'package:erni_mobile_core/mvvm.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAppSettingsViewModel extends AppSettingsViewModel {
  UpdateAppSettingsViewModel(this._logger, super.settingsService) {
    _logger.logFor(this);
  }

  final AppLogger _logger;

  late final AsyncRelayCommand toggleLanguageCommand = AsyncRelayCommand.withoutParam(_onToggleLanguage);

  late final AsyncRelayCommand toggleDarkThemeCommand = AsyncRelayCommand.withoutParam(_onToggleDarkTheme);

  Future<void> _onToggleLanguage() async {
    LanguageEntity newLanguage = const LanguageEntity(LanguageCode.en);

    if (currentLanguage.value.languageCode == LanguageCode.en) {
      newLanguage = const LanguageEntity(LanguageCode.de);
    } else if (currentLanguage.value.languageCode == LanguageCode.de) {
      newLanguage = const LanguageEntity(LanguageCode.en);
    }

    currentLanguage.value = newLanguage;

    await _updateSettings(currentLanguage.value, currentTheme.value);

    _logger.log(LogLevel.info, 'Language changed to ${newLanguage.toLocale()}');
  }

  Future<void> _onToggleDarkTheme() async {
    ThemeMode newTheme;

    switch (currentTheme.value) {
      case ThemeMode.dark:
        newTheme = ThemeMode.light;
        break;

      default:
        newTheme = ThemeMode.dark;
        break;
    }

    currentTheme.value = newTheme;

    await _updateSettings(currentLanguage.value, currentTheme.value);

    _logger.log(LogLevel.info, 'Theme changed to $newTheme');
  }

  Future<void> _updateSettings(LanguageEntity newLanguage, ThemeMode newTheme) async {
    await settingsService.addOrUpdateObject(SettingsKeys.appSettings, AppSettingsEntity(newLanguage, newTheme));
  }
}
