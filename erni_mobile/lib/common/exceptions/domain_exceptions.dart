// coverage:ignore-file

import 'package:erni_mobile/common/exceptions/base_exception.dart';

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

class NoInternetException implements Exception {
  const NoInternetException();
}
