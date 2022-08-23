import 'package:erni_mobile/business/mappers/authentication/login/user_login_mapper.dart';
import 'package:erni_mobile/business/models/authentication/login/user_login_entity.dart';
import 'package:erni_mobile/common/constants/api_error_codes.dart';
import 'package:erni_mobile/common/constants/settings_keys.dart';
import 'package:erni_mobile/common/exceptions/api_exceptions.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/domain/apis/authentication/auth_api.dart';
import 'package:erni_mobile/domain/services/authentication/login/login_service.dart';
import 'package:erni_mobile/domain/services/authentication/token/jwt_decoder.dart';
import 'package:erni_mobile/domain/services/authentication/token/token_service.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginService)
class LoginServiceImpl implements LoginService {
  LoginServiceImpl(
    this._tokenService,
    this._settingsService,
    this._jwtDecoder,
    this._userLoginContracMapper,
    this._authApi,
  );

  final TokenService _tokenService;
  final JwtDecoder _jwtDecoder;
  final SettingsService _settingsService;
  final UserLoginContractFromEntityMapper _userLoginContracMapper;
  final AuthApi _authApi;

  @override
  Future<void> login(UserLoginEntity entity) async {
    try {
      final loginRequest = _userLoginContracMapper.fromEntity(entity)!;
      final authTokenResponse = await _authApi.login(loginRequest);
      await _updateAuthSettings(
        authTokenResponse.accessToken,
        isUserVerified: authTokenResponse.isAccountConfirmed,
      );
    } on UnauthorizedException catch (e) {
      switch (e.errorCode) {
        case ApiErrorCodes.accountLocked:
          throw AccountLockedException('Email: ${entity.email}');
        default:
          throw UserInvalidCredentials('Email: ${entity.email}');
      }
    }
  }

  Future<void> _updateAuthSettings(String accessToken, {required bool isUserVerified}) async {
    await _tokenService.saveAuthToken(accessToken);
    await _settingsService.addOrUpdateValue(SettingsKeys.isUserVerified, isUserVerified);

    final email = _jwtDecoder.getEmail(accessToken);
    await _settingsService.addOrUpdateValue(SettingsKeys.userEmail, email);

    final id = _jwtDecoder.getId(accessToken);
    await _settingsService.addOrUpdateValue(SettingsKeys.userId, id);

    await _settingsService.addOrUpdateValue(SettingsKeys.isUserLoggedIn, true);
  }
}
