## Setup local repository

Clone the repo.

```sh
git clone https://github.com/ERNI-Academy/starterkit-mobile-application-flutter.git
```

Untrack the files under the folder `.secrets` by adding it in your `.gitignore` file.

```sh
.secrets/**
```

## Setup your secrets

Update the contents of `.secrets/dev.json`, and add the other `.json` file for each of your environment.

Read more about setting up your environments [here](environments).


## Generate code

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