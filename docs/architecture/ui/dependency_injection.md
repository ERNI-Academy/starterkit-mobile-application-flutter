# Dependency Injection

Since Flutter does not support reflection (`dart:mirrors`), the project uses [`injectable`](https://pub.dev/packages/injectable) as our dependency injection and service locator.

## Provider vs. Injectable/GetIt

Compared to [provider](https://pub.dev/packages/provider), which uses the widget tree to store your application's dependencies, [injectable](https://pub.dev/packages/injectable) uses [get_it](https://pub.dev/packages/get_it) which stores dependencies outside of the tree. This is cleaner because we don't have to add non UI-related dependencies to the tree.

## Registration

Registration is called before running the application, as show here in our [`main.dart`](../../../erni_mobile/lib/main.dart):

```dart
import 'dart:async';

import 'package:erni_mobile/common/logging/logger.dart';
import 'package:erni_mobile/core/di/service_locator.dart';
import 'package:erni_mobile/core/views/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Register our dependencies
  await registerServices();

  await runZonedGuarded(
    () async => runApp(App()),
    (ex, st) => appLogger.severe('Unhandled error', error: ex, stackTrace: st),
  );
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

## Registration for different environments

You can also register classes under different environments:
- `@prod`
- `@test`

```dart
import 'package:injectable/injectable.dart';

abstract class MyService{}

@LazySingleton(as: MyService)
@prod
class MyServiceImpl implements MyService {}

@LazySingleton(as: MyService)
@test
class MyTestServiceImpl implements MyService {}
```

Read more about it [here](https://pub.dev/packages/injectable#register-under-different-environments).

## Registration for different platforms

You can register a service by using the following annotations for platform-specific:
- `@platformWeb`
- `@platformMobile`
- `@platformDesktop`

You can add your custom annotations and update `registerServices` appropriately.

```dart
import 'dart:io';

import 'package:erni_mobile/core/di/service_locator.dart';
import 'package:flutter/foundation.dart';

abstract class PlatformUtils {
  bool get isAndroid;

  bool get isIOS;

  bool get isWindows;

  bool get isWeb => kIsWeb;
}

@LazySingleton(as: PlatformUtils)
@platformMobile
class MobilePlatformUtilsImpl extends PlatformUtils {
  @override
  bool get isAndroid => Platform.isAndroid;

  @override
  bool get isIOS => Platform.isIOS;

  @override
  bool get isWindows => Platform.isWindows;
}

@LazySingleton(as: PlatformUtils)
@platformWeb
class WebPlatformUtilsImpl extends PlatformUtils {
  @override
  bool get isAndroid => false;

  @override
  bool get isIOS => false;

  @override
  bool get isWindows => false;
}
```
In the above code, we are registering `PlatformUtils` for different platforms since `dart:io` (using of `Platform` class) does not work on the web.

You can add your own platform name in `service_locator.dart`.

# Resolving
You can resolve a dependency using the `locator`:

```dart
import 'package:erni_mobile/core/di/service_locator.dart';

Future<void> main() async {
  // register first
  await registerServices();

  // resolve
  final appLogger = locator<AppLogger>();
  await appLogger.init();
}
```