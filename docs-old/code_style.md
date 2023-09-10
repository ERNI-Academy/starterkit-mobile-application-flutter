# Code Style


## Line Length

The default line length of the project is `120`, versus Dart's recommended `80`.

Formatting should be checked and applied before committing the code. Or this will fail when running the CI pipeline for code validation.

## Explicit Type for Public Members

Explicitly define the type of public members.

**Don't**

```dart
class MyClass {
  final name = "John Doe";
}
```

**Do**

```dart
class MyClass {
  final String name = "John Doe";
}
```

## Always Return `Iterable<T>` Rather Than `List<T>` If Possible

Prefer returning `Iterable<T>`  over `List<T>` for immutability of collections. This is also preferred if the returned collection is a constant.

```dart
Iterable<LogWriter> getLogWriters() => [ConsoleLogWriter(), FileLogWriter()];

Iterable<String> getNames() => const ["Bob", "Joe", "John"];
```

## Use Abstract Class with Static-Only Members

A class with static-only members can be made abstract since it will not be instantiated.

```dart
abstract class MyConstants {
  static final String constant1 = "constant1 value";

  static void foo() => print('bar');
}
```