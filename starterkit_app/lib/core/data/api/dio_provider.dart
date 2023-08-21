import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/api/debug_logging_interceptor.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/service_locator.dart';

abstract interface class DioProvider {
  Dio create<T>();
}

@Injectable(as: DioProvider)
class DioProviderImpl implements DioProvider {
  static const _connectionTimeOut = Duration(seconds: 10);
  static const _requestTimeOut = Duration(seconds: 30);
  static const _sendTimeout = Duration(seconds: 10);

  final Logger _logger;
  final String _baseUrl;

  const DioProviderImpl(this._logger, @appServerUrl this._baseUrl);

  @override
  Dio create<T>() {
    _logger.logFor<T>();

    return Dio(
      BaseOptions(
        connectTimeout: _connectionTimeOut,
        receiveTimeout: _requestTimeOut,
        sendTimeout: _sendTimeout,
        baseUrl: _baseUrl,
      ),
    )..interceptors.add(DebugLoggingInterceptor(_logger));
  }
}
