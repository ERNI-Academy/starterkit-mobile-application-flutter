import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/ui/view_models/app_lifecycle_aware_mixin.dart';
import 'package:erni_mobile/domain/ui/view_models/route_aware_mixin.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Configures a [StatelessWidget] or [State] as a view.
///
/// This will locate and initialize the view model [TViewModel], then it can be used to build the layout.
abstract class ViewMixin<TViewModel extends ViewModel> {
  @mustCallSuper
  Widget build(BuildContext context) {
    return ListenableProvider<TViewModel>(
      create: (_) => onCreateViewModel(context),
      dispose: onDisposeViewModel,
      builder: (context, child) {
        final viewModel = context.watch<TViewModel>();

        return buildView(context, viewModel);
      },
    );
  }

  /// Called when [ChangeNotifier.dispose] was called by the view model.
  ///
  /// Unregisters the view model to various subscriptions.
  @protected
  @mustCallSuper
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) {
    viewModel.dispose();

    if (viewModel is RouteAwareMixin) {
      NavigationService.navigationObserverRegistrar.unsubscribe(viewModel);
    }

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.removeObserver(viewModel);
    }
  }

  /// Creates the view model by resolving it using the [ServiceLocator.instance].
  ///
  /// Registers the view model to various subscriptions.
  @protected
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) {
    final viewModel = ServiceLocator.instance<TViewModel>();

    // Add route observer
    final route = ModalRoute.of(context);

    if (route != null && viewModel is RouteAwareMixin) {
      NavigationService.navigationObserverRegistrar.subscribe(viewModel, route);
    }

    // Add binding observer
    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.addObserver(viewModel);
    }

    _initializeViewModel(viewModel, route?.settings.name, route?.settings.arguments);
    WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.onFirstRender());

    return viewModel;
  }

  /// Builds the layout of this view.
  @protected
  Widget buildView(BuildContext context, TViewModel viewModel);

  static void _initializeViewModel<TViewModel extends ViewModel>(
    TViewModel viewModel,
    String? routeName,
    Object? parameter,
  ) {
    final queries = <String, String>{};

    if (routeName != null) {
      final routeUri = Uri.parse(routeName);
      queries.addAll(routeUri.queryParameters);
    }

    viewModel.onInitialize(parameter, queries);
  }
}

/// Configures a [StatelessWidget] or [State] as a child view of another.
///
/// Provides the view model [TViewModel] that is located in the parent view.
abstract class ChildViewMixin<TViewModel extends ViewModel> {
  @mustCallSuper
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: onCreateViewModel,
      builder: (context, child) {
        final viewModel = context.watch<TViewModel>();

        return buildView(context, viewModel);
      },
    );
  }

  /// Called when [ChangeNotifier.dispose] was called by the view model.
  @protected
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) => Future<void>.value();

  /// Uses [Provider.of] for looking up the widget tree for closest view model of the exact type.
  @protected
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) {
    final viewModel = Provider.of<TViewModel>(context, listen: false);

    if (!viewModel.isDisposed.value) {
      void onDispose() {
        if (viewModel.isDisposed.value) {
          onDisposeViewModel(context, viewModel);
          viewModel.isDisposed.removeListener(onDispose);
        }
      }

      viewModel.isDisposed.addListener(onDispose);
    }

    return viewModel;
  }

  /// Builds the layout of this view.
  @protected
  Widget buildView(BuildContext context, TViewModel viewModel);
}
