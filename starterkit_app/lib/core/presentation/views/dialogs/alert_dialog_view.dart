import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/alert_dialog_view_model.dart';
import 'package:starterkit_app/core/presentation/views/view_route_mixin.dart';
import 'package:starterkit_app/core/presentation/widgets/build_context_extensions.dart';

@RoutePage()
class AlertDialogView extends StatelessWidget with ViewRouteMixin<AlertDialogViewModel> {
  const AlertDialogView({
    @messageParam String? message,
    @titleParam String? title,
    @primaryTextParam String? primaryText,
    @secondaryTextParam String? secondaryText,
  }) : super(key: const Key(AlertDialogViewRoute.name));

  @override
  Widget buildView(BuildContext context, AlertDialogViewModel viewModel) {
    final String? title = viewModel.title;
    final String message = viewModel.message ?? '';
    final String primaryText = viewModel.primaryText ?? context.il8n.generalOk;
    final String? secondaryText = viewModel.secondaryText;

    return AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: <Widget>[
        if (secondaryText != null)
          TextButton(
            onPressed: viewModel.onSecondaryButtonPressed,
            child: Text(secondaryText),
          ),
        TextButton(
          onPressed: viewModel.onPrimaryButtonPressed,
          child: Text(primaryText),
        ),
      ],
      surfaceTintColor: context.theme.scaffoldBackgroundColor,
    );
  }
}
