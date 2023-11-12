View Models contains the state of your view.

```dart
@injectable
class SplashViewModel extends ViewModel implements Initializable, FirstRenderable {
  @override
  Future<void> onInitialize() async {
    // your initialization logic after the view model was created
  }

  @override
  Future<void> onFirstRender() async {
    // your initialization logic after the first frame has rendered
  }
}
```

- The `ViewModel` class inherits from `ChangeNotifier`.
- A new instance is returned always whenever we resolve a view model.
- To know how to extract parameters passed during navigation, read about it [here](navigation).

<div style="">

:bulb: **<span style="color: green">TIP</span>**

- Use the snippet shortcut `vm` to create a view model class.

</div>

:warning: **<span style="color: orange">AVOID</span>**

- You can call `notifyListeners` and this will trigger a rebuild of the whole UI. This is equivalent of calling `setState` when using a `StatefulWidget`.

Use `notifyListeners` sparingly and only in situations where you really need it.

```dart
@injectable
class SplashViewModel extends ViewModel implements Initializable {
  bool isInitialized = false;
  
  @override
  Future<void> onInitialize() async {
    isInitialized = true;
    notifyListeners();
  }
}
```

Read more about the project's state management approach [here](state-management).

## Lifecycle

- When mixing-in `Initializable`, `onInitialize` is called when the view model was first initialized.
- When mixing-in `FirsRenderable`, `onFirstRender` is called when the view of the view model has rendered its first frame.
- `dispose` is called whenever the view to which this view model is attached to is removed from the tree.

:bulb: **<span style="color: green">TIP</span>**

- Use the snippet shortcut `initVm` for overriding `onInitialize`, and `dis` for `dispose`.

## Observing App Lifecycle

You can mix `AppLifeCycleAwareMixin` to your `ViewModel` class. It implements the [`WidgetsBindingObserver`](https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver-class.html).

You can observe app lifecylce changes by overriding any the following:

```dart
@protected
@override
Future<void> onAppPaused() {
  // do something when app is paused
}

@protected
@override
Future<void> onAppResumed() {
  // do something when app is resumed
}

@protected
@override
Future<void> onAppInactive() {
  // do something when app is inactive
}

@protected
@override
Future<void> onAppDetached() {
  // do something when app is detached
}

@protected
@override
Future<void> onAppHidden() {
  // do something when app is hidden
}
```

## Observing Route Changes

You can mix `RouteAwareMixin` to your `ViewModel` class. It implements the [`RouteAware`](https://api.flutter.dev/flutter/widgets/RouteAware-class.html).

You can observe route changes by overriding the following:

```dart
@protected
@override
Future<void> didPop() {
  // do something when the current route has been popped
}

@protected
@override
Future<void> didPush() {
  // do something when the current route has been pushed
}

@protected
@override
Future<void> didPopNext() {
  // do something when the current route is visible after the previous route has been popped
}

@protected
@override
Future<void> didPushNext() {
  // do something when the current route is no longer visible after the new route has been pushed
}
```
