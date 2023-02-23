import 'package:dio/dio.dart';
import 'package:erni_mobile/data/web/apis/dio_error_to_api_exception_mapper.dart';
import 'package:erni_mobile/domain/exceptions/api_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dio_error_to_api_exception_mapper_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DioError>(),
  MockSpec<Response>(),
])
void main() {
  group(DioErrorToApiExceptionMapper, () {
    test('map should throw RangeError when response status code is 200', () {
      // Arrange
      final expectedResponse = MockResponse<Object>();
      when(expectedResponse.statusCode).thenReturn(200);
      final expectedError = MockDioError();
      when(expectedError.response).thenReturn(expectedResponse);

      // Assert
      expect(() => DioErrorToApiExceptionMapper.map(expectedError), throwsRangeError);
    });

    test('map should return UnauthorizedException when response status code is 401', () {
      // Arrange
      final expectedResponse = MockResponse<Object>();
      when(expectedResponse.statusCode).thenReturn(401);
      final expectedError = MockDioError();
      when(expectedError.response).thenReturn(expectedResponse);

      // Act
      final actualException = DioErrorToApiExceptionMapper.map(expectedError);

      // Assert
      expect(actualException, isA<UnauthorizedException>());
    });

    test('map should return BadRequestException when response status code is 400', () {
      // Arrange
      final expectedResponse = MockResponse<Object>();
      when(expectedResponse.statusCode).thenReturn(400);
      final expectedError = MockDioError();
      when(expectedError.response).thenReturn(expectedResponse);

      // Act
      final actualException = DioErrorToApiExceptionMapper.map(expectedError);

      // Assert
      expect(actualException, isA<BadRequestException>());
    });

    test('map should return ServerUnavailableException when response status code is 500', () {
      // Arrange
      final expectedResponse = MockResponse<Object>();
      when(expectedResponse.statusCode).thenReturn(500);
      final expectedError = MockDioError();
      when(expectedError.response).thenReturn(expectedResponse);

      // Act
      final actualException = DioErrorToApiExceptionMapper.map(expectedError);

      // Assert
      expect(actualException, isA<ServerUnavailableException>());
    });

    test('map should return ApiException when response status code is 0', () {
      // Arrange
      final expectedError = MockDioError();
      when(expectedError.response).thenReturn(null);

      // Act
      final actualException = DioErrorToApiExceptionMapper.map(expectedError);

      // Assert
      expect(actualException, isA<ApiException>());
    });

    test('map should return ApiException when response status code is 300', () {
      // Arrange
      final expectedResponse = MockResponse<Object>();
      when(expectedResponse.statusCode).thenReturn(300);
      final expectedError = MockDioError();
      when(expectedError.response).thenReturn(expectedResponse);

      // Act
      final actualException = DioErrorToApiExceptionMapper.map(expectedError);

      // Assert
      expect(actualException, isA<ApiException>());
    });
  });
}
