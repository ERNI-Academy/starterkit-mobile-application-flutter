import 'dart:async';

import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/platform/deep_link_entity.dart';
import 'package:erni_mobile/common/constants/messaging_channels.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/deep_link_service.dart';
import 'package:erni_mobile/domain/services/ui/initial_ui_configurator.dart';
import 'package:erni_mobile/ui/view_models/settings/app_settings_view_model.dart';
import 'package:erni_mobile_blueprint_core/navigation.dart';
import 'package:erni_mobile_blueprint_core/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppViewModel extends AppSettingsViewModel {
  AppViewModel(
    super.settingsService,
    this._logger,
    this._messagingCenter,
    this._navigationService,
    this._deepLinkService,
    this._initialUiConfigurator,
  ) {
    _logger.logFor(this);
  }

  final AppLogger _logger;
  final MessagingCenter _messagingCenter;
  final NavigationService _navigationService;
  final DeepLinkService _deepLinkService;
  final InitialUiConfigurator _initialUiConfigurator;
  late final StreamSubscription _linkSubscription;

  @override
  Future<void> onInitialize([Object? parameter, Queries queries = const {}]) async {
    _linkSubscription = _deepLinkService.linkStream.listen(_tryNavigateToNewLink);
    _messagingCenter.subscribe(this, channel: MessagingChannels.loggedOut, action: (_) => updateAppSettings());
    _initialUiConfigurator.configure();
    await super.onInitialize(parameter, queries);
  }

  @override
  void dispose() {
    _messagingCenter.unsubscribe(this, channel: MessagingChannels.loggedOut);
    _linkSubscription.cancel();

    super.dispose();
  }

  Future<void> _tryNavigateToNewLink(DeepLinkEntity latestLink) async {
    if (latestLink.canNavigateToRoute) {
      _logger.log(LogLevel.info, 'Handled deep link $latestLink');
      await _navigationService.push(latestLink.navigatableRoute, queries: latestLink.queries);
    }
  }
}
