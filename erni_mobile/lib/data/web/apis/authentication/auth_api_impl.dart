import 'package:erni_mobile/business/models/authentication/login/user_login_contract.dart';
import 'package:erni_mobile/business/models/authentication/token/auth_token_contract.dart';
import 'package:erni_mobile/data/web/apis/api.dart';
import 'package:erni_mobile/domain/apis/authentication/auth_api.dart';

part 'auth_api_impl.g.dart';

@LazySingleton(as: AuthApi)
@RestApi()
abstract class AuthApiImpl implements AuthApi {
  @factoryMethod
  factory AuthApiImpl(DioProvider dioProvider, @apiBaseUrl String baseUrl) =>
      _AuthApiImpl(dioProvider.create(serviceName: 'AuthApi'), baseUrl: baseUrl);

  @POST(ApiEndpoints.login)
  @override
  Future<AuthTokenContract> login(@Body() UserLoginContract request);

  @POST(ApiEndpoints.refreshToken)
  @override
  Future<AuthTokenContract> refreshToken(@AuthHeader() String authToken);

  @POST(ApiEndpoints.logout)
  @override
  Future<void> logout(@AuthHeader() String authToken);
}
