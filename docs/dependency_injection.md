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

- Use the snippet shortcut `dep` to create an abstract and concrete classes similar above.

## Resolving
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