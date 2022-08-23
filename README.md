# About starterkit-mobile-application-flutter

ERNI Academy mobile boilerplate to start a cross-platform Flutter mobile application.

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![Build Status](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_apis/build/status/ERNI-Mobile-Blueprint-CI-Android?branchName=master&label=Android)](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_build/latest?definitionId=772&branchName=master) [![Build Status](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_apis/build/status/ERNI-Mobile-Blueprint-CI-iOS?branchName=master&label=iOS)](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_build/latest?definitionId=773&branchName=master) [![Build Status](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_apis/build/status/ERNI-Mobile-Blueprint-CI-Web?branchName=master&label=Web)](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_build/latest?definitionId=774&branchName=master) [![Build Status](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_apis/build/status/ERNI-Mobile-Blueprint-CI-Windows?branchName=master&label=Windows)](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_build/latest?definitionId=784&branchName=master) [![Build Status](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_apis/build/status/ERNI-Mobile-Blueprint-CI-Code-Validation?branchName=master&label=Code%20Validation)](https://dev.azure.com/erniegh/ERNI-EPH-Mobile-FlutterStack/_build/latest?definitionId=777&branchName=master)

## Built With

- [Flutter](https://flutter.dev)

## Getting Started

- [Install Flutter](https://docs.flutter.dev/get-started/install)
- [Dart Lanugage Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Documentation](https://docs.flutter.dev/)

## Prerequisites

**Visual Studio Code**
- [Download VS Code](https://code.visualstudio.com/download)
- A [list of extensions](erni_mobile/.vscode/extensions.json) are required to be installed in order to properly run the project

**Android**
- Android 29 (minimum), Android 32 (target)
- [Download Android Studio](https://developer.android.com/studio)

**iOS and macOS**
- iOS 13 (minimum), iOS 16 (target)
- Requires macOS 11 (Big Sur) or higher
- [Download Xcode 13](https://developer.apple.com/download/all/)

**Windows**
- Windows 10 or later (64-bit), x86-64 based
- Visual Studio 2022 is required for [building Windows applications](https://docs.flutter.dev/desktop#additional-windows-requirements)
- Additional Windows requirements [here](https://docs.flutter.dev/development/platform-integration/desktop#additional-windows-requirements)
- Note that **Visual Studio** is different from **Visual Studio *Code***
  
**Web**
- Any browser capable of debugging, but preferrably chrome-based browsers

## Installation

Installation instructions {{ Name }} by running:

1. Clone the repo

   ```sh
   git clone https://github.com/ERNI-Academy/starterkit-mobile-application-flutter.git
   ```

2. Get packages

    ```sh
    flutter pub get
    ```

3. Run code generation

    ```sh
    # Run this command one time
    flutter pub global activate intl_utils

    # Run this command whenever you use build_runner
    flutter pub run build_runner build --delete-conflicting-outputs

    # Run this command to generate localization files
    flutter pub global run intl_utils:generate
    ```

## Contributing

Please see our [Contribution Guide](CONTRIBUTING.md) to learn how to contribute.

## License

![MIT](https://img.shields.io/badge/License-MIT-blue.svg)

(LICENSE) © {{Year}} [ERNI - Swiss Software Engineering](https://www.betterask.erni)

## Code of conduct

Please see our [Code of Conduct](CODE_OF_CONDUCT.md)

## Stats

Check [https://repobeats.axiom.co/](https://repobeats.axiom.co/) for the right URL

## Follow us

[![Twitter Follow](https://img.shields.io/twitter/follow/ERNI?style=social)](https://www.twitter.com/ERNI)
[![Twitch Status](https://img.shields.io/twitch/status/erni_academy?label=Twitch%20Erni%20Academy&style=social)](https://www.twitch.tv/erni_academy)
[![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCkdDcxjml85-Ydn7Dc577WQ?label=Youtube%20Erni%20Academy&style=social)](https://www.youtube.com/channel/UCkdDcxjml85-Ydn7Dc577WQ)
[![Linkedin](https://img.shields.io/badge/linkedin-31k-green?style=social&logo=Linkedin)](https://www.linkedin.com/company/erni)

## Contact

📧 [esp-services@betterask.erni](mailto:esp-services@betterask.erni)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
