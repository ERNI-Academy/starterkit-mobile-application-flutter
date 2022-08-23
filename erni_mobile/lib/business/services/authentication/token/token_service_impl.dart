import 'package:erni_mobile/common/constants/storage_keys.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/domain/services/authentication/token/token_service.dart';
import 'package:erni_mobile/domain/services/settings/secure_settings_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenService)
class TokenServiceImpl implements TokenService {
  TokenServiceImpl(this._secureSettingsService);

  final SecureSettingsService _secureSettingsService;

  @override
  Future<String> getAuthToken() async {
    final authToken = await _secureSettingsService.getValue(StorageKeys.authToken);

    if (authToken == null || authToken.isEmpty) {
      throw const AuthTokenInvalidException('authToken is null or empty');
    }

    return 'Bearer $authToken';
  }

  @override
  Future<void> saveAuthToken(String authToken) async {
    assert(authToken.isNotEmpty);
    await _secureSettingsService.addOrUpdateValue(StorageKeys.authToken, authToken);
  }

  @override
  Future<void> clearAuthToken() => _secureSettingsService.delete(StorageKeys.authToken);
}
