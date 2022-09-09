import 'package:erni_mobile/business/services/settings/secure_settings_service_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'secure_settings_service_impl_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  group(SecureSettingsServiceImpl, () {
    late MockFlutterSecureStorage mockSecureStorageService;

    setUp(() {
      mockSecureStorageService = MockFlutterSecureStorage();
    });

    SecureSettingsServiceImpl createUnitToTest() => SecureSettingsServiceImpl(mockSecureStorageService);

    test('addOrUpdateValue should add key/value to secure storage when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      const key = 'key';
      const expectedValue = 'value';
      when(mockSecureStorageService.write(key: key, value: expectedValue)).thenAnswer((_) => Future.value());

      // Act
      await unitToTest.addOrUpdateValue(key, expectedValue);

      // Assert
      verify(mockSecureStorageService.write(key: key, value: expectedValue)).called(1);
    });

    test('getValue should return value of key from secure storage when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      const expectedValue = 'value';
      when(mockSecureStorageService.read(key: expectedKey)).thenAnswer((_) => Future.value(expectedValue));

      // Act
      final actualValue = await unitToTest.getValue(expectedKey);

      // Assert
      expect(actualValue, expectedValue);
    });

    test('getValue should return defaultValue when value of key from secure storage is null', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      const expectedValue = 'value';
      when(mockSecureStorageService.read(key: expectedKey)).thenAnswer((_) => Future.value());

      // Act
      final actualValue = await unitToTest.getValue(expectedKey, defaultValue: expectedValue);

      // Assert
      expect(actualValue, expectedValue);
    });

    test('delete should clear value of key from secure storage when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      when(mockSecureStorageService.delete(key: expectedKey)).thenAnswer((_) => Future.value());

      // Act
      await unitToTest.delete(expectedKey);

      // Assert
      verify(mockSecureStorageService.delete(key: expectedKey)).called(1);
    });

    test('deleteAll should clear all values from secure storage when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      when(mockSecureStorageService.deleteAll()).thenAnswer((_) => Future.value());

      // Act
      await unitToTest.deleteAll();

      // Assert
      verify(mockSecureStorageService.deleteAll()).called(1);
    });
  });
}
