import 'package:erni_mobile/business/models/authentication/password/set_password_entity.dart';

class ResetPasswordEntity extends SetPasswordEntity {
  const ResetPasswordEntity({
    required super.newPassword,
    required super.confirmPassword,
    required String confirmationCode,
  }) : super(confirmationCode: confirmationCode);
}
