// coverage:ignore-file

import 'package:erni_mobile/ui/view_models/form_view_model.dart';
import 'package:erni_mobile/ui/widgets/texts/form_error_text.dart';
import 'package:erni_mobile_blueprint_core/mvvm.dart';
import 'package:erni_mobile_blueprint_core/widgets.dart';
import 'package:flutter/material.dart';

class FormBody<T extends FormViewModel> extends StatelessWidget with ChildViewMixin<T> {
  FormBody({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget buildView(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: viewModel.errorMessage,
      builder: (context, errorMessage, child) {
        return SpacedColumn(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (errorMessage.isNotEmpty) FormErrorText(errorMessage),
            ...children,
          ],
        );
      },
    );
  }
}
