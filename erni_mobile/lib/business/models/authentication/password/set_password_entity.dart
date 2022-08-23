import 'package:erni_mobile/domain/models/entities/entity.dart';

abstract class SetPasswordEntity implements Entity {
  const SetPasswordEntity({required this.newPassword, required this.confirmPassword, this.confirmationCode});

  final String newPassword;
  final String confirmPassword;
  final String? confirmationCode;
}
