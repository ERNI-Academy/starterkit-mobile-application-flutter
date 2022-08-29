// ignore_for_file: avoid-unused-parameters

import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_observer_registrar.dart';
import 'package:erni_mobile/ui/view_models/app_lifecycle_aware_mixin.dart';
import 'package:erni_mobile/ui/view_models/route_aware_mixin.dart';
import 'package:erni_mobile/ui/view_models/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Configures a [StatelessWidget] or [State] as a view.
///
/// This will locate and initialize the view model [TViewModel], then it can be used to build the layout.
mixin ViewMixin<TViewModel extends ViewModel> {
  final _ViewDependencies<TViewModel> _viewDependencies = _ViewDependencies<TViewModel>();

  @protected
  @nonVirtual
  TViewModel get viewModel => _viewDependencies.viewModel;

  @mustCallSuper
  Widget build(BuildContext context) {
    return ListenableProvider<TViewModel>(
      create: (_) => onCreateViewModel(context),
      dispose: onDisposeViewModel,
      builder: (context, child) {
        _viewDependencies.viewModel = context.watch<TViewModel>();

        return WillPopScope(
          onWillPop: viewModel.onWillPop,
          child: buildView(context),
        );
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

    if (_viewDependencies.routeAwareWrapper != null) {
      NavigationObserverRegistrar.instance.unsubscribe(_viewDependencies.routeAwareWrapper!);
    }

    if (_viewDependencies.widgetsBindingObserverWrapper != null) {
      WidgetsBinding.instance.removeObserver(_viewDependencies.widgetsBindingObserverWrapper!);
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
      _viewDependencies.routeAwareWrapper = RouteAwareWrapper(viewModel as RouteAwareMixin);
      NavigationObserverRegistrar.instance.subscribe(_viewDependencies.routeAwareWrapper!, route);
    }

    // Add binding observer
    if (viewModel is AppLifeCycleAwareMixin) {
      _viewDependencies.widgetsBindingObserverWrapper =
          WidgetsBindingObserverWrapper(viewModel as AppLifeCycleAwareMixin);
      WidgetsBinding.instance.addObserver(_viewDependencies.widgetsBindingObserverWrapper!);
    }

    _initializeViewModel(viewModel, route?.settings.name, route?.settings.arguments);

    return _viewDependencies.viewModel = viewModel;
  }

  /// Builds the layout of this view.
  @protected
  Widget buildView(BuildContext context);

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
mixin ChildViewMixin<TViewModel extends ViewModel> {
  final _ViewDependencies<TViewModel> _viewDependencies = _ViewDependencies<TViewModel>();

  @protected
  @nonVirtual
  TViewModel get viewModel => _viewDependencies.viewModel;

  @mustCallSuper
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: onCreateViewModel,
      builder: (context, child) {
        _viewDependencies.viewModel = context.watch<TViewModel>();

        return buildView(context);
      },
    );
  }

  /// Called when [ChangeNotifier.dispose] was called by the view model.
  @protected
  void onDisposeViewModel(TViewModel viewModel) => Future<void>.value();

  /// Uses [Provider.of] for looking up the widget tree for closest view model of the exact type.
  @protected
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) {
    final viewModel = Provider.of<TViewModel>(context, listen: false);

    if (!viewModel.isDisposed.value) {
      void onDispose() {
        if (viewModel.isDisposed.value) {
          onDisposeViewModel(viewModel);
          viewModel.isDisposed.removeListener(onDispose);
        }
      }

      viewModel.isDisposed.addListener(onDispose);
    }

    return _viewDependencies.viewModel = viewModel;
  }

  /// Builds the layout of this view.
  @protected
  Widget buildView(BuildContext context);
}

class _ViewDependencies<T extends ViewModel> {
  RouteAwareWrapper? routeAwareWrapper;
  WidgetsBindingObserverWrapper? widgetsBindingObserverWrapper;
  late T viewModel;
}
