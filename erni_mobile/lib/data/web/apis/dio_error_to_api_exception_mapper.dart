import 'package:dio/dio.dart';
import 'package:erni_mobile/domain/exceptions/api_exceptions.dart';

abstract class DioErrorToApiExceptionMapper {
  static ApiException map(DioError error) {
    final statusCode = error.response?.statusCode ?? 0;

    if (statusCode >= 200 && statusCode < 300) {
      throw RangeError('Status code in range 200-299');
    }

    final errorCode = _tryGetErrorCode(error.response?.data);

    if (statusCode >= 400 && statusCode < 500) {
      return statusCode == 401
          ? UnauthorizedException(error: error, errorCode: errorCode)
          : BadRequestException(error: error, errorCode: errorCode);
    } else if (statusCode >= 500 && statusCode < 600) {
      return ServerUnavailableException(error: error, errorCode: errorCode);
    }

    return ApiException(error: error, errorCode: errorCode);
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
