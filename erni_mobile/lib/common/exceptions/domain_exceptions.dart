// coverage:ignore-file

import 'package:erni_mobile/common/exceptions/base_exception.dart';

export 'package:erni_mobile_blueprint_core/utils.dart' show NoInternetException;

class DomainException extends BaseException {
  const DomainException([this.message]);

  final String? message;

  @override
  Map<String, dynamic> toJson() {
    return <String, Object?>{
      'message': message,
    };
  }
}

class SessionInvalidException extends DomainException {
  const SessionInvalidException([super.message]);
}

class AuthTokenInvalidException extends SessionInvalidException {
  const AuthTokenInvalidException([super.message]);
}

class UserInvalidCredentials extends DomainException {
  const UserInvalidCredentials([super.message]);
}

class UserNotFoundException extends DomainException {
  const UserNotFoundException([super.message]);
}

class AccountMaximumResetPasswordAttemptException extends DomainException {
  const AccountMaximumResetPasswordAttemptException([super.message]);
}

class LinkUsedOrExpiredException extends DomainException {
  const LinkUsedOrExpiredException([super.message]);
}

class AccountLockedException extends DomainException {
  const AccountLockedException([super.message]);
}

class AccountAlreadyConfirmedException extends DomainException {
  const AccountAlreadyConfirmedException([super.message]);
}

class AccountOldPasswordMismatchException extends DomainException {
  const AccountOldPasswordMismatchException([super.message]);
}
