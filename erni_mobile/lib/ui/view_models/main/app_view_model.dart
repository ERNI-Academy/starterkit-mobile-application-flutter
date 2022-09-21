import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/ui/view_models/app_lifecycle_aware_mixin.dart';
import 'package:erni_mobile/ui/view_models/settings/app_settings_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppViewModel extends AppSettingsViewModel with AppLifeCycleAwareMixin {
  AppViewModel(this._logger, super.settingsService) {
    _logger.logFor(this);
  }

  final AppLogger _logger;

  @override
  Future<void> onAppPaused() async {
    _logger.log(LogLevel.info, 'App paused');
  }

  @override
  Future<void> onAppResumed() async {
    _logger.log(LogLevel.info, 'App resumed');
  }
}
