import 'package:erni_mobile/business/models/platform/deep_link_entity.dart';
import 'package:erni_mobile/business/services/platform/deep_link_service_impl.dart';
import 'package:erni_mobile/common/constants/deep_link_paths.dart';
import 'package:erni_mobile/common/utils/converters/deep_link_path_to_route_converter.dart';
import 'package:erni_mobile_core/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'deep_link_service_impl_test.mocks.dart';

@GenerateMocks([
  AppLinkService,
  Stream,
])
void main() {
  group(DeepLinkServiceImpl, () {
    late MockAppLinkService mockAppLinkService;

    setUp(() {
      mockAppLinkService = MockAppLinkService();
    });

    DeepLinkServiceImpl createUnitToTest() => DeepLinkServiceImpl(mockAppLinkService);

    void setupAppLinkServiceWithStream({Stream<DeepLinkEntity>? linkStream}) {
      final expectedOriginalStream = MockStream<Uri>();
      when(mockAppLinkService.linkStream).thenAnswer((_) => expectedOriginalStream);
      when(expectedOriginalStream.map<DeepLinkEntity>(anyInstanceOf<DeepLinkEntity Function(Uri)>()))
          .thenAnswer((_) => linkStream ?? MockStream<DeepLinkEntity>());
    }

    void expectLinksAreEqual(DeepLinkEntity expected, DeepLinkEntity actual) {
      expect(expected.url, actual.url);
      expect(expected.navigatableRoute, actual.navigatableRoute);
    }

    test('constructor should set linkStream value when called', () {
      // Arrange
      final expectedLinkStream = MockStream<DeepLinkEntity>();
      setupAppLinkServiceWithStream(linkStream: expectedLinkStream);

      // Act
      final unit = createUnitToTest();

      // Assert
      expect(unit.linkStream, expectedLinkStream);
    });

    test('getInitialLink should return null when no link is available', () async {
      // Arrange
      setupAppLinkServiceWithStream();
      final unit = createUnitToTest();
      when(mockAppLinkService.getInitialLink()).thenAnswer((_) => Future.value());

      // Act
      final actualResult = await unit.getInitialLink();

      // Assert
      expect(actualResult, isNull);
    });

    test('getInitialLink should return link when link is available', () async {
      // Arrange
      setupAppLinkServiceWithStream();
      final unit = createUnitToTest();
      final expectedUri = Uri.parse(DeepLinkPaths.setInitialPassword);
      final expectedNavigatableRoute = const DeepLinkPathToRouteConverter().convert(DeepLinkPaths.setInitialPassword);
      final expectedLink = DeepLinkEntity(expectedUri, expectedNavigatableRoute);
      when(mockAppLinkService.getInitialLink()).thenAnswer((_) => Future.value(expectedUri));

      // Act
      final actualResult = await unit.getInitialLink();

      // Assert
      expect(actualResult, isNotNull);
      expectLinksAreEqual(actualResult!, expectedLink);
    });

    test('getLatestLink should return null when no link is available', () async {
      // Arrange
      setupAppLinkServiceWithStream();
      final unit = createUnitToTest();
      when(mockAppLinkService.getLatestLink()).thenAnswer((_) => Future.value());

      // Act
      final actualResult = await unit.getLatestLink();

      // Assert
      expect(actualResult, isNull);
    });

    test('getLatestLink should return link when link is available', () async {
      // Arrange
      setupAppLinkServiceWithStream();
      final unit = createUnitToTest();
      final expectedUri = Uri.parse(DeepLinkPaths.setInitialPassword);
      final expectedNavigatableRoute = const DeepLinkPathToRouteConverter().convert(DeepLinkPaths.setInitialPassword);
      final expectedLink = DeepLinkEntity(expectedUri, expectedNavigatableRoute);
      when(mockAppLinkService.getLatestLink()).thenAnswer((_) => Future.value(expectedUri));

      // Act
      final actualResult = await unit.getLatestLink();

      // Assert
      expect(actualResult, isNotNull);
      expectLinksAreEqual(actualResult!, expectedLink);
    });
  });
}
