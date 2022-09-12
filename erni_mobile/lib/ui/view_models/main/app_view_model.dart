import 'package:erni_mobile/ui/view_models/settings/app_settings_view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppViewModel extends AppSettingsViewModel {
  AppViewModel(super.settingsService);
}
