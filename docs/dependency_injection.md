# Dependency Injection

Since Flutter does not support reflection (`dart:mirrors`), the project uses [`injectable`](https://pub.dev/packages/injectable) as our dependency injection and service locator.

## Injectable/GetIt

[get_it](https://pub.dev/packages/get_it) is used as the [IoC](https://stackoverflow.com/questions/3058/what-is-inversion-of-control) container of the project.

[injectable](https://pub.dev/packages/injectable) is used with get_it to generate code for your dependency registrations.

## Registration

Registration is called before running the application, as show here in our [`main.dart`](../../../starterkit_app/lib/main.dart):

```dart
import 'package:starterkit_app/dependency_injection.dart';

Future<void> main() async {
  ...
  await ServiceLocator.registerDependencies();
  ...
}
```

The class `MyServiceImpl` is annotated with `@LazySingleton`, meaning this class will only be initialized (once and only when needed) when resolving `MyService`.

```dart
import 'package:injectable/injectable.dart';

abstract class MyService{}

@LazySingleton(as: MyService)
class MyServiceImpl implements MyService {}
```

:bulb: **<span style="color: green">TIP</span>**

Use the snippet shortcut `dep` to create an abstract and concrete classes similar above.

Read more about it [here](https://pub.dev/packages/injectable#register-under-different-environments).

## Registration for different platforms

You can register a service by using the following annotations for platform-specific:
- `@platformWeb`
- `@platformMobile`
- `@platformDesktop`

You can add your custom annotations and update `registerDependencies` appropriately.

```dart
abstract class PlatformChecker {
  bool get isAndroid;

  bool get isIOS;

  bool get isWindows;

  bool get isMacOS;

  bool get isLinux;

  bool get isWeb => kIsWeb;

  bool get isDesktop => isWindows || isMacOS || isLinux;

  bool get isMobile => isAndroid || isIOS;
}

@LazySingleton(as: PlatformChecker)
@platformMobile
@platformDesktop
class IOPlatformCheckerImpl extends PlatformChecker {
  @override
  bool get isAndroid => Platform.isAndroid;

  @override
  bool get isIOS => Platform.isIOS;

  @override
  bool get isWindows => Platform.isWindows;

  @override
  bool get isLinux => Platform.isLinux;

  @override
  bool get isMacOS => Platform.isMacOS;
}

@LazySingleton(as: PlatformChecker)
@platformWeb
class WebPlatformCheckerImpl extends PlatformChecker {
  @override
  bool get isAndroid => false;

  @override
  bool get isIOS => false;

  @override
  bool get isWindows => false;

  @override
  bool get isLinux => false;

  @override
  bool get isMacOS => false;
}

```
In the above code, we are registering `PlatformChecker` for different platforms since `dart:io` (using of `Platform` class) does not work on the web.

You can add your own platform name or environment in `dependency_injection.dart` to customize your dependency registrations.

## Registration for different configurations

You can register a service by using the following annotations for configuration-specific:
- `@debug`
- `@release`

## Registration for tests

You can register a service by using the following annotations for specifying if it is for tests:
- `@testing`
- `@running`

# Resolving
Given that you registered `AppLogger`:

```dart
import 'package:injectable/injectable.dart';

abstract class AppLogger{
  void log(String message);
}

@LazySingleton(as: AppLogger)
class AppLoggerImpl implements AppLogger {
  @override
  void log(String message) => /* do logging */;
}
```

You can resolve a dependency using the `ServiceLocator.instance`:

```dart
import 'package:starterkit_app/dependency_injection.dart';

Future<void> main() async {
  // register first
  await ServiceLocator.registerDependencies();

  // resolve
  final appLogger = ServiceLocator.instance<AppLogger>();
  await appLogger.init();
}
```