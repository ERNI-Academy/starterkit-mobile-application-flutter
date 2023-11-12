We'll use [`build_runner`](https://pub.dev/packages/build_runner) to generate the code for:

- Dependency injection using [`injectable`](https://pub.dev/packages/injectable)
- JSON serialization/deserialization using [`json_serializable`](https://pub.dev/packages/json_serializable)
- Resource management using [`flutter_gen`](https://pub.dev/packages/flutter_gen)
- Mapper classes using [`auto_mappr`](https://pub.dev/packages/auto_mappr)
- Localization files using [`intl_utils`](https://pub.dev/packages/intl_utils)
- Mocks in tests using [`mockito`](https://pub.dev/packages/mockito)
- Database schema using [`isar`](https://pub.dev/packages/isar)
- API clients using [`retrofit`](https://pub.dev/packages/retrofit)
- Reflection capabilities using [`reflectable`](https://pub.dev/packages/reflectable)
- Routing and navigation using [`auto_route`](https://pub.dev/packages/auto_route)

## Setup FVM

This project uses [FVM](https://fvm.app) to manage its Flutter SDK versions. You need to install it first before you can run any `flutter` or `dart` commands.

```sh
# Install the Flutter SDK version specified in .fvm/fvm_config.json
fvm install
```

## Run Build Runner

Run the command in the project directory to run the generator once:

```sh
fvm dart run build_runner build
```

or run the generator when necessary every time a file is edited:

```sh
fvm dart run build_runner watch
```

If there are errors, run this command:

```sh
fvm dart run build_runner build --delete-conflicting-outputs
```

Run this command for generating localization files:

```sh
# Do this once to install intl_utils
fvm dart pub global activate intl_utils

# Generate files
fvm dart pub global run intl_utils:generate
```

A sample of a class using [`json_serializable`](https://pub.dev/packages/json_serializable):

```dart
// user_login_request_contract.dart

part 'user_login_request_contract.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserLoginRequestContract extends DataContract {
  UserLoginRequestContract({required this.email, required this.password});

  final String email;
  final String password;

  factory UserLoginRequestContract.fromJson(Map<String, dynamic> json) => _$UserLoginRequestContractFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserLoginRequestContractToJson(this);
}
```

The generated file, typically has file name `.g.dart`:

```dart
// user_login_request_contract.g.dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_request_contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginRequestContract _$UserLoginRequestContractFromJson(
        Map<String, dynamic> json) =>
    UserLoginRequestContract(
      email: json['Email'] as String,
      password: json['Password'] as String,
    );

Map<String, dynamic> _$UserLoginRequestContractToJson(
        UserLoginRequestContract instance) =>
    <String, dynamic>{
      'Email': instance.email,
      'Password': instance.password,
    };

```

:exclamation: **<span style="color: red">IMPORTANT</span>**

- These generated files are **not** commited to git. Code eneration should be part of your CI workflow.