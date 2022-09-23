# Code Style

We use a custom [`analysis_options.yaml`](../erni_mobile/analysis_options.yaml).

The default line length of the project is `120`, versus Dart's recommended `80`.

This is part of the project's CI workflow (see [ci-code-validation.yml](../.github/workflows/ci-code-validation.yml)). The build will fail if member ordering is incorrect.

## Member ordering
The project uses a customized member ordering, enforced using [Dart Code Metrics](https://dartcodemetrics.dev).

The following order must be observed:

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