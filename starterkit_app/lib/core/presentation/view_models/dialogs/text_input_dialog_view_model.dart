import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/base_dialog_view_model.dart';

@injectable
final class TextInputDialogViewModel extends BaseDialogViewModel {
  String text = '';

  TextInputDialogViewModel(super.navigationService);

  @override
  Future<void> onPrimaryButtonPressed() async {
    await navigationService.maybePop(text);
  }

  @override
  Future<void> onSecondaryButtonPressed() async {
    await navigationService.maybePop<Object>(null);
  }
}
