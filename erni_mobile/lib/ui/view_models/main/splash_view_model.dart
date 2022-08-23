import 'dart:async';

import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/common/utils/extensions/function_extensions.dart';
import 'package:erni_mobile/domain/services/authentication/login/login_checker.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_service.dart';
import 'package:erni_mobile/domain/services/platform/deep_link_service.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile/domain/services/user/verification/user_verification_checker.dart';
import 'package:erni_mobile_blueprint_core/mvvm.dart';
import 'package:erni_mobile_blueprint_core/navigation.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashViewModel extends ViewModel {
  SplashViewModel(
    this._logger,
    this._navigationService,
    this._dialogService,
    this._connectivityService,
    this._deepLinkService,
    this._loginChecker,
    this._userVerificationChecker,
  ) {
    _logger.logFor(this);
  }

  final AppLogger _logger;
  final NavigationService _navigationService;
  final DialogService _dialogService;
  final ConnectivityService _connectivityService;
  final DeepLinkService _deepLinkService;
  final LoginChecker _loginChecker;
  final UserVerificationChecker _userVerificationChecker;

  @override
  Future<void> onInitialize([Object? parameter, Queries queries = const {}]) async {
    await _tryCheckUserIsLoggedInAndVerified();
    await _tryNavigateToInitialLink();
  }

  Future<void> _tryCheckUserIsLoggedInAndVerified() async {
    final isConnected = await _connectivityService.isConnected();

    if (!isConnected) {
      await _navigationService.pushToNewRoot(RouteNames.login);

      return;
    }

    try {
      if (_loginChecker.isUserLoggedIn) {
        if (!_userVerificationChecker.isUserVerified) {
          unawaited(
            _dialogService.alert(
              Il8n.current.dialogUserNotVerifiedMessage,
              title: Il8n.current.dialogUserNotVerifiedTitle,
            ),
          );
          await _navigationService.pushToNewRoot(RouteNames.login);

          return;
        }

        await _navigationService.pushToNewRoot(RouteNames.home);

        return;
      }

      await _navigationService.pushToNewRoot(RouteNames.login);
    } catch (err, st) {
      _logger.log(LogLevel.error, '${_tryCheckUserIsLoggedInAndVerified.name} failed', err, st);
      await _navigationService.pushToNewRoot(RouteNames.login);
    }
  }

  Future<void> _tryNavigateToInitialLink() async {
    final initialLink = await _deepLinkService.getInitialLink();

    if (initialLink != null && initialLink.canNavigateToRoute) {
      _logger.log(LogLevel.info, 'App launched using link $initialLink');
      await _navigationService.push(initialLink.navigatableRoute, queries: initialLink.queries);
    }
  }
}
