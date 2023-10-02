import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/api/debug_logging_interceptor.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/service_locator.dart';

@module
abstract class ApiModule {
  static const Duration _connectionTimeOut = Duration(seconds: 10);
  static const Duration _requestTimeOut = Duration(seconds: 30);
  static const Duration _sendTimeout = Duration(seconds: 10);

  @injectable
  Dio createDio(Logger logger, @appServerUrl String baseUrl) {
    logger.logFor<Dio>();

    return Dio(
      BaseOptions(
        connectTimeout: _connectionTimeOut,
        receiveTimeout: _requestTimeOut,
        sendTimeout: _sendTimeout,
        baseUrl: baseUrl,
      ),
    )..interceptors.add(DebugLoggingInterceptor(logger));
  }
}
