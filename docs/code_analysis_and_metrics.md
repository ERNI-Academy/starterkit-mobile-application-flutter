# Code Analysis

We use a custom [`analysis_options.yaml`](../erni_mobile/analysis_options.yaml). sCombined with [flutter_lints](https://pub.dev/packages/flutter_lints) and additional rules, it enforces a strict and type-safe development.

# Code Metrics

As an additional plugin to Dart's analyzer, [Dart Code Metrics](https://dartcodemetrics.dev) improves code quality by checking such as:

- Anti-patterns
- Complexity
- Maintainability
- Code style
- Unused code/files

The complete configuration is as follows:

```yml
metrics:
cyclomatic-complexity: 20
maintainability-index: 50
maximum-nesting: 5
number-of-parameters: 5
source-lines-of-code: 50
technical-debt:
    threshold: 1
    todo-cost: 4
    ignore-cost: 8
    ignore-for-file-cost: 16
    as-dynamic-cost: 16
    deprecated-annotations-cost: 2
    file-nullsafety-migration-cost: 2
    unit-type: "hours"
```

Checking is part of the project's CI workflow (see [azure-pipelines.yml](../ci/azure-pipelines-ci-code-validation.yml)). The build will fail if Dart's analyzer raises some issues.

[Dart Code Metrics](https://dartcodemetrics.dev)' analysis can be run locally using the following commands:

```sh
flutter pub run dart_code_metrics:metrics analyze lib --fatal-style --fatal-warnings --fatal-performance
flutter pub run dart_code_metrics:metrics check-unused-files lib --fatal-unused
flutter pub run dart_code_metrics:metrics check-unused-code lib --fatal-unused
```