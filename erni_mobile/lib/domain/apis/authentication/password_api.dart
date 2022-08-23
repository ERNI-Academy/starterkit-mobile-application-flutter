import 'package:erni_mobile/business/models/authentication/password/change_password_contract.dart';
import 'package:erni_mobile/business/models/authentication/password/forgot_password_contract.dart';
import 'package:erni_mobile/business/models/authentication/password/reset_password_contract.dart';
import 'package:erni_mobile/business/models/authentication/password/set_initial_password_contract.dart';

abstract class PasswordApi {
  Future<void> forgotPassword(ForgotPasswordContract contract);

  Future<void> resetPassword(ResetPasswordContract contract);

  Future<void> setInitialPassword(SetInitialPasswordContract contract);

  Future<void> changePassword(String authToken, ChangePasswordContract contract);
}
