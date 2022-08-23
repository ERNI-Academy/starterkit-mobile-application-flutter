import 'package:erni_mobile/business/mappers/user/user_profile_mapper.dart';
import 'package:erni_mobile/business/models/user/user_profile_entity.dart';
import 'package:erni_mobile/common/constants/settings_keys.dart';
import 'package:erni_mobile/domain/apis/user/user_api.dart';
import 'package:erni_mobile/domain/services/authentication/token/token_service.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:erni_mobile/domain/services/user/profile/user_profile_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserProfileService)
class UserProfileServiceImpl implements UserProfileService {
  UserProfileServiceImpl(
    this._tokenService,
    this._settingsService,
    this._userProfileEntityFromContractMapper,
    this._userApi,
  );

  final TokenService _tokenService;
  final SettingsService _settingsService;
  final UserProfileEntityFromContractMapper _userProfileEntityFromContractMapper;
  final UserApi _userApi;

  @override
  Future<UserProfileEntity> getUserProfile({bool cached = false}) async {
    if (cached) {
      final cachedUserProfile = _settingsService.getObject(SettingsKeys.userProfile, UserProfileEntity.fromJson);

      if (cachedUserProfile != null) {
        return cachedUserProfile;
      }
    }

    return _internalGetUserProfile();
  }

  Future<UserProfileEntity> _internalGetUserProfile() async {
    final authToken = await _tokenService.getAuthToken();
    final contract = await _userApi.getUserProfile(authToken);
    final userProfile = _userProfileEntityFromContractMapper.fromContract(contract)!;
    await _settingsService.addOrUpdateObject(SettingsKeys.userProfile, userProfile);

    return userProfile;
  }
}
