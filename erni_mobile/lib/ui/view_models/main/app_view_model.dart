import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/ui/view_models/app_lifecycle_aware_mixin.dart';
import 'package:erni_mobile/ui/view_models/settings/app_settings_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppViewModel extends AppSettingsViewModel with AppLifeCycleAwareMixin {
  final AppLogger _logger;

  AppViewModel(this._logger, super.settingsService) {
    _logger.logFor(this);
  }

  @override
  Future<void> onAppPaused() {
    _logger.log(LogLevel.info, 'App paused');

    return super.onAppPaused();
  }

  @override
  Future<void> onAppResumed() {
    _logger.log(LogLevel.info, 'App resumed');

    return super.onAppResumed();
  }
}
