import 'package:erni_mobile/domain/models/entities/entity.dart';

class UserLoginEntity implements Entity {
  const UserLoginEntity({required this.email, required this.password});

  final String email;
  final String password;
}
