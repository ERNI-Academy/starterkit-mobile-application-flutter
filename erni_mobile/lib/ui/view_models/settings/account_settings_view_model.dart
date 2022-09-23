import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountSettingsViewModel extends ViewModel {
  AccountSettingsViewModel(this._logger) {
    _logger.logFor(this);
  }

  final AppLogger _logger;
}
