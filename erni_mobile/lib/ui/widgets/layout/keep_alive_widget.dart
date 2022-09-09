import 'package:flutter/widgets.dart';

class KeepAliveWidget extends StatefulWidget {
  const KeepAliveWidget({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }
}
