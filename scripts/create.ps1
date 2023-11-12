function usage {
    Write-Host "Running this script will create a new project based on the starterkit."
    Write-Host "It will clone the starterkit-mobile-application-flutter repository to the current directory and rename the project."
    Write-Host "Usage: create.ps1 -n <project_name> -i <app_id>"
    Write-Host "  -n, --name      Project name"
    Write-Host "  -i, --app-id    App id"
    exit 1
}

if ($args.Count -eq 0) {
    usage
}

$PROJECT_NAME = ""
$APP_ID = ""
for ($i = 0; $i -lt $args.Count; $i++) {
    $key = $args[$i]
    switch ($key) {
        "-n" {
            $PROJECT_NAME = $args[$i+1]
            $i++
        }
        "--name" {
            $PROJECT_NAME = $args[$i+1]
            $i++
        }
        "-i" {
            $APP_ID = $args[$i+1]
            $i++
        }
        "--app-id" {
            $APP_ID = $args[$i+1]
            $i++
        }
    }
}

$PROJECT_NAME = $PROJECT_NAME.ToLower()

if ($PROJECT_NAME -eq "") {
    Write-Host "Project name is empty, please use -n or --name to set the project name"
    exit 1
}

if ($PROJECT_NAME -notmatch "^[a-z0-9_]+$") {
    Write-Host "Project name is not in the correct format, it should be snake case"
    exit 1
}

if ($APP_ID -eq "") {
    Write-Host "App id is empty, please use -i or --app-id to set the app id"
    exit 1
}

if ($APP_ID -notmatch "^[a-z0-9.]+$" -or ($APP_ID -split "\." | Measure-Object).Count -lt 3) {
    Write-Host "App id is not in the correct format, it should be like com.company.project"
    exit 1
}

$PROJECT_REPO_NAME = $PROJECT_NAME -replace "_", "-"
$DIR = (Get-Item -Path ".\" -Verbose).FullName
$PROJECT_DIR = "$DIR\$PROJECT_REPO_NAME\$PROJECT_NAME"
$APP_NAME = ($PROJECT_NAME -split "_") | ForEach-Object { $_.Substring(0,1).ToUpper() + $_.Substring(1) }

Write-Host "Project name: $PROJECT_NAME"
Write-Host "Project repo name: $PROJECT_REPO_NAME"
Write-Host "Project Directory: $DIR"
Write-Host "App id: $APP_ID"
Write-Host "App name: $APP_NAME"

$continue = Read-Host "Are you sure you want to continue? (y/n) "

if ($continue -notmatch "^[Yy]$") {
    exit 1
}

git clone https://github.com/ERNI-Academy/starterkit-mobile-application-flutter.git "$DIR/$PROJECT_REPO_NAME"
Remove-Item "$DIR/$PROJECT_REPO_NAME/.git" -Recurse -Force
Move-Item "$DIR/$PROJECT_REPO_NAME/starterkit_app" "$PROJECT_DIR"

Write-Host "Renaming app name..."
Get-ChildItem "$DIR/$PROJECT_REPO_NAME" -Recurse -File | ForEach-Object { (Get-Content $_.FullName) -replace "Starterkit App", "$APP_NAME" | Set-Content $_.FullName }

Write-Host "Renaming app id..."
Get-ChildItem "$DIR/$PROJECT_REPO_NAME" -Recurse -File | ForEach-Object { (Get-Content $_.FullName) -replace "com.example.starterkit_app", "$APP_ID" | Set-Content $_.FullName }
Get-ChildItem "$DIR/$PROJECT_REPO_NAME" -Recurse -File | ForEach-Object { (Get-Content $_.FullName) -replace "com.example.starterkit.app", "$APP_ID" | Set-Content $_.FullName }
Get-ChildItem "$DIR/$PROJECT_REPO_NAME" -Recurse -File | ForEach-Object { (Get-Content $_.FullName) -replace "com.mycompany.starterkit.app", "$APP_ID" | Set-Content $_.FullName }

Write-Host "Renaming project name..."
Get-ChildItem "$DIR/$PROJECT_REPO_NAME" -Recurse -File | ForEach-Object { (Get-Content $_.FullName) -replace "starterkit_app", "$PROJECT_NAME" | Set-Content $_.FullName }

Write-Host "Moving MainActivity.kt..."
$ANDROID_PROJECT_DIR = "$PROJECT_DIR\android"
$TEMP_MAIN_ACTIVITY_DIR = "$ANDROID_PROJECT_DIR\app\src\main\kotlin"
$NEW_MAIN_ACTIVITY_DIR = "$ANDROID_PROJECT_DIR\app\src\main\kotlin\$($APP_ID -replace "\.", "\")"

$OLD_MAIN_ACTIVITY_DIR1 = "$ANDROID_PROJECT_DIR\app\src\main\kotlin\com\example\starterkit_app"
if (Test-Path "$OLD_MAIN_ACTIVITY_DIR1\MainActivity.kt") {
    Move-Item "$OLD_MAIN_ACTIVITY_DIR1\MainActivity.kt" "$TEMP_MAIN_ACTIVITY_DIR\MainActivity.kt"
    Remove-Item "$TEMP_MAIN_ACTIVITY_DIR\com" -Recurse -Force
    New-Item -ItemType Directory -Path $NEW_MAIN_ACTIVITY_DIR -Force
    Move-Item "$TEMP_MAIN_ACTIVITY_DIR\MainActivity.kt" "$NEW_MAIN_ACTIVITY_DIR\MainActivity.kt"
}

$OLD_MAIN_ACTIVITY_DIR2 = "$ANDROID_PROJECT_DIR\app\src\main\kotlin\com\example\starterkit\app"
if (Test-Path "$OLD_MAIN_ACTIVITY_DIR2\MainActivity.kt") {
    Move-Item "$OLD_MAIN_ACTIVITY_DIR2\MainActivity.kt" "$TEMP_MAIN_ACTIVITY_DIR\MainActivity.kt"
    Remove-Item "$TEMP_MAIN_ACTIVITY_DIR\com" -Recurse -Force
    New-Item -ItemType Directory -Path $NEW_MAIN_ACTIVITY_DIR -Force
    Move-Item "$TEMP_MAIN_ACTIVITY_DIR\MainActivity.kt" "$NEW_MAIN_ACTIVITY_DIR\MainActivity.kt"
}

$FVM = Get-Command fvm -ErrorAction SilentlyContinue

if ($null -eq $FVM) {
    Write-Host "fvm could not be found"
    Write-Host "Please install fvm from https://fvm.app/"
    exit 1
}

Set-Location $PROJECT_DIR
fvm install
fvm dart format --line-length 120 .
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm dart fix --apply
Set-Location $DIR