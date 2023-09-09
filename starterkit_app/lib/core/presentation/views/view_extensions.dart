import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/presentation/views/view_model_holder.dart';

extension ViewExtensions on BuildContext {
  T viewModel<T extends ViewModel>() {
    final T? viewModel = ViewModelHolder.of<T>(this)?.viewModel;

    if (viewModel == null) {
      throw StateError('Could not locate viewmodel $T');
    }

    return viewModel;
  }
}
