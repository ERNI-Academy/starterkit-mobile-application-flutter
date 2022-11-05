// coverage:ignore-file

import 'package:erni_mobile/domain/exceptions/base_exception.dart';

abstract class DomainException extends BaseException {
  const DomainException([this.message]);

  final String? message;

  @override
  Map<String, dynamic> toJson() {
    return <String, Object?>{
      'message': message,
    };
  }
}

class NoInternetException extends DomainException {
  const NoInternetException();
}
