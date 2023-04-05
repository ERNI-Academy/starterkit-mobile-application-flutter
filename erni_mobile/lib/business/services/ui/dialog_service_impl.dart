// coverage:ignore-file

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:erni_mobile/business/models/ui/confirm_dialog_response.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/domain/services/ui/build_context_provider.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DialogService)
class DialogServiceImpl implements DialogService {
  final BuildContextProvider _contextProvider;

  bool _isLoadingShown = false;
  bool _isDialogShown = false;

  DialogServiceImpl(this._contextProvider);

  @override
  Future<void> alert(String message, {String? title, String? ok}) async {
    _isDialogShown = true;
    await showDialog<void>(
      context: _contextProvider.context,
      routeSettings: const RouteSettings(name: '/dialogs/alert'),
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
  Future<ConfirmDialogResponse> confirm(String message, {String? title, String? ok, String? cancel}) async {
    _isDialogShown = true;

    final confirmed = await _showDismissableAlert('/dialogs/confirm', message, title, ok, cancel);

    _isDialogShown = false;

    if (confirmed == true) {
      return ConfirmDialogResponse.confirmed;
    } else if (confirmed == false) {
      return ConfirmDialogResponse.dismissed;
    }

    return ConfirmDialogResponse.cancelled;
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
            context: _contextProvider.context,
            barrierDismissible: false,
            routeSettings: const RouteSettings(name: '/dialogs/loading'),
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
                    Text(message ?? Il8n.of(_contextProvider.context).dialogLoading),
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
      return AutoRouter.of(_contextProvider.context).pop(result);
    }

    return false;
  }

  @override
  void showSnackbar(String message, {Duration duration = const Duration(seconds: 2)}) {
    final mediaQuery = MediaQuery.of(_contextProvider.context);
    final isLargeDevice = mediaQuery.size.width > 512;
    ScaffoldMessenger.of(_contextProvider.context).hideCurrentSnackBar();
    ScaffoldMessenger.of(_contextProvider.context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        width: isLargeDevice ? 512 : null,
        duration: duration,
      ),
    );
  }

  // ignore: long-parameter-list
  Future<bool?> _showDismissableAlert(
    String routeName,
    String message, [
    String? title,
    String? ok,
    String? cancel,
    Widget? child,
  ]) {
    return showDialog<bool?>(
      barrierDismissible: false,
      routeSettings: RouteSettings(name: routeName),
      context: _contextProvider.context,
      builder: (context) {
        return _AlertDialog(
          message: message,
          title: title,
          ok: ok ?? Il8n.of(context).generalOk,
          cancel: cancel ?? Il8n.of(context).generalCancel,
          child: child,
        );
      },
    );
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({
    required this.message,
    required this.ok,
    this.title,
    this.cancel,
    this.child,
  });

  final String message;
  final String ok;
  final String? title;
  final String? cancel;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final hasChild = child != null;
    const actionStyle = TextStyle(fontSize: 16);

    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          : null,
      content: hasChild
          ? SpacedColumn(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                child!,
              ],
            )
          : Text(
              message,
              style: const TextStyle(height: 1.5),
            ),
      actions: <Widget>[
        if (cancel != null)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancel!,
              style: actionStyle,
            ),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            ok,
            style: actionStyle,
          ),
        ),
      ],
    );
  }
}
