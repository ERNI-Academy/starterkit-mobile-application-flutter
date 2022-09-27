import 'dart:async';

import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/domain/services/async/delay_provider.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_checker.dart';
import 'package:erni_mobile/domain/services/ui/navigation_service.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashViewModel extends ViewModel {
  SplashViewModel(this._logger, this._navigationService, this._connectivityChecker, this._delayProvider) {
    _logger.logFor(this);
  }

  final AppLogger _logger;
  final NavigationService _navigationService;
  final ConnectivityChecker _connectivityChecker;
  final DelayProvider _delayProvider;

  @override
  Future<void> onInitialize([Object? parameter, Queries queries = const {}]) async {
    await _delayProvider.delay(1000);
    await _connectivityChecker.initialize();
    _navigationService.pushToNewRoot(RouteNames.home);
  }
}
