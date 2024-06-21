import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/base_dialog_view_model.dart';

@injectable
final class AlertDialogViewModel extends BaseDialogViewModel {
  AlertDialogViewModel(super.navigationService);
}
