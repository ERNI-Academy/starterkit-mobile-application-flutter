import 'package:meta/meta.dart';
import 'package:starterkit_app/core/presentation/dialogs/dialog_action.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';

abstract base class BaseDialogViewModel {
  @protected
  final NavigationService navigationService;

  BaseDialogViewModel(this.navigationService);

  Future<void> onPrimaryButtonPressed() async {
    await navigationService.pop(DialogAction.primary);
  }

  Future<void> onSecondaryButtonPressed() async {
    await navigationService.pop(DialogAction.secondary);
  }
}
