import 'package:flutter/widgets.dart';

class ViewModelProvider<T> extends InheritedWidget {
  const ViewModelProvider({
    required this.viewModel,
    required super.child,
    super.key,
  });

  final T viewModel;

  static ViewModelProvider<T> of<T>(BuildContext context) {
    final ViewModelProvider<T>? viewModelProvider = context.dependOnInheritedWidgetOfExactType<ViewModelProvider<T>>();

    if (viewModelProvider == null) {
      throw StateError('ViewModelProvider is not found');
    }

    return viewModelProvider;
  }

  @override
  bool updateShouldNotify(ViewModelProvider<T> oldWidget) {
    return true;
  }
}

extension ViewModelProviderExtension on BuildContext {
  T viewModel<T>() {
    return ViewModelProvider.of<T>(this).viewModel;
  }
}
