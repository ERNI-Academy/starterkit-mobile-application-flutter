import 'package:erni_mobile/domain/services/ui/navigation_service.dart';
import 'package:flutter/widgets.dart';

/// Contains the state of your view.
abstract class ViewModel<TParameter extends Object> extends ChangeNotifier {
  /// Called when this view model was first initialized.
  ///
  /// This will execute even though the first frame has not been rendered.
  ///
  /// Use [onFirstRender] for logic that will run
  /// after the first frame has been rendered.
  ///
  /// [parameter] and [queries] are passed when navigating to this view model.
  Future<void> onInitialize([TParameter? parameter, Queries queries = const {}]) async {}

  /// Called when the view of this view model has rendered its first frame.
  ///
  /// It uses [WidgetsBinding.instance.addPostFrameCallback].
  ///
  /// [parameter] and [queries] are passed when navigating to this view model.
  Future<void> onFirstRender([TParameter? parameter, Queries queries = const {}]) async {}
}
