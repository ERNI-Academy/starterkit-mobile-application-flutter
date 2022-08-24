import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_service.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile_core/utils.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ConnectivityService)
class ConnectivityServiceImpl implements ConnectivityService {
  ConnectivityServiceImpl(this._connectivityUtil, this._dialogService);

  final ConnectivityUtil _connectivityUtil;
  final DialogService _dialogService;

  @override
  Future<bool> isConnected({bool showAlert = false}) async {
    try {
      _connectivityUtil.ensureConnected();

      return true;
    } on NoInternetException {
      if (showAlert) {
        await _dialogService.alert(
          Il8n.current.dialogConnectionProblemMessage,
          title: Il8n.current.dialogConnectionProblemTitle,
        );
      }

      return false;
    }
  }
}
