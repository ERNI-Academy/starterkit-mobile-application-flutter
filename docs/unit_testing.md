# Unit Testing Guidlines

## Naming Convention

|Items|Naming Pattern|Target|Example
|---|---|---|---|
|Test Files|{{class_name_to_be_tested}}_test.dart|MainViewModel|main_view_model_test.dart|
|Test Methods|{{methodNameToBeTested}} should {{expected result}} when {{state}}|openLink()|openLink should trigger open uri when internet connection not available|s

## Testing Code Style

Below is an example of a unit test code for the class [`DateTimeProviderImpl`](../../erni_mobile/lib/business/services/platform/date_time_service_impl.dart):

```dart

void main() {
  group(DateTimeServiceImpl, () {
    DateTimeServiceImpl createUnitToTest() => DateTimeServiceImpl();

    test(
      'localNow should return local DateTime value that is at the same moment as the reference DateTime when called',
      () {
        // Arrange
        final unitToTest = createUnitToTest();
        final referenceDateTime = DateTime.now();

        // Act
        final actualDateTime = unitToTest.localNow();
        final difference = actualDateTime.difference(referenceDateTime);

        // Assert
        expect(difference.inMilliseconds, lessThan(100));
      },
    );

    test(
      'utcNow should return utc DateTime value that is at the same moment as the reference DateTime when called',
      () {
        // Arrange
        final unitToTest = createUnitToTest();
        final referenceDateTime = DateTime.now().toUtc();

        // Act
        final actualDateTime = unitToTest.utcNow();
        final difference = actualDateTime.difference(referenceDateTime);

        // Assert
        expect(actualDateTime.isUtc, true);
        expect(difference.inMilliseconds, lessThan(100));
      },
    );
  });
}
```

## Testing Framework

- [test](https://pub.dev/packages/test) provides standard way of writing and running tests in Dart.
- [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) for testing Flutter widgets. Read more about widget testing [here](https://docs.flutter.dev/cookbook/testing/widget/introduction).

## Mocking Framework

- [mockito](https://pub.dev/packages/mockito) for creating mocks in Dart with null safety. Uses code generation.