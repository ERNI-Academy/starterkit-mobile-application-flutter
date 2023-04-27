// coverage:ignore-file

import 'package:erni_mobile/ui/widgets/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class FormErrorText extends StatelessWidget {
  const FormErrorText(this.errorMessage, {super.key});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final errorColor = context.materialTheme.colorScheme.error;

    return Container(
      padding: const EdgeInsets.all(8),
      color: errorColor.withOpacity(0.08),
      child: Text(
        errorMessage,
        style: TextStyle(color: errorColor),
      ),
    );
  }
}
