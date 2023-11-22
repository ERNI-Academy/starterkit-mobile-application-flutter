function usage {
    Write-Host "Running this script will create a new project based on the starterkit."
    Write-Host "It will clone the starterkit-mobile-application-flutter repository to the current directory and rename the project."
    Write-Host "Usage: create.ps1 -n <project_name> -i <app_id>"
    Write-Host "  -n, --name      Project name"
    Write-Host "  -i, --app-id    App id"
    Write-Host "  -d, --directory Directory where the project will be created"
    exit 1
}

if ($args.Count -eq 0) {
    usage
}

$PROJECT_NAME = ""
$APP_ID = ""
$DIR = (Get-Item -Path ".\" -Verbose).FullName # default
$DEV_SECRETS = "ewogICAgImFwcEVudmlyb25tZW50IjogImRldiIsCiAgICAiYXBwU2VydmVyVXJsIjogImh0dHBzOi8vanNvbnBsYWNlaG9sZGVyLnR5cGljb2RlLmNvbS8iLAogICAgImFwcElkIjogImNvbS5leGFtcGxlLnN0YXJ0ZXJraXQuYXBwIiwKICAgICJhcHBJZFN1ZmZpeCI6ICIuZGV2IiwKICAgICJhcHBOYW1lIjogIlN0YXJ0ZXJraXQgQXBwIChEZXYpIiwKICAgICJpT1NEZXZlbG9wbWVudFRlYW0iOiAiQUJDREUxMjM0NSIsCiAgICAiaU9TRGV2ZWxvcG1lbnRQcm9maWxlIjogIllvdXIgRGV2ZWxvcG1lbnQgUHJvZmlsZSBOYW1lIiwKICAgICJpT1NEaXN0cmlidXRpb25Qcm9maWxlIjogIllvdXIgRGlzdHJpYnV0aW9uIFByb2ZpbGUgTmFtZSIsCiAgICAiaU9TRXhwb3J0TWV0aG9kIjogImFkLWhvYyIKfQ=="
$PROD_SECRETS = "ewogICAgImFwcEVudmlyb25tZW50IjogInByb2QiLAogICAgImFwcFNlcnZlclVybCI6ICJodHRwczovL2pzb25wbGFjZWhvbGRlci50eXBpY29kZS5jb20vIiwKICAgICJhcHBJZCI6ICJjb20uZXhhbXBsZS5zdGFydGVya2l0LmFwcCIsCiAgICAiYXBwSWRTdWZmaXgiOiAiIiwKICAgICJhcHBOYW1lIjogIlN0YXJ0ZXJraXQgQXBwIiwKICAgICJpT1NEZXZlbG9wbWVudFRlYW0iOiAiQUJDREUxMjM0NSIsCiAgICAiaU9TRGV2ZWxvcG1lbnRQcm9maWxlIjogIllvdXIgRGV2ZWxvcG1lbnQgUHJvZmlsZSBOYW1lIiwKICAgICJpT1NEaXN0cmlidXRpb25Qcm9maWxlIjogIllvdXIgRGlzdHJpYnV0aW9uIFByb2ZpbGUgTmFtZSIsCiAgICAiaU9TRXhwb3J0TWV0aG9kIjogImFwcC1zdG9yZSIKfQ=="


for ($i = 0; $i -lt $args.Count; $i++) {
    $key = $args[$i]
    switch ($key) {
        "-n" { $PROJECT_NAME = $args[++$i] }
        "--name" { $PROJECT_NAME = $args[++$i] }
        "-i" { $APP_ID = $args[++$i] }
        "--app-id" { $APP_ID = $args[++$i] }
        "-d" { $DIR = $args[++$i] }
        "--directory" { $DIR = $args[++$i] }
        default { usage }
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
$PROJECT_DIR = "$DIR\$PROJECT_REPO_NAME\$PROJECT_NAME"
$APP_NAME = ($PROJECT_NAME -split "_") | ForEach-Object { $_.Substring(0, 1).ToUpper() + $_.Substring(1) }

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

Write-Host "Setting up secrets..."
New-Item -ItemType Directory -Path "$PROJECT_DIR/.secrets" -Force
$decodedDevSecrets = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($DEV_SECRETS))
$decodedDevSecrets | Out-File "$PROJECT_DIR/.secrets/dev.json"
$decodedProdSecrets = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($PROD_SECRETS))
$decodedProdSecrets | Out-File "$PROJECT_DIR/.secrets/prod.json"

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