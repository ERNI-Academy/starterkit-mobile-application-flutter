import 'package:erni_mobile/business/services/platform/date_time_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';

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
