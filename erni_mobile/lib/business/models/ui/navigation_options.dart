class NavigationOptions {
  NavigationOptions(this.argument, {this.isRoot = false, this.isFullScreenDialog = false});

  final Object? argument;
  final bool isRoot;
  final bool isFullScreenDialog;
}
