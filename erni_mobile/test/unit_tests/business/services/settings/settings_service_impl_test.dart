import 'dart:async';

import 'package:erni_mobile/business/models/settings/language_code.dart';
import 'package:erni_mobile/business/models/settings/language_entity.dart';
import 'package:erni_mobile/business/models/settings/settings_changed_model.dart';
import 'package:erni_mobile/business/services/settings/settings_service_impl.dart';
import 'package:erni_mobile_core/json.dart';
import 'package:erni_mobile_core/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'settings_service_impl_test.mocks.dart';

@GenerateMocks([
  SharedPrefsService,
  JsonConverter,
])
void main() {
  group(SettingsServiceImpl, () {
    late MockJsonConverter mockJsonConverter;
    late MockSharedPrefsService mockSharedPrefsService;

    setUp(() {
      mockJsonConverter = MockJsonConverter();
      mockSharedPrefsService = MockSharedPrefsService();
    });

    SettingsServiceImpl createUnitToTest() => SettingsServiceImpl(mockSharedPrefsService, mockJsonConverter);

    test('getValue should return value of key from shared prefs when called', () {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      const expectedValue = 'value';
      when(mockSharedPrefsService.getValue<String>(expectedKey)).thenReturn(expectedValue);

      // Act
      final actualResult = unitToTest.getValue<String>(expectedKey);

      // Assert
      expect(actualResult, expectedValue);
    });

    test('getValue should return defaultValue when value of key from shared prefs is null', () {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      const expectedDefaultValue = 'defaultValue';
      when(mockSharedPrefsService.getValue<String>(expectedKey)).thenReturn(null);

      // Act
      final actualResult = unitToTest.getValue<String>(expectedKey, defaultValue: expectedDefaultValue);

      // Assert
      expect(actualResult, expectedDefaultValue);
    });

    test('getObject should return decoded value when value of key from shared prefs is not null', () {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      const expectedValue = 'value';
      const expectedDecodedValue = LanguageEntity(LanguageCode.en);
      when(mockSharedPrefsService.getValue<String>(expectedKey)).thenReturn(expectedValue);
      when(
        mockJsonConverter.decodeToObject<LanguageEntity>(
          expectedValue,
          converter: anyInstanceOf<JsonConverterCallback<LanguageEntity>>(named: 'converter'),
        ),
      ).thenReturn(expectedDecodedValue);

      // Act
      final actualResult = unitToTest.getObject<LanguageEntity>(expectedKey, LanguageEntity.fromJson);

      // Assert
      expect(actualResult, expectedDecodedValue);
    });

    test('getObject should return defaultValue when value of key from shared prefs is null', () {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      const expectedDefaultValue = LanguageEntity(LanguageCode.en);
      when(mockSharedPrefsService.getValue<String>(expectedKey)).thenReturn(null);

      // Act
      final actualValue = unitToTest.getObject<LanguageEntity>(
        expectedKey,
        LanguageEntity.fromJson,
        defaultValue: expectedDefaultValue,
      );

      // Assert
      expect(actualValue, expectedDefaultValue);
    });

    test('addOrUpdateValue should add value of key to shared prefs when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      const expectedValue = 'value';
      when(mockSharedPrefsService.setValue(expectedKey, expectedValue)).thenAnswer((_) => Future.value(true));

      // Act
      await unitToTest.addOrUpdateValue(expectedKey, expectedValue);

      // Assert
      verify(mockSharedPrefsService.setValue(expectedKey, expectedValue)).called(1);
    });

    test(
      'addOrUpdateValue should add event to settingsChanged when adding value of key to shared prefs returns true',
      () async {
        // Arrange
        final unitToTest = createUnitToTest();
        final settingsChangedCompleter = Completer<SettingsChangedModel>();
        const expectedKey = 'key';
        const expectedValue = 'value';
        when(mockSharedPrefsService.setValue(expectedKey, expectedValue)).thenAnswer((_) => Future.value(true));

        // Act
        unitToTest.settingsChanged.listen(settingsChangedCompleter.complete);
        await unitToTest.addOrUpdateValue(expectedKey, expectedValue);
        final actualEvent = await settingsChangedCompleter.future;

        // Assert
        expect(actualEvent.key, expectedKey);
        expect(actualEvent.value, expectedValue);
      },
    );

    test(
      'addOrUpdateValue should not add event to settingsChanged when adding value of key to shared prefs returns false',
      () async {
        // Arrange
        final unitToTest = createUnitToTest();
        final settingsChangedCompleter = Completer<SettingsChangedModel>();
        const expectedKey = 'key';
        const expectedValue = 'value';
        when(mockSharedPrefsService.setValue(expectedKey, expectedValue)).thenAnswer((_) => Future.value(false));

        // Act
        unitToTest.settingsChanged.listen(settingsChangedCompleter.complete);
        await unitToTest.addOrUpdateValue(expectedKey, expectedValue);

        // Assert
        await expectLater(settingsChangedCompleter.future, doesNotComplete);
      },
    );

    test('addOrUpdateObject should add value of key to shared prefs when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      const expectedValue = LanguageEntity(LanguageCode.en);
      const expectedEncodedValue = 'value';
      when(mockJsonConverter.encode(expectedValue)).thenReturn(expectedEncodedValue);
      when(mockSharedPrefsService.setValue(expectedKey, expectedEncodedValue)).thenAnswer((_) => Future.value(true));

      // Act
      await unitToTest.addOrUpdateObject(expectedKey, expectedValue);

      // Assert
      verify(mockJsonConverter.encode(expectedValue)).called(1);
      verify(mockSharedPrefsService.setValue(expectedKey, expectedEncodedValue)).called(1);
    });

    test(
      'addOrUpdateObject should add event to settingsChanged when adding value of key to shared prefs returns true',
      () async {
        // Arrange
        final unitToTest = createUnitToTest();
        final settingsChangedCompleter = Completer<SettingsChangedModel>();
        const expectedKey = 'key';
        const expectedValue = LanguageEntity(LanguageCode.en);
        const expectedEncodedValue = 'value';
        when(mockJsonConverter.encode(expectedValue)).thenReturn(expectedEncodedValue);
        when(mockSharedPrefsService.setValue(expectedKey, expectedEncodedValue)).thenAnswer((_) => Future.value(true));

        // Act
        unitToTest.settingsChanged.listen(settingsChangedCompleter.complete);
        await unitToTest.addOrUpdateObject(expectedKey, expectedValue);
        final actualEvent = await settingsChangedCompleter.future;

        // Assert
        expect(actualEvent.key, expectedKey);
        expect(actualEvent.value, expectedValue);
      },
    );

    test(
      'addOrUpdateObject should not add event to settingsChanged when adding value of key to shared prefs returns false',
      () async {
        // Arrange
        final unitToTest = createUnitToTest();
        final settingsChangedCompleter = Completer<SettingsChangedModel>();
        const expectedKey = 'key';
        const expectedValue = LanguageEntity(LanguageCode.en);
        const expectedEncodedValue = 'value';
        when(mockJsonConverter.encode(expectedValue)).thenReturn(expectedEncodedValue);
        when(mockSharedPrefsService.setValue(expectedKey, expectedEncodedValue)).thenAnswer((_) => Future.value(false));

        // Act
        unitToTest.settingsChanged.listen(settingsChangedCompleter.complete);
        await unitToTest.addOrUpdateObject(expectedKey, expectedValue);

        // Assert
        await expectLater(settingsChangedCompleter.future, doesNotComplete);
      },
    );

    test('delete should remove value of key from shared prefs when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      const expectedKey = 'key';
      when(mockSharedPrefsService.clear(expectedKey)).thenAnswer((_) => Future.value(true));

      // Act
      await unitToTest.delete(expectedKey);

      // Assert
      verify(mockSharedPrefsService.clear(expectedKey)).called(1);
    });

    test(
      'delete should add event to settingsChanged when clearing value of key from shared prefs returns true',
      () async {
        // Arrange
        final unitToTest = createUnitToTest();
        final settingsChangedCompleter = Completer<SettingsChangedModel>();
        const expectedKey = 'key';
        when(mockSharedPrefsService.clear(expectedKey)).thenAnswer((_) => Future.value(true));

        // Act
        unitToTest.settingsChanged.listen(settingsChangedCompleter.complete);
        await unitToTest.delete(expectedKey);
        final actualEvent = await settingsChangedCompleter.future;

        // Assert
        expect(actualEvent.key, expectedKey);
        expect(actualEvent.value, null);
      },
    );

    test(
      'delete should not add event to settingsChanged when clearing value of key from shared prefs returns false',
      () async {
        // Arrange
        final unitToTest = createUnitToTest();
        final settingsChangedCompleter = Completer<SettingsChangedModel>();
        const expectedKey = 'key';
        when(mockSharedPrefsService.clear(expectedKey)).thenAnswer((_) => Future.value(false));

        // Act
        unitToTest.settingsChanged.listen(settingsChangedCompleter.complete);
        await unitToTest.delete(expectedKey);

        // Assert
        await expectLater(settingsChangedCompleter.future, doesNotComplete);
      },
    );

    test('deleteAll should clear all values from shared prefs when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      when(mockSharedPrefsService.clearAll()).thenAnswer((_) => Future.value(true));

      // Act
      await unitToTest.deleteAll();

      // Assert
      verify(mockSharedPrefsService.clearAll()).called(1);
    });

    test('dispose should close the stream when called', () async {
      // Arrange
      const expectedKey = 'key';
      final unitToTest = createUnitToTest();
      final settingsChangedCompleter = Completer<SettingsChangedModel>();
      when(mockSharedPrefsService.clear(expectedKey)).thenAnswer((_) => Future.value(true));

      // Act
      unitToTest.settingsChanged.listen(settingsChangedCompleter.complete);
      unitToTest.dispose();
      await unitToTest.delete(expectedKey);

      // Assert
      await expectLater(settingsChangedCompleter.future, doesNotComplete);
    });
  });
}
