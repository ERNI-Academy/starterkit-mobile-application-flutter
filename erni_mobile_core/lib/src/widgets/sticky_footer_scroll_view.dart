import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Based from https://github.com/MayLau-CbL/sticky-footer-scrollview/blob/master/lib/sticky_footer_scrollview.dart

class StickyFooterScrollView extends StatefulWidget {
  factory StickyFooterScrollView.builder({
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
    required Widget footer,
    ScrollController? controller,
    Color? backgroundColor,
    Key? key,
  }) {
    return StickyFooterScrollView._(
      key: key,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      footer: footer,
      scrollController: controller,
      backgroundColor: backgroundColor,
    );
  }

  factory StickyFooterScrollView.explicit({
    required List<Widget> children,
    required Widget footer,
    ScrollController? controller,
    Color? backgroundColor,
    Key? key,
  }) {
    return StickyFooterScrollView._(
      key: key,
      footer: footer,
      scrollController: controller,
      backgroundColor: backgroundColor,
      children: children,
    );
  }

  const StickyFooterScrollView._({
    required this.footer,
    this.itemBuilder,
    this.itemCount,
    this.children = const [],
    this.scrollController,
    this.backgroundColor,
    Key? key,
  })  : assert(
          ((itemCount != null && itemBuilder != null) && children.length == 0) ||
              ((itemCount == null && itemBuilder == null) && children.length > 0),
        ),
        super(key: key);

  final int? itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final List<Widget> children;
  final Widget footer;
  final ScrollController? scrollController;
  final Color? backgroundColor;

  @override
  StickyFooterScrollViewState createState() => StickyFooterScrollViewState();
}

class StickyFooterScrollViewState extends State<StickyFooterScrollView> {
  double? _width;
  double? _height;

  @override
  Widget build(BuildContext context) {
    final listView = widget.itemBuilder != null
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: widget.itemBuilder!,
            itemCount: widget.itemCount,
          )
        : ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: widget.children,
          );

    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          controller: widget.scrollController,
          child: Container(
            color: widget.backgroundColor,
            constraints: BoxConstraints(maxHeight: _height ?? double.maxFinite),
            child: CustomMultiChildLayout(
              delegate: _StickyHeaderFooterScrollViewDelegate(
                constraint.maxHeight,
                constraint.maxWidth,
                _onUpdateSize,
              ),
              children: [
                LayoutId(
                  id: _StickyScrollView.body,
                  child: listView,
                ),
                LayoutId(
                  id: _StickyScrollView.footer,
                  child: widget.footer,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onUpdateSize(double width, double height) {
    if (width != _width || height != _height) {
      _width = width;
      _height = height;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        // ignore: no-empty-block
        setState(() {});
      });
    }
  }
}

class _StickyHeaderFooterScrollViewDelegate extends MultiChildLayoutDelegate {
  _StickyHeaderFooterScrollViewDelegate(this.height, this.width, this.updateSize);

  final double height;
  final double width;
  final Function(double, double) updateSize;

  @override
  void performLayout(Size size) {
    Size leadingSize = Size.zero;

    if (hasChild(_StickyScrollView.body)) {
      leadingSize = layoutChild(
        _StickyScrollView.body,
        BoxConstraints(maxWidth: width),
      );

      positionChild(_StickyScrollView.body, const Offset(0, 0));
    }

    if (hasChild(_StickyScrollView.footer)) {
      final footerSize = layoutChild(
        _StickyScrollView.footer,
        BoxConstraints(
          maxWidth: width,
        ),
      );
      final double remainingHeight = height - leadingSize.height - footerSize.height;

      if (remainingHeight > 0) {
        positionChild(
          _StickyScrollView.footer,
          Offset(0, height - footerSize.height),
        );
        updateSize(width, height);
      } else {
        positionChild(
          _StickyScrollView.footer,
          Offset(0, leadingSize.height),
        );
        updateSize(width, leadingSize.height + footerSize.height);
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

enum _StickyScrollView { body, footer }
