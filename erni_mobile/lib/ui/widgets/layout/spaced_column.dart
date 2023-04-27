// coverage:ignore-file

import 'package:flutter/material.dart';

/// A custom widget similar to [Column], but allows
/// setting the [spacing] between each [children].
class SpacedColumn extends StatelessWidget {
  const SpacedColumn({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    this.spacing = 4,
  }) : assert(spacing > 0);

  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Iterable<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      // ignore: avoid-returning-widgets
      children: _getChildren(),
    );
  }

  List<Widget> _getChildren() {
    final newChildren = <Widget>[];

    for (final w in children) {
      newChildren.add(w);
      if (children.last != w) {
        newChildren.add(SizedBox(height: spacing));
      }
    }

    return newChildren;
  }
}
