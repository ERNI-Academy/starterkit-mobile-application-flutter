## Multiple Environments

Each project should have the following environments:

- **Development** is used by the developers. Testing should not be done in this environment since it is always changing.
- **Test** will be used by your testers to ensure that the software is error free.
- **UAT** ensures that your software is working as expected in the hands of your intended users.
- **Production** contains the latest version of your software that passed all testing and is generally available to your intended user.

## Setup and Debugging an Environment

Under `.secrets` folder, we can find the different variables used for each environments:

![image.png](.attachments/environments.png)

We use [Command Variable](https://marketplace.visualstudio.com/items?itemName=rioj7.command-variable) extension in order to select which environment to run locally. Pressing `F5` will show a picker before debugging the application:

![image.png](.attachments/environments_run.png)

Read more about this setup in [this article](https://itnext.io/flutter-3-7-and-a-new-way-of-defining-compile-time-variables-f63db8a4f6e2) and [here](https://medium.com/@dustincatap/app-environments-in-flutter-and-visual-studio-code-fd956daf9802).

## Secrets File

A specific `.json` file per environment is passed to Flutter's build arguments as [Dart defines](https://dartcode.org/docs/using-dart-define-in-flutter/). Checkout our `.vscode/launch.json` file to see how we pass the environment file to the build arguments.

Below is a sample of a secret file for the development environment:

```json
{
    "appEnvironment": "dev",
    "appServerUrl": "https://jsonplaceholder.typicode.com/",
    "appId": "com.mycompany.starterkit.app",
    "appIdSuffix": ".dev",
    "appName": "Starterkit App (Dev)"
}
```

:exclamation: **<span style="color: red">IMPORTANT</span>**

- The folder `.secrets` is committed to git by default (for testing purposes). You should **delete** the `.secrets` folder and  **uncomment** last part of the **.gitignore** file to remove it from git. Once you have done this, you can start adding your secrets files locally.

### Accessing Dart Defines in the Platforms

The Android and iOS native projects are already configured to update their current configurations based on the environment file we will use. For example, the provisioning profile used for running the app on an iPhone device are automatically selected (given that the profile is available in your local machine).

You can access other Dart defines in the native projects by referencing the key directly. 

An example of this can be found in `ios/Runner/Info.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    ...
	<key>CFBundleName</key>
	<string>$(appName)</string>
    ...
</dict>
</plist>
```

and in `android/app/build.gradle`:

```groovy
android {
    ...

    defaultConfig {
        println "Building $appId$appIdSuffix"

        applicationId appId
        applicationIdSuffix appIdSuffix
        minSdkVersion 31
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName

        resValue "string", "app_name", appName
    }
}
```