import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/view_models/app_life_cycle_aware_mixin.dart';

@injectable
class AppViewModel with AppLifeCycleAwareMixin {
  final Logger _logger;

  AppViewModel(this._logger) {
    _logger.logFor<AppViewModel>();
  }

  @override
  Future<void> onAppPaused() async {
    _logger.log(LogLevel.info, 'App paused');
  }

  @override
  Future<void> onAppResumed() async {
    _logger.log(LogLevel.info, 'App resumed');
  }

  @override
  Future<void> onAppInactive() async {
    _logger.log(LogLevel.info, 'App inactive');
  }

  @override
  Future<void> onAppDetached() async {
    _logger.log(LogLevel.info, 'App detached');
  }

  @override
  Future<void> onAppHidden() async {
    _logger.log(LogLevel.info, 'App hidden');
  }
}
