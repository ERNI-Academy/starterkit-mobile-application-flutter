// coverage:ignore-file

import 'package:flutter/material.dart';

/// A custom widget similar to [Row], but allows
/// setting the [spacing] between each [children].
class SpacedRow extends StatelessWidget {
  const SpacedRow({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    this.spacing = 4,
  })  : assert(spacing > 0),
        super(key: key);

  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      // ignore: avoid-returning-widgets
      children: getChildren(),
    );
  }

  List<Widget> getChildren() {
    final newChildren = <Widget>[];

    for (final w in children) {
      newChildren.add(w);
      if (children.last != w) {
        newChildren.add(SizedBox(width: spacing));
      }
    }

    return newChildren;
  }
}
