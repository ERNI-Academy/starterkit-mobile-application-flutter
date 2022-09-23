# Multiple Environments

As required by ERNI standards, each project should have the following environments:
- **Development** is used by the developers. Testing should not be done in this environment since it is always changing.
- **Test** will be used by your testers to ensure that the software is error free.
- **UAT** ensures that your software is working as expected in the hands of your intended users.
- **Production** contains the latest version of your software that passed all testing and is generally available to your intended user.

## Setup and Debugging an Environment

Under `.secrets` folder, we can find the different variables used for each environments:

![image.png](.attachments/environments.png)

We use [Command Variable](https://marketplace.visualstudio.com/items?itemName=rioj7.command-variable) extension in order to select which environment to run locally. Pressing `F5` will show a picker before debugging the application:

![image.png](.attachments/environments_run.png)

There is a written [article](https://medium.com/@dustincatap/app-environments-in-flutter-and-visual-studio-code-fd956daf9802) that explains this setup.

## Secrets File

These `.secrets` files are formatted as JSON, and each key are passed to Flutter's build arguments as [Dart defines](https://dartcode.org/docs/using-dart-define-in-flutter/). Checkout our [launch.json](../erni_mobile/.vscode/launch.json) on how these are passed.

Below is a sample of a `.secrets` file for the development environment:

```json
{
    "appEnvironment": "Dev",
    "appName": "ERNI Mobile",
    "appWebDebugPort": "7072",
    "appServerUrl": "https://jsonplaceholder.typicode.com/",
    "appId": "ch.erni.mobile",
    "appIdSuffix": ".dev",
    "iOSDevelopmentTeam": "ABCDE12345",
    "iOSDevelopmentProfile": "Your Apple Development Profile",
    "iOSDistributionProfile": "Your Apple Distribution Profile",
    "iOSExportMethod": "enterprise",
    "minLogLevel": "info",
    "sentryDsn": "https://abcde12345.ingest.sentry.io/abcde1234"
}
```

:exclamation: **<span style="color: red">IMPORTANT</span>**

The folder `.secrets` is committed to git by default (for testing purposes), you should uncomment last part of the [.gitignore](../erni_mobile/.gitignore) file to remove it from git.

### Accessing Dart Defines in the Platforms

The Android and iOS native projects are already configured to update their current configurations based on the environment file we will use. For example, the provisioning profile used for running the app on an iPhone device are automatically selected (given that the profile is available in your local machine).

Read more about accessing Dart Defines [here](https://itnext.io/flutter-1-17-no-more-flavors-no-more-ios-schemas-command-argument-that-solves-everything-8b145ed4285d).
