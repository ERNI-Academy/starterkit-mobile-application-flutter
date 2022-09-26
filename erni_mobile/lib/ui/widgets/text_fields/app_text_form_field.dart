// coverage:ignore-file

import 'package:erni_mobile/ui/widgets/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    required this.labelText,
    required this.onChanged,
    this.hasError = false,
    this.autofillHints = const [],
    this.isPassword = false,
    this.enabled = true,
    this.initialValue,
    this.textInputType,
    this.focusNode,
    super.key,
  });

  final void Function(String) onChanged;
  final String labelText;
  final String? initialValue;
  final bool isPassword;
  final bool hasError;
  final bool enabled;
  final Iterable<String> autofillHints;
  final TextInputType? textInputType;
  final FocusNode? focusNode;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  Widget? _effectiveSuffixIcon;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(text: widget.initialValue);
    _textEditingController.addListener(() {
      widget.onChanged(_textEditingController.text);
      setState(_updateSuffixIcon);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      style: context.materialTheme.textTheme.bodyLarge?.copyWith(color: context.materialTheme.colorScheme.onBackground),
      focusNode: _focusNode,
      autofillHints: widget.autofillHints,
      keyboardType: widget.textInputType,
      enabled: widget.enabled,
      decoration: InputDecoration(
        errorText: widget.hasError ? '' : null,
        errorStyle: const TextStyle(fontSize: 0, height: 0),
        label: Text(widget.labelText),
        floatingLabelStyle: context.materialTheme.textTheme.bodyLarge?.copyWith(
          color: widget.hasError
              ? context.materialTheme.colorScheme.error
              : context.materialTheme.colorScheme.onSurfaceVariant,
        ),
        labelStyle: context.materialTheme.textTheme.bodyLarge?.copyWith(
          color: context.materialTheme.colorScheme.onSurfaceVariant,
        ),
        suffixIcon: _effectiveSuffixIcon,
      ),
      obscureText: widget.isPassword,
      obscuringCharacter: '*',
    );
  }

  void _updateSuffixIcon() {
    _effectiveSuffixIcon = _textEditingController.text.isNotEmpty
        ? ExcludeFocus(
            child: IconButton(
              icon: Icon(
                Icons.cancel_outlined,
                color: context.materialTheme.colorScheme.onSurfaceVariant,
              ),
              onPressed: _textEditingController.clear,
              splashRadius: 1,
            ),
          )
        : null;
  }
}
