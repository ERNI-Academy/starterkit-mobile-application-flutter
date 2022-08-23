# Code Style

We use a custom `analysis_options.yaml` file that is hosted [here](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_git/ERNI-Mobile-Blueprint-Lints), and is added as a development dependency to the project.

The default line length of the project is `120`, versus Dart's recommended `80`.

This is part of the project's CI workflow (see [azure-pipelines-ci-code-validation.yml](../ci/azure-pipelines-ci-code-validation.yml)). The build will fail if formatting is incorrect.

## Member ordering
The project uses a customized member ordering, enforced using [Dart Code Metrics](https://dartcodemetrics.dev) and is defined in [azure-pipelines.yml](../azure-pipelines.yml). It is inspired by C#'s member ordering.

The following order should be observed:

```yaml
- member-ordering-extended:
    alphabetize: false
    order:
        - public-const-fields
        - public-static-final-fields
        - public-static-fields
        - private-static-const-fields
        - private-static-final-fields
        - constructors
        - factory-constructors
        - private-constructors
        - private-final-fields
        - private-late-final-fields
        - private-fields
        - public-final-fields
        - public-late-final-fields
        - public-getters
        - public-getters-setters
        - public-fields
        - protected-public-final-fields
        - protected-public-late-final-fields
        - public-static-methods
        - overridden-public-methods
        - public-methods
        - overridden-protected-methods
        - protected-methods
        - private-methods
        - private-static-methods
```

This is part of the project's CI workflow (see [azure-pipelines-ci-code-validation.yml](../ci/azure-pipelines-ci-code-validation.yml)). The build will fail if member ordering is incorrect.