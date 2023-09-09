import 'package:flutter/widgets.dart' hide View;
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

class ViewModelHolder<T extends ViewModel> extends InheritedWidget {
  const ViewModelHolder({required super.child, required this.viewModel, super.key});

  final T viewModel;

  static ViewModelHolder<T>? of<T extends ViewModel>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ViewModelHolder<T>>();
  }

  @override
  bool updateShouldNotify(ViewModelHolder<T> oldWidget) {
    return false;
  }
}
