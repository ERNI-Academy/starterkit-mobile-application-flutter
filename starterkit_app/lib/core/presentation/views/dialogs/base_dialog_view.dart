import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/base_dialog_view_model.dart';
import 'package:starterkit_app/core/presentation/views/view_model_builder.dart';
import 'package:starterkit_app/core/presentation/widgets/build_context_extensions.dart';

abstract class BaseDialogView<T extends BaseDialogViewModel> extends StatelessWidget {
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
  }) : _message = message,
       _title = title,
       _primaryText = primaryText,
       _secondaryText = secondaryText;

  @override
  Widget build(BuildContext context) {
    return AutoViewModelBuilder<T>(
      builder: (BuildContext context, T viewModel) {
        final Widget? content = buildContent(context, viewModel);

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
                onPressed: viewModel.onSecondaryButtonPressed,
                child: Text(_secondaryText),
              ),
            TextButton(
              onPressed: viewModel.onPrimaryButtonPressed,
              child: Text(_primaryText ?? context.il8n.generalOk),
            ),
          ],
          surfaceTintColor: Theme.of(context).colorScheme.surface,
        );
      },
    );
  }

  Widget? buildContent(BuildContext context, T viewModel) => null;
}
