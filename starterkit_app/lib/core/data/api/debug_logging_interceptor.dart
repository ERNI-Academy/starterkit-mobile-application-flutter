import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

class DebugLoggingInterceptor extends Interceptor {
  final Logger _logger;

  const DebugLoggingInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final tag = '[REQ#${shortHash(options)}]';
    final reqUri = options.uri;
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
    final tag = '[RES#${shortHash(response.requestOptions)}]';

    if (response.statusCode != null && response.statusMessage != null) {
      _logger.log(LogLevel.debug, '$tag Success: ${response.statusCode} ${response.statusMessage}');
    }

    _logBody(tag, response.data);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final tag = '[RES#${shortHash(err.requestOptions)}]';
    if (err.response?.statusCode != null && err.response?.statusMessage != null) {
      _logger.log(LogLevel.error, '$tag Failed: ${err.response?.statusCode} ${err.response?.statusMessage}');
    }

    super.onError(err, handler);
  }

  void _logBody(String tag, Object? body) {
    const encoder = JsonEncoder.withIndent('    ');

    if (body is Map || body is List) {
      _logger.log(LogLevel.debug, '$tag Body: ${encoder.convert(body)}');
    }
  }
}
