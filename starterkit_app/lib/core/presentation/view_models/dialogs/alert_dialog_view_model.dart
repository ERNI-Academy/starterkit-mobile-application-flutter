import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/dialogs/dialog_action.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/reflection.dart';

@injectable
@navigatable
class AlertDialogViewModel extends ViewModel {
  final NavigationService _navigationService;

  AlertDialogViewModel(this._navigationService);

  @titleParam
  String? title;

  @messageParam
  String? message;

  @primaryTextParam
  String? primaryText;

  @secondaryTextParam
  String? secondaryText;

  Future<void> onPrimaryButtonPressed() async {
    await _navigationService.pop(DialogAction.primary);
  }

  Future<void> onSecondaryButtonPressed() async {
    await _navigationService.pop(DialogAction.secondary);
  }
}

const QueryParam titleParam = QueryParam('title');

const QueryParam messageParam = QueryParam('message');

const QueryParam secondaryTextParam = QueryParam('secondaryText');

const QueryParam primaryTextParam = QueryParam('primaryText');
