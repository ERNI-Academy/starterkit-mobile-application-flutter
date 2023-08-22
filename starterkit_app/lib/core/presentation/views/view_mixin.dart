import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart' hide View;
import 'package:reflectable/reflectable.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_observer.dart';
import 'package:starterkit_app/core/presentation/view_models/app_life_cycle_aware_mixin.dart';
import 'package:starterkit_app/core/presentation/view_models/first_renderable.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/core/presentation/view_models/route_aware_mixin.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/presentation/views/view.dart';
import 'package:starterkit_app/core/reflection.dart';
import 'package:starterkit_app/core/service_locator.dart';

mixin ViewMixin<TViewModel extends ViewModel> implements View<TViewModel> {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return _ViewModelBuilder<TViewModel>(
      create: () => onCreateViewModel(context),
      builder: buildView,
      dispose: onDisposeViewModel,
    );
  }

  @protected
  @override
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) {
    return _ViewLifeCycleHandler._onCreateViewModel<TViewModel>(context, getNavigationParams: false);
  }

  @protected
  @override
  @mustCallSuper
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) {
    _ViewLifeCycleHandler._onDisposeViewModel(context, viewModel);
  }
}

mixin ViewRouteMixin<TViewModel extends ViewModel> implements View<TViewModel> {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return _ViewModelBuilder<TViewModel>(
      create: () => onCreateViewModel(context),
      builder: (BuildContext context, TViewModel viewModel) {
        _ViewLifeCycleHandler._tryGetNavigationParams(context, viewModel);

        return buildView(context, viewModel);
      },
      dispose: onDisposeViewModel,
    );
  }

  @protected
  @override
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) {
    return _ViewLifeCycleHandler._onCreateViewModel<TViewModel>(context, getNavigationParams: true);
  }

  @protected
  @override
  @mustCallSuper
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) {
    _ViewLifeCycleHandler._onDisposeViewModel(context, viewModel);
  }
}

mixin ChildViewMixin<TViewModel extends ViewModel> implements View<TViewModel> {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return _ViewModelBuilder<TViewModel>(
      create: () => onCreateViewModel(context),
      builder: buildView,
      dispose: onDisposeViewModel,
    );
  }

  @protected
  @override
  @mustCallSuper
  TViewModel onCreateViewModel(BuildContext context) => context.viewModel<TViewModel>();

  @protected
  @override
  // Ignored because of satisfying an interface contract
  // ignore: no-empty-block
  void onDisposeViewModel(BuildContext context, TViewModel viewModel) {}
}

abstract final class _ViewLifeCycleHandler {
  static TViewModel _onCreateViewModel<TViewModel extends ViewModel>(
    BuildContext context, {
    required bool getNavigationParams,
  }) {
    final TViewModel viewModel = ServiceLocator.instance<TViewModel>();
    final ModalRoute<Object?>? route = ModalRoute.of(context);

    if (route != null && viewModel is RouteAwareMixin) {
      NavigationObserver.instance.subscribe(viewModel, route);
    }

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.addObserver(viewModel.appLifeCycleObserver);
    }

    _initializeViewModel(context, viewModel, getNavigationParams);

    return viewModel;
  }

  static void _onDisposeViewModel<TViewModel extends ViewModel>(BuildContext context, TViewModel viewModel) {
    viewModel.dispose();

    if (viewModel is RouteAwareMixin) {
      NavigationObserver.instance.unsubscribe(viewModel);
    }

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.removeObserver(viewModel.appLifeCycleObserver);
    }
  }

  static void _initializeViewModel<TViewModel extends ViewModel>(
    BuildContext context,
    TViewModel viewModel,
    bool getNavigationParams,
  ) {
    if (getNavigationParams) {
      _tryGetNavigationParams(context, viewModel);
    }

    if (viewModel is FirstRenderable) {
      final FirstRenderable firstRenderable = viewModel as FirstRenderable;
      WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(firstRenderable.onFirstRender()));
    }

    if (viewModel is Initializable) {
      final Initializable initializable = viewModel as Initializable;
      unawaited(initializable.onInitialize());
    }
  }

  static void _tryGetNavigationParams<TViewModel extends ViewModel>(BuildContext context, TViewModel viewModel) {
    final RouteData routeData = context.routeData;
    final Map<String, Object?> queryParams = Map<String, Object?>.from(routeData.queryParams.rawMap);
    final Map<String, Object?> pathParams = Map<String, Object?>.from(routeData.pathParams.rawMap);
    final bool hasParams = queryParams.isNotEmpty || pathParams.isNotEmpty;
    final bool canReflect = navigatable.canReflect(viewModel) || navigatable.canReflectType(TViewModel);

    if (hasParams && !canReflect) {
      throw StateError('ViewModel $TViewModel with navigation parameters must be annotated with @navigatable');
    }

    if (!hasParams && canReflect) {
      throw StateError('ViewModel $TViewModel was annotated with @navigatable but has no navigation parameters');
    }

    if (hasParams && canReflect) {
      final InstanceMirror instanceMirror = navigatable.reflect(viewModel);
      final ClassMirror typeMirror = navigatable.reflectType(TViewModel) as ClassMirror;

      for (final MapEntry<String, Object?> queryParam in queryParams.entries) {
        final Object? value = queryParam.value;

        if (value == null) {
          continue;
        }

        bool predicate(DeclarationMirror element) =>
            element.metadata.any((Object m) => m is QueryParam && m.name == queryParam.key);
        _setValue(instanceMirror, typeMirror, predicate, value);
      }

      for (final MapEntry<String, Object?> pathParam in pathParams.entries) {
        final Object? value = pathParam.value;

        if (value == null) {
          continue;
        }

        bool predicate(DeclarationMirror element) =>
            element.metadata.any((Object m) => m is PathParam && m.name == pathParam.key);
        _setValue(instanceMirror, typeMirror, predicate, value);
      }
    }
  }

  static void _setValue(
    InstanceMirror instanceMirror,
    ClassMirror classMirror,
    bool Function(DeclarationMirror element) predicate,
    Object value,
  ) {
    final Iterable<DeclarationMirror> declarationValues = classMirror.declarations.values;

    if (declarationValues.any(predicate)) {
      final DeclarationMirror? matchingDeclaration = declarationValues.firstWhereOrNull(predicate);

      if (matchingDeclaration == null) {
        throw StateError('Could not find matching declaration for $value');
      }

      instanceMirror.invokeSetter(matchingDeclaration.simpleName, value);
    }
  }
}

class _ViewModelBuilder<TViewModel extends ViewModel> extends StatefulWidget {
  const _ViewModelBuilder({required this.create, required this.builder, this.dispose, super.key});

  final TViewModel Function() create;
  final Widget Function(BuildContext context, TViewModel viewModel) builder;
  final void Function(BuildContext context, TViewModel viewModel)? dispose;

  @override
  State<StatefulWidget> createState() => _ViewModelBuilderState<TViewModel>();
}

class _ViewModelBuilderState<TViewModel extends ViewModel> extends State<_ViewModelBuilder<TViewModel>> {
  TViewModel? _currentViewModel;

  TViewModel get _viewModel {
    if (_currentViewModel == null) {
      throw StateError('ViewModel is not initialized');
    }

    // Ignored since the value is guaranteed to be non-null
    // ignore: avoid-non-null-assertion
    return _currentViewModel!;
  }

  @override
  void initState() {
    super.initState();

    _currentViewModel = widget.create();
  }

  @override
  void dispose() {
    widget.dispose?.call(context, _viewModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (BuildContext context, Widget? child) {
        return _ViewModelHolder<TViewModel>(
          viewModel: _viewModel,
          child: widget.builder(context, _viewModel),
        );
      },
    );
  }
}

class _ViewModelHolder<T extends ViewModel> extends InheritedWidget {
  const _ViewModelHolder({required super.child, required this.viewModel, super.key});

  final T viewModel;

  @override
  bool updateShouldNotify(_ViewModelHolder<T> oldWidget) {
    return false;
  }

  static _ViewModelHolder<T>? _of<T extends ViewModel>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ViewModelHolder<T>>();
  }
}

extension ViewExtensions on BuildContext {
  T viewModel<T extends ViewModel>() {
    final T? viewModel = _ViewModelHolder._of<T>(this)?.viewModel;

    if (viewModel == null) {
      throw StateError('Could not locate viewmodel $T');
    }

    return viewModel;
  }
}
