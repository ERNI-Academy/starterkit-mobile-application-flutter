import 'package:erni_mobile/business/models/authentication/login/user_login_entity.dart';

abstract class LoginService {
  Future<void> login(UserLoginEntity entity);
}
