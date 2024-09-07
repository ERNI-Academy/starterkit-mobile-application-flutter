// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
class CustomDialogRoute<T> extends CustomRoute<T> {
  static const int animationDurationInMs = 300;
  static const int reverseAnimationDurationInMs = 300;
  static final Color dialogBarrierColor = Colors.black.withOpacity(0.5);

  CustomDialogRoute({required super.page, super.path})
      : super(
          fullscreenDialog: true,
          transitionsBuilder: _dialogTransitionBuilder,
          durationInMilliseconds: animationDurationInMs,
          reverseDurationInMilliseconds: reverseAnimationDurationInMs,
          opaque: false,
          barrierDismissible: true,
          barrierColor: dialogBarrierColor,
        );

  static Widget _dialogTransitionBuilder(
    BuildContext _,
    Animation<double> animation,
    Animation<double> __,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
      child: child,
    );
  }
}
