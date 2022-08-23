import 'package:erni_mobile/business/models/user/user_profile_entity.dart';

abstract class UserProfileService {
  Future<UserProfileEntity> getUserProfile({bool cached = false});
}
