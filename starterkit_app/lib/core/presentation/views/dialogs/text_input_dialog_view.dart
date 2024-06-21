import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/text_input_dialog_view_model.dart';
import 'package:starterkit_app/core/presentation/views/dialogs/base_dialog_view.dart';

@RoutePage()
class TextInputDialogView extends BaseDialogView<TextInputDialogViewModel> {
  const TextInputDialogView({
    @QueryParam('message') super.message,
    @QueryParam('title') super.title,
    @QueryParam('primaryText') super.primaryText,
    @QueryParam('secondaryText') super.secondaryText,
  }) : super(key: const Key(AlertDialogViewRoute.name));

  @override
  Widget? buildContent(BuildContext context, TextInputDialogViewModel viewModel) {
    return TextFormField(
      onChanged: (String value) => viewModel.text = value,
    );
  }
}
