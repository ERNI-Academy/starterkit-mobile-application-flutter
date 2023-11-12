import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:reflectable/reflectable.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_observer.dart';
import 'package:starterkit_app/core/presentation/view_models/app_life_cycle_aware_mixin.dart';
import 'package:starterkit_app/core/presentation/view_models/first_renderable.dart';
import 'package:starterkit_app/core/presentation/view_models/initializable.dart';
import 'package:starterkit_app/core/presentation/view_models/route_aware_mixin.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/reflection.dart';
import 'package:starterkit_app/core/service_locator.dart';

abstract final class ViewLifeCycleHandler {
  static final NavigationObserver _navigationObserver = ServiceLocator.instance<NavigationObserver>();

  static TViewModel onCreateViewModel<TViewModel extends ViewModel>(
    BuildContext context, {
    required bool getNavigationParams,
  }) {
    final TViewModel viewModel = ServiceLocator.instance<TViewModel>();
    final ModalRoute<Object?>? route = ModalRoute.of(context);

    if (route != null && viewModel is RouteAwareMixin) {
      _navigationObserver.subscribe(viewModel, route);
    }

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.addObserver(viewModel.appLifeCycleObserver);
    }

    _initializeViewModel(context, viewModel, getNavigationParams);

    return viewModel;
  }

  static void onDisposeViewModel<TViewModel extends ViewModel>(BuildContext context, TViewModel viewModel) {
    viewModel.dispose();

    if (viewModel is RouteAwareMixin) {
      _navigationObserver.unsubscribe(viewModel);
    }

    if (viewModel is AppLifeCycleAwareMixin) {
      WidgetsBinding.instance.removeObserver(viewModel.appLifeCycleObserver);
    }
  }

  static void tryGetNavigationParams<TViewModel extends ViewModel>(BuildContext context, TViewModel viewModel) {
    final RouteData routeData = context.routeData;
    final Map<String, Object?> queryParams = Map<String, Object?>.from(routeData.queryParams.rawMap);
    final Map<String, Object?> pathParams = Map<String, Object?>.from(routeData.pathParams.rawMap);
    final bool hasParams = queryParams.isNotEmpty || pathParams.isNotEmpty;
    final bool isNavigatable = navigatable.canReflect(viewModel) || navigatable.canReflectType(TViewModel);

    if (hasParams && !isNavigatable) {
      throw StateError('ViewModel $TViewModel with navigation parameters must be annotated with @navigatable');
    }

    if (!hasParams && isNavigatable) {
      throw StateError('ViewModel $TViewModel was annotated with @navigatable but has no navigation parameters');
    }

    if (hasParams && isNavigatable) {
      final InstanceMirror instanceMirror = navigatable.reflect(viewModel);
      final ClassMirror typeMirror = navigatable.reflectType(TViewModel) as ClassMirror;
      _readAndSetValueFor(queryParams.entries, instanceMirror, typeMirror);
      _readAndSetValueFor(pathParams.entries, instanceMirror, typeMirror);
    }
  }

  static void _initializeViewModel<TViewModel extends ViewModel>(
    BuildContext context,
    TViewModel viewModel,
    bool getNavigationParams,
  ) {
    if (getNavigationParams) {
      tryGetNavigationParams(context, viewModel);
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

  static void _readAndSetValueFor(
    Iterable<MapEntry<String, Object?>> entries,
    InstanceMirror instanceMirror,
    ClassMirror typeMirror,
  ) {
    for (final MapEntry<String, Object?> paramValue in entries) {
      final Object? value = paramValue.value;

      if (value == null) {
        continue;
      }

      bool predicate(DeclarationMirror element) => element.metadata.any((Object m) {
            return switch (m) {
              final QueryParam query => query.name == paramValue.key,
              final PathParam path => path.name == paramValue.key,
              _ => false,
            };
          });
      _setValue(instanceMirror, typeMirror, predicate, value);
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
