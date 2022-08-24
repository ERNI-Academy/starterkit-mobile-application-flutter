# `erni_mobile_lints`

## Features

Stricter Dart analyzer rules combined with [Dart Code Metrics](dartcodemetrics.dev).

The rules defined enforces type-safe, as well as improving code quality.

## Getting started

In your `pubspec.yaml`, add `dart_code_metrics` and `erni_mobile_lints` as development dependencies:


```yaml
dev_dependencies:
    dart_code_metrics: ^4.15.0
    erni_mobile_lints:
        git: https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_git/ERNI-Mobile-Blueprint-Lints
```

## Usage

### Custom analyzer rules
If you want to define your own analyzer rules, you can create your own `analysis_options.yaml` in your project root folder and include `erni_mobile_lints`.

```yaml
include: package:erni_mobile_lints/analysis_options.yaml

# Define below your custom analyzer rules
```

Read more about customizing the Dart analyzer [here](https://dart.dev/guides/language/analysis-options).

### CLI integration

You can integrate static analysis in you CI pipeline by running commands that check problems caught by the Dart analyzer:

```sh
flutter analyze .
```

Additionally, you can also run Dart Code Metric's [CLI commands](https://dartcodemetrics.dev/docs/cli/overview):

```sh
echo "Running checks for code metrics"
flutter pub run dart_code_metrics:metrics analyze lib --fatal-style --fatal-warnings --fatal-performance

echo "Running checks for unused files"
flutter pub run dart_code_metrics:metrics check-unused-files lib --fatal-unused

echo "Running checks for unused code"
flutter pub run dart_code_metrics:metrics check-unused-code lib --fatal-unused
```