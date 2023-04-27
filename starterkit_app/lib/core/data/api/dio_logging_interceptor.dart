import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

class DioLoggingInterceptor extends Interceptor {
  final Logger _logger;

  DioLoggingInterceptor(this._logger);

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
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final tag = '[RES#${shortHash(response.requestOptions)}]';
    _logger.log(LogLevel.debug, '$tag Success: ${response.statusCode} ${response.statusMessage}');
    _logBody(tag, response.data);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final tag = '[RES#${shortHash(err.requestOptions)}]';
    _logger.log(LogLevel.error, '$tag Failed: ${err.response?.statusCode} ${err.response?.statusMessage}');

    super.onError(err, handler);
  }

  void _logBody(String tag, Object? body) {
    const encoder = JsonEncoder.withIndent('    ');

    if (body is Map || body is List) {
      _logger.log(LogLevel.debug, '$tag Body: ${encoder.convert(body)}');
    }
  }
}
