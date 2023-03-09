// coverage:ignore-file

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/utils/extensions/string_extensions.dart';
import 'package:erni_mobile/data/web/apis/dio_error_to_api_exception_mapper.dart';
import 'package:erni_mobile/domain/apis/dio_provider.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DioProvider)
class DioProviderImpl implements DioProvider {
  static const _requestTimeOut = Duration(seconds: 30);

  final AppLogger _logger;

  DioProviderImpl(this._logger);

  @override
  Dio createFor<T>() {
    _logger.logForNamed(T.toString());

    return Dio(
      BaseOptions(
        connectTimeout: _requestTimeOut,
        sendTimeout: _requestTimeOut,
        receiveTimeout: _requestTimeOut,
      ),
    )..interceptors.add(_DioLoggingInterceptor(_logger));
  }
}

class _DioLoggingInterceptor extends Interceptor {
  static const _jsonEncoder = JsonEncoder.withIndent('    ');

  final AppLogger _logger;
  late DateTime _startTime;
  late DateTime _endTime;

  _DioLoggingInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    _startTime = DateTime.now();
    final reqUuid = shortHash(options);
    final reqTag = '[REQ#$reqUuid]';
    final reqUri = options.uri;

    _logger.log(LogLevel.info, '$reqTag Sending ${options.method.toUpperCase()} ${reqUri.path + reqUri.query}');
    _logger.log(LogLevel.info, '$reqTag Host: ${reqUri.host}');
    _logger.log(LogLevel.info, '$reqTag Scheme: ${reqUri.scheme.toUpperCase()}');

    if (options.headers.isNotEmpty) {
      _logHeaders(reqTag, Headers.fromMap(options.headers.cast()));
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

    final reqUuid = shortHash(err.requestOptions);
    final resTag = '[RES#$reqUuid]';
    final response = err.response;

    if (response != null) {
      _logResponse(response);
    }

    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        final timeOutMessage = 'Failed: ${err.type.name.capitalize()}';
        _logger.log(LogLevel.error, '$resTag $timeOutMessage');
        handler.next(err);
        break;

      default:
        break;
    }

    final exception = DioErrorToApiExceptionMapper.map(err);

    if (exception.message != null) {
      _logger.log(LogLevel.error, '$resTag ${exception.message}');
    }

    handler.next(exception);
  }

  void _logResponse(Response response) {
    final reqUuid = shortHash(response.requestOptions);
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
      _logHeaders(resTag, response.headers);
    }

    _logBody(resTag, response.data);
  }

  void _logBody(String tag, Object? body) {
    if ((body is Map && body.isNotEmpty) || body is List) {
      final json = _jsonEncoder.convert(body);
      _logger.log(LogLevel.debug, '$tag Content:\r\n$json');
    } else if (body is String && body.isNotEmpty) {
      _logger.log(LogLevel.debug, '$tag Content: $body');
    } else if (body != null) {
      _logger.log(LogLevel.debug, '$tag Content: $body');
    }
  }

  void _logHeaders(String tag, Headers headers) {
    headers.forEach((key, value) {
      final logLevel = key == 'Authorization' ? LogLevel.debug : LogLevel.info;
      _logger.log(logLevel, '$tag ${key.capitalize()}: ${value.join(',')}');
    });
  }
}
