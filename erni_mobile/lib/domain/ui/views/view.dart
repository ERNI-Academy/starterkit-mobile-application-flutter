import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:flutter/widgets.dart';

/// A collection of visible elements that receives user inputs.
abstract class View<TViewModel extends ViewModel> {
  /// Builds the layout of this widget.
  Widget build(BuildContext context);

  /// Builds the layout of this view.
  Widget buildView(BuildContext context, TViewModel viewModel);

  /// Creates the view model [TViewModel] for this view.
  TViewModel onCreateViewModel(BuildContext context);

  /// Called when [ChangeNotifier.dispose] was called by the view model.
  void onDisposeViewModel(BuildContext context, TViewModel viewModel);
}
