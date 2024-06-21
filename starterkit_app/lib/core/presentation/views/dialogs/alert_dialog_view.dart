import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/alert_dialog_view_model.dart';
import 'package:starterkit_app/core/presentation/views/dialogs/base_dialog_view.dart';

@RoutePage()
class AlertDialogView extends BaseDialogView<AlertDialogViewModel> {
  const AlertDialogView({
    @QueryParam('message') super.message,
    @QueryParam('title') super.title,
    @QueryParam('primaryText') super.primaryText,
    @QueryParam('secondaryText') super.secondaryText,
  }) : super(key: const Key(AlertDialogViewRoute.name));
}
