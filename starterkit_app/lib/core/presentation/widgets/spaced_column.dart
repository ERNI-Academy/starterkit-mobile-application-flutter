import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/widgets/spaced_linear_layout.dart';

/// A custom widget similar to [Column], but allows
/// setting the [spacing] between each [children].
class SpacedColumn extends SpacedLinearLayout {
  const SpacedColumn({
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
  Axis get axis => Axis.vertical;

  @override
  Widget build(BuildContext context) {
    return Column(
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
