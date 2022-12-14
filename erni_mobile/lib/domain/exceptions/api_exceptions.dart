// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:erni_mobile/domain/models/json/json_encodable_mixin.dart';

class ApiException extends DioError with JsonEncodableMixin {
  ApiException({required DioError error, this.errorCode})
      : super(requestOptions: error.requestOptions, response: error.response, error: error.error);

  final String? errorCode;

  int? get statusCode => response?.statusCode;

  String get method => requestOptions.method;

  Uri get uri => requestOptions.uri;

  String? get reasonPhrase => response?.statusMessage;

  Object? get responseBody => response?.data;

  @override
  Map<String, dynamic> toJson() {
    return <String, Object?>{
      'statusCode': statusCode,
      'method': method,
      'requestUrl': uri.toString(),
      'reasonPhrase': reasonPhrase,
      'responseBody': responseBody,
      'errorCode': errorCode,
      'errorMessage': error.toString(),
    };
  }
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({required super.error, super.errorCode});
}

class ServerUnavailableException extends ApiException {
  ServerUnavailableException({required super.error, super.errorCode});
}

class BadRequestException extends ApiException {
  BadRequestException({required super.error, super.errorCode});
}
