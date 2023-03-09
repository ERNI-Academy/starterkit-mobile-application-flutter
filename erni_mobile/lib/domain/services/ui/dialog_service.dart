import 'package:erni_mobile/business/models/ui/confirm_dialog_response.dart';

abstract class DialogService {
  Future<void> alert(String message, {String? title, String? ok});

  Future<ConfirmDialogResponse> confirm(String message, {String? title, String? ok, String? cancel});

  Future<bool> dismiss([Object? result]);

  Future<void> showLoading([String? message]);

  void showSnackbar(String message, {Duration duration = const Duration(seconds: 2)});

  Future<T?> show<T extends Object?>(String dialogName, {Object? parameter, bool dismissable = true});
}
