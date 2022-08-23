# Unit Testing Guidlines

## Naming Convention

|Items|Naming Pattern|Target|Example
|---|---|---|---|
|Test Files|{{class_name_to_be_tested}}_test.dart|MainViewModel|main_view_model_test.dart|
|Test Methods|{{methodNameToBeTested}} should {{expected result}} when {{state}}|openLink()|openLink should trigger open uri when internet connection not available()|

## Testing Framework

- [test](https://pub.dev/packages/test) provides standard way of writing and running tests in Dart.
- [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) for testing Flutter widgets. Read more about widget testing [here](https://docs.flutter.dev/cookbook/testing/widget/introduction).

## Mocking Framework

- [mockito](https://pub.dev/packages/mockito) for creating mocks in Dart with null safety. Uses code generation.