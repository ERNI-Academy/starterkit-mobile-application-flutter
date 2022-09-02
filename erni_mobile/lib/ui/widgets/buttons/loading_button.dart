// coverage:ignore-file

import 'package:erni_mobile/ui/widgets/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:simple_command/commands.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({required this.command, required this.child, Key? key}) : super(key: key);

  final AsyncRelayCommand command;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: command,
      child: ValueListenableBuilder<bool>(
        valueListenable: command.isExecuting,
        builder: (context, isExecuting, _) {
          if (isExecuting) {
            return SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: context.materialTheme.colorScheme.onPrimary,
              ),
            );
          }

          return child;
        },
      ),
    );
  }
}
