## Create your project

You can use the [`create.sh`](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/tree/main/scripts/create.sh) or [`create.ps1`](https://github.com/ERNI-Academy/starterkit-mobile-application-flutter/tree/main/scripts/create.ps1) scripts which will create a new project. It will clone the repository to the current directory and rename the project for you and the other files based on the configurations you will provide.

```sh
Usage: <create script file> -n <project_name> -i <app_id>
  -n, --name      Project name
  -i, --app-id    App id

create.sh -n "sample_app" -i "com.mycompany.sample.app"
# or
create.ps1 -n "sample_app" -i "com.mycompany.sample.app"
```

<br />

**For Bash**
Copy the following and execute it in your terminal. Do not forget to add the parameters mentioned above.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ERNI-Academy/starterkit-mobile-application-flutter/HEAD/scripts/create.sh)"
```

<br />

:bulb: **<span style="color: green">NOTE</span>**

- The script will check if you already have [FVM](https://fvm.app) installed.
- If [FVM](https://fvm.app) is installed, the script will continue to install the configured Flutter SDK version, get the pub dependencies, generate the code, and resolve the lint issues that can be automatically fixed.
- You may need to manually resolve minor lint issues in the project, specifically the import ordering, after running the script.

## Setup your secrets

Update the contents of `.secrets/dev.json`, and add the other `.json` file for each of your environment.

Read more about setting up your environments [here](environments).

## Code generation

Run the following commands to generate code. Note that this project uses [FVM](https://fvm.app) to manage its Flutter SDK versions.

```sh
# Install the Flutter SDK version specified in .fvm/fvm_config.json
fvm install

# Run this command if appropriate
fvm flutter pub get

# Run this command one time
fvm flutter pub global activate intl_utils

# Run this command to generate localization files
fvm flutter pub global run intl_utils:generate

# Run this command whenever you use build_runner
fvm dart run build_runner build --delete-conflicting-outputs
```

Read more about code generation [here](code-generation).

:exclamation: **<span style="color: red">IMPORTANT</span>**

- Be sure to open the Flutter project (i.e. `starterkit_app`) in VSCode, and not the root directory of the repository. This is because the `.vscode` folder is configured with additional settings such as launch configurations, code snippets, and project-scoped settings.
- The same goes when running `fvm flutter <command>`, be sure to run it in the Flutter project directory.