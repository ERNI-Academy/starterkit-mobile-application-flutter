// coverage:ignore-file

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';

class DebugLoggingInterceptor extends Interceptor {
  final Logger _logger;

  const DebugLoggingInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String tag = '[REQ#${shortHash(options)}]';
    final Uri reqUri = options.uri;
    _logger
      ..log(LogLevel.debug, '$tag Sending ${options.method.toUpperCase()} ${reqUri.path + reqUri.query}')
      ..log(LogLevel.debug, '$tag Host: ${reqUri.host}')
      ..log(LogLevel.debug, '$tag Scheme: ${reqUri.scheme.toUpperCase()}');
    _logBody(tag, options.data);

    super.onRequest(options, handler);
  }

  @override
  // Ignored since we cannot change the override the signature of the method using `covariant`
  // ignore: avoid-dynamic
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final String tag = '[RES#${shortHash(response.requestOptions)}]';

    if (response.statusCode != null && response.statusMessage != null) {
      _logger.log(LogLevel.debug, '$tag Success: ${response.statusCode} ${response.statusMessage}');
    }

    _logBody(tag, response.data);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode != null && err.response?.statusMessage != null) {
      final String tag = '[RES#${shortHash(err.requestOptions)}]';
      _logger.log(LogLevel.error, '$tag Failed: ${err.response?.statusCode} ${err.response?.statusMessage}');
    }

    super.onError(err, handler);
  }

  void _logBody(String tag, Object? body) {
    if (body is Map || body is! List) {
      return;
    }

    const JsonEncoder encoder = JsonEncoder.withIndent('    ');
    _logger.log(LogLevel.debug, '$tag Body: ${encoder.convert(body)}');
  }
}
