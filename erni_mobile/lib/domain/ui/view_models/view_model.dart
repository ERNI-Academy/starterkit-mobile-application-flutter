import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:flutter/widgets.dart';

/// Contains the state of your view.
abstract class ViewModel<TParameter extends Object> extends ChangeNotifier {
  /// Determines whether this view model was disposed.
  final ValueNotifier<bool> isDisposed = ValueNotifier(false);

  @override
  @mustCallSuper
  void dispose() {
    isDisposed.value = true;
    super.dispose();
  }

  /// Called when this view model was first initialized.
  ///
  /// This will execute even though the first frame has not been rendered.
  ///
  /// Use [onFirstRender] for logic that will run
  /// after the first frame has been rendered.
  ///
  /// [parameter] and [queries] are passed when navigating to this view model.
  Future<void> onInitialize([TParameter? parameter, Queries queries = const {}]) => Future.value();

  /// Called when the view of this view model has rendered its first frame.
  ///
  /// It uses [WidgetsBinding.instance.addPostFrameCallback].
  ///
  /// [parameter] and [queries] are passed when navigating to this view model.
  Future<void> onFirstRender([TParameter? parameter, Queries queries = const {}]) => Future.value();
}
