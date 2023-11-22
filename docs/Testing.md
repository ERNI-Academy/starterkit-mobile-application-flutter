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

Given that we have the following class to be tested:

```dart
class MainViewModel extends ViewModel {
  final UriHandler _uriHandler;

  MainViewModel(this._uriHandler);

  Future<void> openLink(Uri uri) async {
    await _uriHandler.openUri(uri);
  }
}
```

Below is an example of a unit test code:

```dart
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'main_view_model_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<UriHandler>()
])
void main() {
  group(MainViewModel, () {
    late MockUriHandler mockUriHandler;

    setUp(() {
      mockUriHandler = MockUriHandler();
    });

    MainViewModel createUnitToTest() {
      return MainViewModel(mockUriHandler);
    }

    group('openLink', () {
      test('should trigger open uri when link text tapped', () async {
        final expectedUri = Uri.parse('http://sample.com');
        when(mockUriHandler.openUri(expectedUri)).thenAnswer((_) async => true);

        final unit = createUnitToTest();
        await unit.openLink(expectedUri);

        verify(mockUriHandler.openUri(expectedUri)).called(1);
      });
    });
  });
}
```

- The main enclosing group should be named after the class to be tested.
- Create specific group for each method to be tested.
- Create a seperate method to create the unit to be tested.
- Seperate each part (arrange, act, assert) of the test code with a blank line for readability.
- Run `build_runner` first to generate the mocks. See [code generation](code-generation) for more details.

:bulb: **<span style="color: green">TIP</span>**

- Use the snippet shortcut `gtest` to create a test file similar above.

## Running Database Tests

- In order to run tests that uses database, download the latest [Isar Release Binaries](https://github.com/isar/isar/releases/tag/4.0.0-dev.14) that matches your current platform that you are running the test.
- Rename the binaries to `isar.dll` for Windows, `isar.dylib` for MacOS, and `isar.so` for Linux.
- Put the binaries in the `starterkit_app/test/assets` folder.

## Code Coverage

- There is an [existing issue](https://github.com/flutter/flutter/issues/27997) regarding untested files not being included in the code coverage report. As a workaround, we use [`full_coverage`](https://pub.dev/packages/full_coverage) to generate a dummy file that imports all files in a specified directory. This is just to make sure all files are "included" when running the test.
- Another thing is the code coverage of generated files. The project uses a script [`ignore_generated_files_from_coverage.sh`](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/blob/main/scripts/ignore_generated_files_from_coverage.sh) to remove the generated files from the code coverage report. Before running the test with coverage, make sure to run this script first once every time you run `build_runner`.