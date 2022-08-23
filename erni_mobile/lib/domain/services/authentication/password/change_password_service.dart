import 'package:erni_mobile/business/models/authentication/password/change_password_entity.dart';

abstract class ChangePasswordService {
  Future<void> changePassword(ChangePasswordEntity entity);
}
