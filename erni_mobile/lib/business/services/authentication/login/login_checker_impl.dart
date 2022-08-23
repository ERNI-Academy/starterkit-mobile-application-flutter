import 'package:erni_mobile/common/constants/settings_keys.dart';
import 'package:erni_mobile/domain/services/authentication/login/login_checker.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginChecker)
class LoginCheckerImpl implements LoginChecker {
  LoginCheckerImpl(this._settingsService);

  final SettingsService _settingsService;

  @override
  bool get isUserLoggedIn => _settingsService.getValue(SettingsKeys.isUserLoggedIn) ?? false;
}
