import 'package:erni_mobile/domain/services/ui/initial_ui_configurator.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/ui/view_models/settings/app_settings_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppViewModel extends AppSettingsViewModel {
  AppViewModel(super.settingsService, this._initialUiConfigurator);

  final InitialUiConfigurator _initialUiConfigurator;

  @override
  Future<void> onInitialize([Object? parameter, Queries queries = const {}]) async {
    _initialUiConfigurator.configure();
    await super.onInitialize(parameter, queries);
  }
}
