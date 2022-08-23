import 'package:erni_mobile/business/models/authentication/password/reset_password_entity.dart';

abstract class ResetPasswordService {
  Future<void> resetPassword(ResetPasswordEntity entity);
}
