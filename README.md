# About starterkit-mobile-application-flutter

ERNI Academy mobile boilerplate to start a cross-platform Flutter mobile application.

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![Code Validation](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-code-validation.yml/badge.svg)](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-code-validation.yml) [![Android Build](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-android.yml/badge.svg)](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-android.yml) [![iOS Build](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-ios.yml/badge.svg)](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-ios.yml) [![Web Build](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-web.yml/badge.svg)](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-web.yml) [![Windows Build](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-windows.yml/badge.svg)](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/actions/workflows/ci-windows.yml)

## Built With

- [Flutter](https://flutter.dev)

## Getting Started

- [Install Flutter](https://docs.flutter.dev/get-started/install)
- [Introduction to Dart Language](https://dart.dev/guides/language/language-tour)
- [Flutter Documentation](https://docs.flutter.dev/)

## Prerequisites

**Flutter**
- v3.3.0+ on stable channel

**Dart**
- v2.18.0+

**Visual Studio Code**
- [Download Visual Studio Code](https://code.visualstudio.com/download)
- A [list of extensions](erni_mobile/.vscode/extensions.json) are required to be installed in order to properly run the project

**Android**
- [Download Android Studio](https://developer.android.com/studio)
- Android 30 (minimum), Android 33 (target)

**iOS and macOS**
- [Download Xcode 13](https://developer.apple.com/download/all/)
- iOS 13 (minimum), iOS 16 (target)
- Requires macOS 11 (Big Sur) or higher

**Windows**
- [Download Visual Studio 2022](https://visualstudio.microsoft.com/vs/)
- Windows 10 or later (64-bit), x86-64 based
- Additional Windows requirements [here](https://docs.flutter.dev/development/platform-integration/desktop#additional-windows-requirements)
- Note that **Visual Studio** is different from **Visual Studio *Code***
  
**Web**
- Any browser capable of debugging, but preferably chrome-based browsers

## Project Setup

**Setup local repository**

Clone the repo.

```sh
git clone https://github.com/ERNI-Academy/starterkit-mobile-application-flutter.git
```

Untrack the files under the folder `lib/.secrets` by adding it in your [.gitignore](erni_mobile/.gitignore)

```sh
.secrets/**
```

**Setup your secrets**

Update the contents of `.secrets/dev.secrets`, and add the other `.secrets` file for each of your environment.

Read more about setting up your environments [here](docs/environments.md).


**Generate code**

Run the following commands to generate code.

```sh
# Run this command if appropriate
flutter pub get

# Run this command one time
flutter pub global activate intl_utils

# Run this command to generate localization files
flutter pub global run intl_utils:generate

# Run this command whenever you use build_runner
flutter pub run build_runner build --delete-conflicting-outputs
```

Read more about code generation [here](docs/code_generation.md).

## Documentation

To know more about this project, you can read the following:

**[Overview](docs/overview.md)**
- [Environment](docs/environments.md)
- [Dependency Injection](docs/dependency_injection.md)
- [Reflection](docs/reflection.md)
- [Code Generation](docs/code_generation.md)
- [Code Style](docs/code_style.md)
- [Code Analysis and Metrics](docs/code_analysis_and_metrics.md)
- [Unit Testing](docs/unit_testing.md)

**User Interface**
- [Views](docs/ui/views.md)
- [View Models](docs/ui/view_models.md)
- [State Management](docs/ui/state_management.md)
- [Resource Management](docs/ui/resource_management.md)
- [Navigation](docs/ui/navigation.md)
- [Validation Rules](docs/ui/validation_rules.md)

**Business**
- [Data Contracts](docs/business/data_contracts.md)
- [Data Objects](docs/business/data_objects.md)
- [Entities](docs/business/entities.md)
- [Mappers](docs/business/mappers.md)

**Data**
- [APIs](docs/data/apis.md)
- [Database](docs/data/database.md)

## Contributing

Please see our [Contribution Guide](CONTRIBUTING.md) to learn how to contribute.

## License

![MIT](https://img.shields.io/badge/License-MIT-blue.svg)

Copyright ?? 2022 [ERNI - Swiss Software Engineering](https://www.betterask.erni)

## Code of conduct

Please see our [Code of Conduct](CODE_OF_CONDUCT.md)

## Stats

![Alt](https://repobeats.axiom.co/api/embed/0efcc903e049a8ee8086139e5a6b22e2504c1fa1.svg "Repobeats analytics image")

## Follow us

[![Twitter Follow](https://img.shields.io/twitter/follow/ERNI?style=social)](https://www.twitter.com/ERNI)
[![Twitch Status](https://img.shields.io/twitch/status/erni_academy?label=Twitch%20Erni%20Academy&style=social)](https://www.twitch.tv/erni_academy)
[![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCkdDcxjml85-Ydn7Dc577WQ?label=Youtube%20Erni%20Academy&style=social)](https://www.youtube.com/channel/UCkdDcxjml85-Ydn7Dc577WQ)
[![Linkedin](https://img.shields.io/badge/linkedin-31k-green?style=social&logo=Linkedin)](https://www.linkedin.com/company/erni)

## Contact

???? [esp-services@betterask.erni](mailto:esp-services@betterask.erni)

## Contributors ???

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
