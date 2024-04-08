import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/core/presentation/views/dialogs/base_dialog_view.dart';

@RoutePage()
class TextInputDialogView extends BaseDialogView {
  final TextEditingController _textEditingController = TextEditingController();

  TextInputDialogView({
    @QueryParam('message') super.message,
    @QueryParam('title') super.title,
    @QueryParam('primaryText') super.primaryText,
    @QueryParam('secondaryText') super.secondaryText,
  }) : super(key: const Key(AlertDialogViewRoute.name));

  @override
  Widget? buildContent(BuildContext context) {
    return TextField(
      controller: _textEditingController,
    );
  }

  @override
  Future<void> onPrimaryButtonPressed(BuildContext context) async {
    await AutoRouter.of(context).maybePop(_textEditingController.text);
  }

  @override
  Future<void> onSecondaryButtonPressed(BuildContext context) async {
    await AutoRouter.of(context).maybePop(null);
  }
}
