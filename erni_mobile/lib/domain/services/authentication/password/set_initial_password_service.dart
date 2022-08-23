import 'package:erni_mobile/business/models/authentication/password/set_initial_password_entity.dart';

abstract class SetInitialPasswordService {
  Future<void> setInitialPassword(SetInitialPasswordEntity entity);
}
