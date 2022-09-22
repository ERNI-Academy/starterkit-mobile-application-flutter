// coverage:ignore-file

import 'dart:async';

import 'package:erni_mobile/business/models/ui/confirm_dialog_response.dart';
import 'package:erni_mobile/business/services/ui/navigation/view_locator.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile/domain/services/ui/navigation_service.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DialogService)
class DialogServiceImpl implements DialogService {
  bool _isLoadingShown = false;
  bool _isDialogShown = false;

  static BuildContext get _context {
    final context = NavigationService.navigatorKey.currentState?.overlay?.context;

    if (context == null) {
      throw StateError('BuildContext is null');
    }

    return context;
  }

  @override
  Future<void> alert(String message, {String? title, String? ok}) async {
    _isDialogShown = true;
    await showDialog<void>(
      context: _context,
      builder: (context) {
        return _AlertDialog(
          message: message,
          title: title,
          ok: ok ?? Il8n.of(context).generalOk,
        );
      },
    );

    _isDialogShown = false;
  }

  @override
  Future<ConfirmDialogResponse> confirm(
    String message, {
    String? title,
    String? ok,
    String? cancel,
  }) async {
    final confirmed = await showDialog<bool?>(
      barrierDismissible: false,
      context: _context,
      builder: (context) {
        return _AlertDialog(
          message: message,
          title: title,
          ok: ok ?? Il8n.of(context).generalOk,
          cancel: cancel ?? Il8n.of(context).generalCancel,
        );
      },
    );

    _isDialogShown = false;

    if (confirmed == true) {
      return ConfirmDialogResponse.confirmed;
    } else if (confirmed == false) {
      return ConfirmDialogResponse.dismissed;
    }

    return ConfirmDialogResponse.cancelled;
  }

  @override
  Future<T?> showBottomSheet<T extends Object>(String bottomSheetName, {Object? parameter}) async {
    final settings = RouteSettings(name: bottomSheetName, arguments: parameter);
    final result = showModalBottomSheet<T>(
      context: _context,
      routeSettings: settings,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: _tryGetRegisteredWidget(bottomSheetName),
        );
      },
    );

    _isDialogShown = false;

    return result;
  }

  @override
  Future<void> showLoading([String? message]) async {
    if (_isLoadingShown) {
      return;
    }

    _isDialogShown = true;
    _isLoadingShown = true;

    unawaited(
      Future<void>(
        () async {
          await showDialog<void>(
            context: _context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: SpacedRow(
                  spacing: 16,
                  children: [
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                    Text(message ?? Il8n.of(_context).dialogLoading),
                  ],
                ),
              );
            },
          );

          _isDialogShown = false;
          _isLoadingShown = false;
        },
      ),
    );
  }

  @override
  Future<bool> dismiss([Object? result]) async {
    if (_isDialogShown || _isLoadingShown) {
      return Navigator.of(_context).maybePop(result);
    }

    return false;
  }

  @override
  void showSnackbar(String message, {Duration duration = const Duration(seconds: 2)}) {
    final mediaQuery = MediaQuery.of(_context);
    final isLargeDevice = mediaQuery.size.width > 512;
    ScaffoldMessenger.of(_context).hideCurrentSnackBar();
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        width: isLargeDevice ? 512 : null,
        duration: duration,
      ),
    );
  }

  @override
  Future<T?> show<T>(String dialogName, {Object? parameter, bool dismissable = true}) async {
    _isDialogShown = true;
    final settings = RouteSettings(name: dialogName, arguments: parameter);
    final result = await showDialog<T>(
      context: _context,
      routeSettings: settings,
      barrierDismissible: dismissable,
      builder: (context) => _tryGetRegisteredWidget(dialogName),
    );

    _isDialogShown = false;

    return result;
  }

  @override
  Future<void> showNoInternet() {
    return alert(
      Il8n.current.dialogConnectionProblemMessage,
      title: Il8n.current.dialogConnectionProblemTitle,
    );
  }

  static Widget _tryGetRegisteredWidget(String name) {
    final isDialogRegistered = ViewLocator.isViewRegistered(name);
    assert(isDialogRegistered, 'Dialog named $name is not registered');

    return ViewLocator.getView(name);
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({
    required this.message,
    required this.ok,
    this.title,
    this.cancel,
  });

  final String message;
  final String ok;
  final String? title;
  final String? cancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          : null,
      content: Text(message),
      actions: <Widget>[
        if (cancel != null)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancel!),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(ok),
        ),
      ],
    );
  }
}
