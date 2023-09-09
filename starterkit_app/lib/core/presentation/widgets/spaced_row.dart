// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/widgets/spaced_linear_layout.dart';

/// A custom widget similar to [Row], but allows
/// setting the [spacing] between each [children].
class SpacedRow extends SpacedLinearLayout {
  const SpacedRow({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.children,
    super.spacing,
  });

  @override
  Axis get axis => Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: getChildren(),
    );
  }
}
