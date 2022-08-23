import 'package:erni_mobile/domain/apis/authentication/auth_api.dart';
import 'package:erni_mobile/domain/services/authentication/logout/logout_service.dart';
import 'package:erni_mobile/domain/services/authentication/token/token_service.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LogoutService)
class LogoutServiceImpl implements LogoutService {
  LogoutServiceImpl(this._tokenService, this._settingsService, this._authApi);

  final TokenService _tokenService;
  final SettingsService _settingsService;
  final AuthApi _authApi;

  @override
  Future<void> logout() async {
    final authToken = await _tokenService.getAuthToken();
    await _authApi.logout(authToken);
    await _tokenService.clearAuthToken();
    await _settingsService.deleteAll();
  }
}
