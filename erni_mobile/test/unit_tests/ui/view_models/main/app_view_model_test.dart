import 'dart:async';

import 'package:erni_mobile/business/models/settings/app_settings_entity.dart';
import 'package:erni_mobile/business/models/settings/settings_changed_model.dart';
import 'package:erni_mobile/domain/services/json/json_service.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:erni_mobile/domain/services/ui/initial_ui_configurator.dart';
import 'package:erni_mobile/ui/view_models/main/app_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'app_view_model_test.mocks.dart';

@GenerateMocks([
  SettingsService,
  InitialUiConfigurator,
  Stream,
  StreamSubscription,
])
void main() {
  group(AppViewModel, () {
    late MockSettingsService mockSettingsService;
    late MockInitialUiConfigurator mockInitialUiConfigurator;
    late MockStream<SettingsChangedModel> mockSettingsStream;

    setUp(() {
      mockSettingsService = MockSettingsService();
      mockInitialUiConfigurator = MockInitialUiConfigurator();
      mockSettingsStream = MockStream<SettingsChangedModel>();
    });

    AppViewModel createUnit() {
      return AppViewModel(
        mockSettingsService,
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

    test('onInitialize should configure ui when called', () async {
      // Arrange
      setupSettingsService();
      final unit = createUnit();

      // Act
      await unit.onInitialize();

      // Assert
      verify(mockInitialUiConfigurator.configure()).called(1);
    });
  });
}
