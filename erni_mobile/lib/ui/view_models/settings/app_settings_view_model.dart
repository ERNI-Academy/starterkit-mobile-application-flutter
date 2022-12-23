import 'dart:async';

import 'package:erni_mobile/business/models/settings/app_settings.dart';
import 'package:erni_mobile/business/models/settings/language.dart';
import 'package:erni_mobile/business/models/settings/language_code.dart';
import 'package:erni_mobile/business/models/settings/settings_changed_model.dart';
import 'package:erni_mobile/common/constants/settings_keys.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:flutter/material.dart';

abstract class AppSettingsViewModel extends ViewModel {
  AppSettingsViewModel(this.settingsService);

  late final StreamSubscription _settingsSubscription;

  final ValueNotifier<Language> currentLanguage = ValueNotifier(const Language(LanguageCode.en));

  final ValueNotifier<ThemeMode> currentTheme = ValueNotifier(ThemeMode.light);

  @protected
  final SettingsService settingsService;

  @override
  @mustCallSuper
  Future<void> onInitialize() {
    updateAppSettings();
    _settingsSubscription = settingsService.settingsChanged.listen(onSettingsChanged);

    return super.onInitialize();
  }

  @override
  @mustCallSuper
  void dispose() {
    _settingsSubscription.cancel();
    super.dispose();
  }

  @protected
  @mustCallSuper
  void updateAppSettings() {
    final appSettings = _getAppSettings();
    currentLanguage.value = appSettings.language;
    currentTheme.value = appSettings.themeMode;
  }

  @protected
  @mustCallSuper
  void onSettingsChanged(SettingsChangedModel args) {
    final key = args.key;
    final value = args.value;

    if (key == SettingsKeys.appSettings && value is AppSettings) {
      currentTheme.value = value.themeMode;
      currentLanguage.value = value.language;
    }
  }

  AppSettings _getAppSettings() {
    return settingsService.getObject(
      SettingsKeys.appSettings,
      AppSettings.fromJson,
      defaultValue: const AppSettings(),
    )!;
  }
}
