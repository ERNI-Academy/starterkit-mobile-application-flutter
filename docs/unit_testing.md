# Unit Testing Guidelines

## Naming Convention

| Items        | Naming Pattern                                                     | Target        | Example                                                |
| ------------ | ------------------------------------------------------------------ | ------------- | ------------------------------------------------------ |
| Test Files   | {{class_name_to_be_tested}}_test.dart                              | MainViewModel | main_view_model_test.dart                              |
| Test Methods | {{methodNameToBeTested}} should {{expected result}} when {{state}} | openLink()    | openLink should trigger open uri when link text tapped |

## Testing Framework

- [test](https://pub.dev/packages/test) provides standard way of writing and running tests in Dart.
- [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) for testing Flutter widgets. Read more about widget testing [here](https://docs.flutter.dev/cookbook/testing/widget/introduction).

## Mocking Framework

- [mockito](https://pub.dev/packages/mockito) for creating mocks in Dart with null safety. Uses code generation.


## Testing Code Style

Below is an example of a unit test code for the class `MainViewModel`:

```dart

import 'package:test/test.dart';

import '../main_view_model.dart';

void main() {
  group(MainViewModel, () {
    late MockUriHandler mockUriHandler;

    setUp(() {
      mockUriHandler = MockUriHandler();
    });

    MainViewModel createUnitToTest() {
      return MainViewModel(mockUriHandler);
    }

    group('openLink()', () {
      test('should trigger open uri when link text tapped', () {
        final expectedUri = Uri.parse('http://sample.com');
        when(mockUriHandler.openUri(expectedUri)).thenAnswer((_) async => true);

        final unit = createUnitToTest();
        unit.openLink(expectedUri);

        verify(mockUriHandler.openUri(expectedUri)).called(1);
      });
    });
  });
}
```

- Create specific group for each method to be tested.
- Create a seperate method to create the unit to be tested.
- Seperate each part (arrange, act, assert) of the test code with a blank line.

>:bulb: **<span style="color: green">TIP</span>**
>
>Use the snippet shortcut `gtest` to create a test file similar above.