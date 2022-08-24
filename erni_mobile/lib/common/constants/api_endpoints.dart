import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:erni_mobile_core/dependency_injection.dart';

abstract class ApiEndpoints {
  static const String users = '/users';
  static const String sendOtp = '$users/send-otp';
  static const String verifyOtp = '$users/verify-otp';

  static const String authentication = '/authentication';
  static const String login = authentication;
  static const String refreshToken = '$authentication/refresh-token';
  static const String logout = '$authentication/logout';
  static const String userProfile = '$authentication/profile';

  static const String password = '$authentication/password';
  static const String forgotPassword = '$password/forgot-password';
  static const String setInitialPassword = '$password/set-password';
  static const String resetPassword = '$password/reset-password';
  static const String changePassword = '$password/change-password';

  static final String baseUrl = '${ServiceLocator.instance<EnvironmentConfig>().appServerUrl}/api';
}
