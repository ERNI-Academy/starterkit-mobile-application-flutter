import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/data/api/dio_logging_interceptor.dart';
import 'package:starterkit_app/core/dependency_injection.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';

abstract class DioProvider {
  Dio create<T>();
}

@Injectable(as: DioProvider)
class DioProviderImpl implements DioProvider {
  static const _requestTimeOut = Duration(seconds: 30);

  final Logger _logger;
  final String _baseUrl;

  DioProviderImpl(this._logger, @appServerUrl this._baseUrl);

  @override
  Dio create<T>() {
    _logger.logFor<T>();

    return Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: _requestTimeOut,
        sendTimeout: _requestTimeOut,
        receiveTimeout: _requestTimeOut,
      ),
    )..interceptors.add(DioLoggingInterceptor(_logger));
  }
}
