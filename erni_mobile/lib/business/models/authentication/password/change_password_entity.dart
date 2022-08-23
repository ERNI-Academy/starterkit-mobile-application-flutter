import 'package:erni_mobile/business/models/authentication/password/set_password_entity.dart';

class ChangePasswordEntity extends SetPasswordEntity {
  const ChangePasswordEntity({
    required this.email,
    required this.oldPassword,
    required super.newPassword,
    required super.confirmPassword,
  });

  final String email;
  final String oldPassword;
}
