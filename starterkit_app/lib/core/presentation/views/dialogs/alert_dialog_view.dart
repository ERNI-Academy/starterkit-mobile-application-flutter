import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/alert_dialog_view_model.dart';
import 'package:starterkit_app/core/presentation/views/view_route_mixin.dart';
import 'package:starterkit_app/core/presentation/widgets/build_context_extensions.dart';

@RoutePage()
class AlertDialogView extends StatelessWidget with ViewRouteMixin<AlertDialogViewModel> {
  const AlertDialogView({
    @messageParam String? message,
    @titleParam String? title,
    @okTextParam String? okText,
    @cancelTextParam String? cancelText,
    super.key,
  });

  @override
  Widget buildView(BuildContext context, AlertDialogViewModel viewModel) {
    return AlertDialog(
      title: viewModel.title != null
          ? Text(
              viewModel.title!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          : null,
      content: Text(viewModel.message ?? ''),
      actions: <Widget>[
        if (viewModel.cancelText != null)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(viewModel.cancelText!),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(viewModel.okText ?? context.il8n.generalOk),
        ),
      ],
    );
  }
}
