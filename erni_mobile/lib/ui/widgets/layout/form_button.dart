// coverage:ignore-file

import 'package:erni_mobile/ui/view_models/form_view_model.dart';
import 'package:erni_mobile_core/mvvm.dart';
import 'package:flutter/material.dart';

class FormButton<T extends FormViewModel> extends StatelessWidget with ChildViewMixin<T> {
  FormButton({required this.submitLabel, required this.formBodyFocusNode, super.key});

  final String submitLabel;
  final FocusNode formBodyFocusNode;

  @override
  Widget buildView(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;
    final hasBottomPadding = bottomPadding > 0;

    return SizedBox(
      width: mediaQuery.size.width,
      child: ElevatedButton(
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24).add(
            hasBottomPadding ? EdgeInsets.only(bottom: bottomPadding - 16) : EdgeInsets.zero,
          ),
          child: Text(
            submitLabel,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    formBodyFocusNode.unfocus();
    viewModel.submitCommand();
  }
}
