import 'package:erni_mobile/business/models/authentication/login/user_login_contract.dart';
import 'package:erni_mobile/business/models/authentication/token/auth_token_contract.dart';

abstract class AuthApi {
  Future<AuthTokenContract> login(UserLoginContract request);

  Future<AuthTokenContract> refreshToken(String authToken);

  Future<void> logout(String authToken);
}
