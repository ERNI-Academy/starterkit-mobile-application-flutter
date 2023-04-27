import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/views/view_mixin.dart';

export 'package:flutter/foundation.dart';
export 'package:rxdart/rxdart.dart';

abstract class ViewModel extends ChangeNotifier {
  static T of<T extends ViewModel>(BuildContext context) {
    final viewModel = ViewModelHolder.of<T>(context)?.viewModel;

    if (viewModel == null) {
      throw StateError('Could not locate viewmodel $T');
    }

    return viewModel;
  }

  Future<void> onInitialize() => Future.value();

  Future<void> onFirstRender() => Future.value();
}
