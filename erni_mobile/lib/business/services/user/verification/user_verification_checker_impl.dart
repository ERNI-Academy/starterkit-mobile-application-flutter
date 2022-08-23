import 'package:erni_mobile/common/constants/settings_keys.dart';
import 'package:erni_mobile/data/web/apis/api.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:erni_mobile/domain/services/user/verification/user_verification_checker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserVerificationChecker)
class UserVerificationCheckerImpl implements UserVerificationChecker {
  UserVerificationCheckerImpl(this._settingsService);

  final SettingsService _settingsService;

  @override
  bool get isUserVerified => _settingsService.getValue<bool>(SettingsKeys.isUserVerified) ?? false;
}
