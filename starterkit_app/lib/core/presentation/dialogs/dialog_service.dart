import 'package:injectable/injectable.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/presentation/dialogs/dialog_action.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';

@lazySingleton
class DialogService {
  final NavigationService _navigationService;

  DialogService(this._navigationService);

  Future<void> alert({required String message, String? title, String? primaryText, String? secondaryText}) async {
    await _navigationService.push(AlertDialogViewRoute(
      message: message,
      title: title,
      primaryText: primaryText,
      secondaryText: secondaryText,
    ));
  }

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

  Future<String?> textInput({
    required String message,
    String? title,
    String? primaryText,
    String? secondaryText,
  }) async {
    final String? result = await _navigationService.push<String>(TextInputDialogViewRoute(
      message: message,
      title: title,
      primaryText: primaryText,
      secondaryText: secondaryText ?? Il8n.current.generalCancel,
    ));

    return result;
  }
}
