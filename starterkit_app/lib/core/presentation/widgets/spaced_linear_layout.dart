// coverage:ignore-file

import 'package:flutter/widgets.dart';

abstract class SpacedLinearLayout extends StatelessWidget {
  static const double _defaultSpacing = 4;

  const SpacedLinearLayout({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    this.spacing = _defaultSpacing,
  }) : assert(spacing > 0, 'Spacing must be greater than 0');

  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Iterable<Widget> children;

  Axis get axis;

  @protected
  List<Widget> getChildren() {
    final List<Widget> newChildren = <Widget>[];

    for (final Widget child in children) {
      newChildren.add(child);

      if (children.lastOrNull != child) {
        SizedBox spacer;

        switch (axis) {
          case Axis.horizontal:
            spacer = SizedBox(width: spacing);

          case Axis.vertical:
            spacer = SizedBox(height: spacing);
        }

        newChildren.add(spacer);
      }
    }

    return newChildren;
  }
}
