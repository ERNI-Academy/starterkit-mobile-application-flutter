import 'package:injectable/injectable.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/presentation/dialogs/dialog_action.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';

abstract interface class DialogService {
  Future<void> alert({required String message, String? title, String? primaryText, String? secondaryText});

  Future<DialogAction> confirm({required String message, String? title, String? primaryText, String? secondaryText});
}

@LazySingleton(as: DialogService)
class DialogServiceImpl implements DialogService {
  final NavigationService _navigationService;

  DialogServiceImpl(this._navigationService);

  @override
  Future<void> alert({required String message, String? title, String? primaryText, String? secondaryText}) async {
    await _navigationService.push(AlertDialogViewRoute(
      message: message,
      title: title,
      primaryText: primaryText,
      secondaryText: secondaryText,
    ));
  }

  @override
  Future<DialogAction> confirm({
    required String message,
    String? title,
    String? primaryText,
    String? secondaryText,
  }) async {
    final DialogAction? result = await _navigationService.push<DialogAction>(AlertDialogViewRoute(
      message: message,
      title: title,
      primaryText: primaryText,
      secondaryText: secondaryText ?? Il8n.current.generalCancel,
    ));

    return result ?? DialogAction.cancelled;
  }
}
