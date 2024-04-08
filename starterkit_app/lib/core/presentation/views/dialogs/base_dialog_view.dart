import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/dialogs/dialog_action.dart';
import 'package:starterkit_app/core/presentation/widgets/build_context_extensions.dart';

abstract class BaseDialogView extends StatelessWidget {
  final String? _message;
  final String? _title;
  final String? _primaryText;
  final String? _secondaryText;

  const BaseDialogView({
    String? message,
    String? title,
    String? primaryText,
    String? secondaryText,
    super.key,
  })  : _message = message,
        _title = title,
        _primaryText = primaryText,
        _secondaryText = secondaryText;

  @override
  Widget build(BuildContext context) {
    final Widget? content = buildContent(context);

    return AlertDialog(
      title: _title == null ? null : Text(_title),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(_message ?? ''),
          if (content != null) Flexible(child: content),
        ],
      ),
      actions: <Widget>[
        if (_secondaryText != null)
          TextButton(
            onPressed: () async => onSecondaryButtonPressed(context),
            child: Text(_secondaryText),
          ),
        TextButton(
          onPressed: () async => onPrimaryButtonPressed(context),
          child: Text(_primaryText ?? context.il8n.generalOk),
        ),
      ],
      surfaceTintColor: Theme.of(context).colorScheme.surface,
    );
  }

  Future<void> onPrimaryButtonPressed(BuildContext context) async {
    await AutoRouter.of(context).maybePop(DialogAction.primary);
  }

  Future<void> onSecondaryButtonPressed(BuildContext context) async {
    await AutoRouter.of(context).maybePop(DialogAction.secondary);
  }

  Widget? buildContent(BuildContext context) => null;
}
