import 'package:erni_mobile/business/models/authentication/password/set_password_entity.dart';

class SetInitialPasswordEntity extends SetPasswordEntity {
  const SetInitialPasswordEntity({
    required super.newPassword,
    required super.confirmPassword,
    required String confirmationCode,
  }) : super(confirmationCode: confirmationCode);
}
