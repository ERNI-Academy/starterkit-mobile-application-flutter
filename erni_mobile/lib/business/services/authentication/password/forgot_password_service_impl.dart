import 'package:erni_mobile/business/models/authentication/password/forgot_password_contract.dart';
import 'package:erni_mobile/common/constants/api_error_codes.dart';
import 'package:erni_mobile/common/exceptions/api_exceptions.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/domain/apis/authentication/password_api.dart';
import 'package:erni_mobile/domain/services/authentication/password/forgot_password_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgotPasswordService)
class ForgotPasswordServiceImpl implements ForgotPasswordService {
  ForgotPasswordServiceImpl(this._passwordApi);

  final PasswordApi _passwordApi;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _passwordApi.forgotPassword(ForgotPasswordContract(email));
    } on ApiException catch (e) {
      switch (e.errorCode) {
        case ApiErrorCodes.accountUserNotFound:
          throw const UserNotFoundException();
        case ApiErrorCodes.accountMaximumResetPasswordAttemptExceeded:
          throw const AccountMaximumResetPasswordAttemptException();
        default:
          rethrow;
      }
    }
  }
}
