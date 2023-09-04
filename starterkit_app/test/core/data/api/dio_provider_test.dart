import 'package:dio/src/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/data/api/debug_logging_interceptor.dart';
import 'package:starterkit_app/core/data/api/dio_provider.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';

import 'dio_provider_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<Logger>(),
])
void main() {
  group(DioProviderImpl, () {
    late MockLogger mockLogger;

    setUp(() {
      mockLogger = MockLogger();
    });

    DioProviderImpl createUnitToTest(String expectedBaseUrl) {
      return DioProviderImpl(mockLogger, expectedBaseUrl);
    }

    group('create', () {
      test('should return Dio when called', () {
        createUnitToTest('http://test.com').create<Object>();

        verify(mockLogger.logFor<Object>()).called(1);
      });

      test('should return Dio with correct options when called', () {
        const String expectedBaseUrl = 'http://test.com';
        final DioProviderImpl unit = createUnitToTest(expectedBaseUrl);

        final Dio actualDio = unit.create<Object>();

        expect(actualDio.options.connectTimeout, equals(const Duration(seconds: 10)));
        expect(actualDio.options.receiveTimeout, equals(const Duration(seconds: 30)));
        expect(actualDio.options.sendTimeout, equals(const Duration(seconds: 10)));
        expect(actualDio.options.baseUrl, equals(expectedBaseUrl));
      });

      test('should return Dio with DebugLoggingInterceptor when called', () {
        final DioProviderImpl unit = createUnitToTest('http://test.com');

        final Dio actualDio = unit.create<Object>();

        expect(actualDio.interceptors, contains(isA<DebugLoggingInterceptor>()));
      });
    });
  });
}
