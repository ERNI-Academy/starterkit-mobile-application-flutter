// coverage:ignore-file

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/exceptions/api_exceptions.dart';
import 'package:erni_mobile/common/utils/extensions/string_extensions.dart';
import 'package:erni_mobile/domain/apis/dio_provider.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DioProvider)
class DioProviderImpl implements DioProvider {
  static const _requestTimeOutInMs = 30000;

  DioProviderImpl(this._logger);

  final AppLogger _logger;

  @override
  Dio create(String apiName) {
    final identityHash = describeIdentity(apiName).split('#').last;
    _logger.logForNamed('$apiName#$identityHash');

    return Dio(
      BaseOptions(
        connectTimeout: _requestTimeOutInMs,
        sendTimeout: _requestTimeOutInMs,
        receiveTimeout: _requestTimeOutInMs,
      ),
    )..interceptors.add(_DioLoggingInterceptor(_logger));
  }
}

class _DioLoggingInterceptor extends Interceptor {
  static const _jsonEncoder = JsonEncoder.withIndent('    ');

  _DioLoggingInterceptor(this._logger);

  final AppLogger _logger;
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    _startTime = DateTime.now();
    final reqUuid = _createUuidFromRequest(options);
    final reqTag = '[REQ#$reqUuid]';
    final reqUri = options.uri;

    _logger.log(LogLevel.info, '$reqTag Sending ${options.method.toUpperCase()} ${reqUri.path + reqUri.query}');
    _logger.log(LogLevel.info, '$reqTag Host: ${reqUri.host}');
    _logger.log(LogLevel.info, '$reqTag Scheme: ${reqUri.scheme.toUpperCase()}');

    if (options.headers.isNotEmpty) {
      options.headers.cast<String, String>().forEach((key, value) {
        final logLevel = key == 'Authorization' ? LogLevel.debug : LogLevel.info;
        _logger.log(logLevel, '$reqTag ${key.capitalize()}: $value');
      });
    }

    _logBody(reqTag, options.data);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    _logResponse(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    final reqUuid = _createUuidFromRequest(err.requestOptions);
    final resTag = '[RES#$reqUuid]';
    final response = err.response;

    if (response != null) {
      _logResponse(response);
    }

    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        final timeOutMessage = 'Failed: ${err.type.name.capitalize().split(RegExp('(?=[A-Z])')).join(' ')}';
        _logger.log(LogLevel.error, '$resTag $timeOutMessage');
        throw TimeoutException(timeOutMessage);
      default:
        break;
    }

    final exception = _errorToException(err);

    _logger.log(LogLevel.error, '$resTag ${exception.message}');

    throw exception;
  }

  void _logResponse(Response response) {
    final reqUuid = _createUuidFromRequest(response.requestOptions);
    final resTag = '[RES#$reqUuid]';
    _endTime = DateTime.now();

    final statusCode = response.statusCode ?? 0;
    final isSuccess = statusCode >= 200 && statusCode < 300;

    _logger.log(
      LogLevel.info,
      '$resTag ${isSuccess ? 'Success' : 'Failed'} ${response.statusCode} ${response.statusMessage}',
    );
    _logger.log(LogLevel.info, '$resTag Duration: ${_endTime.difference(_startTime)}');

    if (!response.headers.isEmpty) {
      response.headers.forEach((key, value) {
        _logger.log(LogLevel.info, '$resTag ${key.capitalize()}: ${value.join(',')}');
      });
    }

    _logBody(resTag, response.data);
  }

  void _logBody(String tag, Object? body) {
    if ((body is Map && body.isNotEmpty) || body is List) {
      final json = _jsonEncoder.convert(body);
      _logger.log(LogLevel.debug, '$tag Content:\r\n$json');
    } else if (body is String && body.isNotEmpty) {
      _logger.log(LogLevel.debug, '$tag Content: $body');
    }
  }

  static String _createUuidFromRequest(RequestOptions request) {
    final identity = describeIdentity(request);

    return identity.split('#').last;
  }

  static ApiException _errorToException(DioError error) {
    final statusCode = error.response?.statusCode ?? 0;
    final errorCode = _tryGetErrorCode(error.response?.data);

    if (statusCode >= 400 && statusCode < 500) {
      return statusCode == 401
          ? UnauthorizedException(error: error, errorCode: errorCode)
          : BadRequestException(error: error, errorCode: errorCode);
    } else if (statusCode >= 500 && statusCode < 600) {
      return ServerUnavailableException(error: error, errorCode: errorCode);
    } else {
      return ApiException(error: error, errorCode: errorCode);
    }
  }

  static String? _tryGetErrorCode(Object? response) {
    if (response == null || (response is String && response.isEmpty)) {
      return null;
    }

    final responseMap = (response as Map?)?.cast<String, Map<String, dynamic>>();

    if (responseMap != null) {
      return responseMap['error']?['code']?.toString();
    }

    return null;
  }
}
