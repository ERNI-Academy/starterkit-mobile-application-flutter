import 'package:erni_mobile/business/models/authentication/password/change_password_contract.dart';
import 'package:erni_mobile/business/models/authentication/password/forgot_password_contract.dart';
import 'package:erni_mobile/business/models/authentication/password/reset_password_contract.dart';
import 'package:erni_mobile/business/models/authentication/password/set_initial_password_contract.dart';
import 'package:erni_mobile/data/web/apis/api.dart';
import 'package:erni_mobile/domain/apis/authentication/password_api.dart';

part 'password_api_impl.g.dart';

@LazySingleton(as: PasswordApi)
@RestApi()
abstract class PasswordApiImpl implements PasswordApi {
  @factoryMethod
  factory PasswordApiImpl(DioProvider dioProvider, @apiBaseUrl String baseUrl) =>
      _PasswordApiImpl(dioProvider.create(serviceName: 'PasswordApi'), baseUrl: baseUrl);

  @POST(ApiEndpoints.forgotPassword)
  @override
  Future<void> forgotPassword(@Body() ForgotPasswordContract contract);

  @POST(ApiEndpoints.resetPassword)
  @override
  Future<void> resetPassword(@Body() ResetPasswordContract contract);

  @POST(ApiEndpoints.setInitialPassword)
  @override
  Future<void> setInitialPassword(@Body() SetInitialPasswordContract contract);

  @PATCH(ApiEndpoints.changePassword)
  @override
  Future<void> changePassword(@AuthHeader() String authToken, @Body() ChangePasswordContract contract);
}
