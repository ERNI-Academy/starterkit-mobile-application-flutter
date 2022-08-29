import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdaptiveStatusBar extends StatelessWidget {
  const AdaptiveStatusBar({
    required this.child,
    this.referenceColor,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Color? referenceColor;

  @override
  Widget build(BuildContext context) {
    final colorLuminance = (referenceColor ?? Theme.of(context).colorScheme.primary).computeLuminance();
    final effectiveBrightness = colorLuminance < 0.4 ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: effectiveBrightness,
      child: child,
    );
  }
}
