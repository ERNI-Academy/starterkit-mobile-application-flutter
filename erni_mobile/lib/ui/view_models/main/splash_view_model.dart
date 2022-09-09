import 'dart:async';

import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/ui/view_models/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashViewModel extends ViewModel {
  SplashViewModel(this._logger, this._navigationService) {
    _logger.logFor(this);
  }

  final AppLogger _logger;
  final NavigationService _navigationService;

  @override
  Future<void> onInitialize([Object? parameter, Queries queries = const {}]) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    await _navigationService.pushToNewRoot(RouteNames.home);
  }
}
