import 'package:erni_mobile/business/models/user/user_profile_contract.dart';

abstract class UserApi {
  Future<UserProfileContract> getUserProfile(String authToken);
}
