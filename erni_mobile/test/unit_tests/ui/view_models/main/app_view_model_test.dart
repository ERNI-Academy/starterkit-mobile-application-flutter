import 'dart:async';

import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/platform/deep_link_entity.dart';
import 'package:erni_mobile/business/models/settings/app_settings_entity.dart';
import 'package:erni_mobile/business/models/settings/settings_changed_model.dart';
import 'package:erni_mobile/common/constants/messaging_channels.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/deep_link_service.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:erni_mobile/domain/services/ui/initial_ui_configurator.dart';
import 'package:erni_mobile/ui/view_models/main/app_view_model.dart';
import 'package:erni_mobile_core/json.dart';
import 'package:erni_mobile_core/navigation.dart';
import 'package:erni_mobile_core/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'app_view_model_test.mocks.dart';

@GenerateMocks([
  SettingsService,
  AppLogger,
  MessagingCenter,
  NavigationService,
  DeepLinkService,
  InitialUiConfigurator,
  Stream,
  StreamSubscription,
])
void main() {
  group(AppViewModel, () {
    late MockSettingsService mockSettingsService;
    late MockAppLogger mockAppLogger;
    late MockMessagingCenter mockMessagingCenter;
    late MockNavigationService mockNavigationService;
    late MockDeepLinkService mockDeepLinkService;
    late MockInitialUiConfigurator mockInitialUiConfigurator;
    late MockStream<SettingsChangedModel> mockSettingsStream;
    late MockStreamSubscription<DeepLinkEntity> mockAppLinkStreamSubscription;
    late MockStream<DeepLinkEntity> mockAppLinkStream;
    late StreamController<DeepLinkEntity> realAppLinkStreamController;

    setUp(() {
      mockSettingsService = MockSettingsService();
      mockAppLogger = MockAppLogger();
      mockMessagingCenter = MockMessagingCenter();
      mockNavigationService = MockNavigationService();
      mockDeepLinkService = MockDeepLinkService();
      mockInitialUiConfigurator = MockInitialUiConfigurator();
      mockSettingsStream = MockStream<SettingsChangedModel>();
      mockAppLinkStreamSubscription = MockStreamSubscription<DeepLinkEntity>();
      mockAppLinkStream = MockStream<DeepLinkEntity>();
      realAppLinkStreamController = StreamController<DeepLinkEntity>();
    });

    tearDown(() {
      realAppLinkStreamController.close();
    });

    AppViewModel createUnit() {
      return AppViewModel(
        mockSettingsService,
        mockAppLogger,
        mockMessagingCenter,
        mockNavigationService,
        mockDeepLinkService,
        mockInitialUiConfigurator,
      );
    }

    void setupSettingsService() {
      when(
        mockSettingsService.getObject<AppSettingsEntity>(
          anyInstanceOf<String>(),
          anyInstanceOf<JsonConverterCallback<AppSettingsEntity>>(),
          defaultValue: anyInstanceOf<AppSettingsEntity>(named: 'defaultValue'),
        ),
      ).thenAnswer((_) => const AppSettingsEntity());
      when(mockSettingsStream.listen(anyInstanceOf<void Function(SettingsChangedModel)?>()))
          .thenAnswer((_) => MockStreamSubscription<SettingsChangedModel>());
      when(mockSettingsService.settingsChanged).thenAnswer((_) => mockSettingsStream);
    }

    void setupLinkServiceWithMockStream() {
      when(mockAppLinkStream.listen(anyInstanceOf<void Function(DeepLinkEntity)?>()))
          .thenAnswer((_) => mockAppLinkStreamSubscription);
      when(mockDeepLinkService.linkStream).thenAnswer((_) => mockAppLinkStream);
    }

    void setupLinkServiceWithRealStream() {
      when(mockDeepLinkService.linkStream).thenAnswer((_) => realAppLinkStreamController.stream);
    }

    test('constructor should log itself when called', () {
      // Act
      final unit = createUnit();

      // Assert
      verify(mockAppLogger.logFor(unit)).called(1);
    });

    test('onInitialize should listen to deepLinkService stream when called', () async {
      // Arrange
      setupLinkServiceWithMockStream();
      setupSettingsService();
      final unit = createUnit();

      // Act
      await unit.onInitialize();

      // Assert
      verify(mockAppLinkStream.listen(anyInstanceOf<void Function(DeepLinkEntity)?>())).called(1);
    });

    test('onInitialize should configure ui when called', () async {
      // Arrange
      setupLinkServiceWithMockStream();
      setupSettingsService();
      final unit = createUnit();

      // Act
      await unit.onInitialize();

      // Assert
      verify(mockInitialUiConfigurator.configure()).called(1);
    });

    test('onInitialize should subscribe to loggedOut channel when called', () async {
      // Arrange
      setupLinkServiceWithMockStream();
      setupSettingsService();
      final unit = createUnit();

      // Act
      await unit.onInitialize();

      // Assert
      verify(
        mockMessagingCenter.subscribe(
          unit,
          channel: MessagingChannels.loggedOut,
          action: anyInstanceOf<void Function(Object?)>(named: 'action'),
        ),
      ).called(1);
    });

    test('tryNavigateToLatestLink should log route when latest link can be navigated', () async {
      // Arrange
      setupLinkServiceWithRealStream();
      setupSettingsService();
      when(
        mockNavigationService.push(
          anyInstanceOf<String>(),
          queries: anyInstanceOf<Map<String, String>?>(named: 'queries'),
        ),
      ).thenAnswer(Future.value);
      final unit = createUnit();
      final deepLinkEntity = DeepLinkEntity(Uri.parse('/setpassword'), '/setpassword');

      // Act
      await unit.onInitialize();
      realAppLinkStreamController.add(deepLinkEntity);
      await untilCalled(
        mockNavigationService.push(
          anyInstanceOf<String>(),
          queries: anyInstanceOf<Map<String, String>?>(named: 'queries'),
        ),
      );

      // Assert
      verify(mockAppLogger.log(LogLevel.info, anyInstanceOf<String>())).called(1);
    });

    test('tryNavigateToLatestLink should push route when latest link can be navigated', () async {
      // Arrange
      setupLinkServiceWithRealStream();
      setupSettingsService();
      when(
        mockNavigationService.push(
          anyInstanceOf<String>(),
          queries: anyInstanceOf<Map<String, String>?>(named: 'queries'),
        ),
      ).thenAnswer(Future.value);
      final unit = createUnit();
      final deepLinkEntity = DeepLinkEntity(Uri.parse('/setpassword'), '/setpassword');

      // Act
      await unit.onInitialize();
      realAppLinkStreamController.add(deepLinkEntity);
      await untilCalled(mockNavigationService.push(deepLinkEntity.navigatableRoute, queries: deepLinkEntity.queries));

      // Assert
      verify(mockNavigationService.push(deepLinkEntity.navigatableRoute, queries: deepLinkEntity.queries)).called(1);
    });

    test('dispose should unsubscribe from loggedOut channel when called', () async {
      // Arrange
      setupLinkServiceWithMockStream();
      setupSettingsService();
      final unit = createUnit();

      // Act
      await unit.onInitialize();
      unit.dispose();

      // Assert
      verify(mockMessagingCenter.unsubscribe(unit, channel: MessagingChannels.loggedOut)).called(1);
    });

    test('dispose should cancel appLinkStreamSubscription when called', () async {
      // Arrange
      setupLinkServiceWithMockStream();
      setupSettingsService();
      final unit = createUnit();

      // Act
      await unit.onInitialize();
      unit.dispose();

      // Assert
      verify(mockAppLinkStreamSubscription.cancel()).called(1);
    });
  });
}
