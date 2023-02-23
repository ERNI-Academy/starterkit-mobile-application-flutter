import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:flutter/widgets.dart';

/// Contains the state of your view.
abstract class ViewModel extends ChangeNotifier {
  /// Locates the closest [T] view model up in the widget tree.
  static T of<T extends ViewModel>(BuildContext context) {
    final viewModel = ViewModelHolder.of<T>(context)?.viewModel;

    if (viewModel == null) {
      throw StateError('Could not locate viewmodel $T');
    }

    return viewModel;
  }

  /// Called when this view model was first initialized.
  ///
  /// This will execute even though the first frame has not been rendered.
  ///
  /// Use [onFirstRender] for logic that will run after the first frame has been rendered.
  Future<void> onInitialize() => Future.value();

  /// Called when the view of this view model has rendered its first frame.
  ///
  /// It uses [WidgetsBinding.instance.addPostFrameCallback].
  Future<void> onFirstRender() => Future.value();
}
