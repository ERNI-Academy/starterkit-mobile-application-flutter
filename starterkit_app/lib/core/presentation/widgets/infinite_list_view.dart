// coverage:ignore-file

import 'package:flutter/widgets.dart';

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({required this.itemCount, required this.itemBuilder, required this.onScrollEnd, super.key});

  final VoidCallback onScrollEnd;
  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  final ScrollController _scrollController = ScrollController();
  late final VoidCallback _scrollListener;

  @override
  void initState() {
    super.initState();
    _scrollListener = () {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        widget.onScrollEnd();
      }
    };
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: widget.itemBuilder,
      itemCount: widget.itemCount,
    );
  }
}
