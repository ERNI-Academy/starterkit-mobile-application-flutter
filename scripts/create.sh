#!/bin/bash

usage() {
    echo "Running this script will create a new project based on the starterkit."
    echo "It will clone the starterkit-mobile-application-flutter repository to the current directory and rename the project."
    echo "Usage: $0 -n <project_name> -i <app_id>"
    echo "  -n, --name      Project name"
    echo "  -i, --app-id    App id"
    echo "  -d, --directory Directory where the project will be created"
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

export LANG=C
export LC_CTYPE=C
export LC_ALL=C

PROJECT_NAME=""
APP_ID=""
DIR="$( cd "$( dirname )" >/dev/null 2>&1 && pwd )" # default
DEV_SECRETS="ewogICAgImFwcEVudmlyb25tZW50IjogImRldiIsCiAgICAiYXBwU2VydmVyVXJsIjogImh0dHBzOi8vanNvbnBsYWNlaG9sZGVyLnR5cGljb2RlLmNvbS8iLAogICAgImFwcElkIjogImNvbS5leGFtcGxlLnN0YXJ0ZXJraXQuYXBwIiwKICAgICJhcHBJZFN1ZmZpeCI6ICIuZGV2IiwKICAgICJhcHBOYW1lIjogIlN0YXJ0ZXJraXQgQXBwIChEZXYpIiwKICAgICJpT1NEZXZlbG9wbWVudFRlYW0iOiAiQUJDREUxMjM0NSIsCiAgICAiaU9TRGV2ZWxvcG1lbnRQcm9maWxlIjogIllvdXIgRGV2ZWxvcG1lbnQgUHJvZmlsZSBOYW1lIiwKICAgICJpT1NEaXN0cmlidXRpb25Qcm9maWxlIjogIllvdXIgRGlzdHJpYnV0aW9uIFByb2ZpbGUgTmFtZSIsCiAgICAiaU9TRXhwb3J0TWV0aG9kIjogImFkLWhvYyIKfQ=="
PROD_SECRETS="ewogICAgImFwcEVudmlyb25tZW50IjogInByb2QiLAogICAgImFwcFNlcnZlclVybCI6ICJodHRwczovL2pzb25wbGFjZWhvbGRlci50eXBpY29kZS5jb20vIiwKICAgICJhcHBJZCI6ICJjb20uZXhhbXBsZS5zdGFydGVya2l0LmFwcCIsCiAgICAiYXBwSWRTdWZmaXgiOiAiIiwKICAgICJhcHBOYW1lIjogIlN0YXJ0ZXJraXQgQXBwIiwKICAgICJpT1NEZXZlbG9wbWVudFRlYW0iOiAiQUJDREUxMjM0NSIsCiAgICAiaU9TRGV2ZWxvcG1lbnRQcm9maWxlIjogIllvdXIgRGV2ZWxvcG1lbnQgUHJvZmlsZSBOYW1lIiwKICAgICJpT1NEaXN0cmlidXRpb25Qcm9maWxlIjogIllvdXIgRGlzdHJpYnV0aW9uIFByb2ZpbGUgTmFtZSIsCiAgICAiaU9TRXhwb3J0TWV0aG9kIjogImFwcC1zdG9yZSIKfQ=="

while getopts "n:i:" opt; do
    case "$opt" in
    n | name)
        PROJECT_NAME=$OPTARG
        ;;
    i | app-id)
        APP_ID=$OPTARG
        ;;
    d | directory)
        DIR=$OPTARG
        ;;
    *)
        usage
        ;;
    esac
done

PROJECT_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')

if [ -z "$PROJECT_NAME" ]; then
    echo "Project name is empty, please use -n or --name to set the project name"
    exit 1
fi

if [[ ! "$PROJECT_NAME" =~ ^[a-z0-9_]+$ ]]; then
    echo "Project name is not in the correct format, it should be snake case"
    exit 1
fi

if [ -z "$APP_ID" ]; then
    echo "App id is empty, please use -i or --app-id to set the app id"
    exit 1
fi

if [[ ! "$APP_ID" =~ ^[a-z0-9.]+$ ]] || [[ $(echo "$APP_ID" | grep -o "\." | wc -l) -lt 2 ]]; then
    echo "App id is not in the correct format, it should be like com.company.project"
    exit 1
fi

PROJECT_REPO_NAME=$(echo "$PROJECT_NAME" | sed -r 's/_/-/g')
PROJECT_DIR="$DIR/$PROJECT_REPO_NAME/$PROJECT_NAME"
APP_NAME=$(echo $PROJECT_NAME | awk -F_ '{for(i=1;i<=NF;i++) printf "%s", toupper(substr($i,1,1)) substr($i,2);}')
APP_NAME=$(echo $APP_NAME | sed -r 's/([A-Z])/ \1/g')
APP_NAME=$(echo $APP_NAME | sed -r 's/^\s+|\s+$//g')

echo "Project name: $PROJECT_NAME"
echo "Project repo name: $PROJECT_REPO_NAME"
echo "Project Directory: $DIR"
echo "App id: $APP_ID"
echo "App name: $APP_NAME"

read -p "Are you sure you want to continue? (y/n) " -n 1 -r

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

git clone https://github.com/ERNI-Academy/starterkit-mobile-application-flutter.git "$DIR/$PROJECT_REPO_NAME"
rm -rf "$DIR/$PROJECT_REPO_NAME/.git"
mv "$DIR/$PROJECT_REPO_NAME/starterkit_app" "$PROJECT_DIR"

echo "Renaming app name..."
find "$DIR/$PROJECT_REPO_NAME" -type f -exec sed -i -e "s/Starterkit App/$APP_NAME/g" {} \;

echo "Renaming app id..."
find "$DIR/$PROJECT_REPO_NAME" -type f -exec sed -i -e "s/com.example.starterkit_app/$APP_ID/g" {} \;
find "$DIR/$PROJECT_REPO_NAME" -type f -exec sed -i -e "s/com.example.starterkit.app/$APP_ID/g" {} \;
find "$DIR/$PROJECT_REPO_NAME" -type f -exec sed -i -e "s/com.mycompany.starterkit.app/$APP_ID/g" {} \;

echo "Renaming project name..."
find "$DIR/$PROJECT_REPO_NAME" -type f -exec sed -i -e "s/starterkit_app/$PROJECT_NAME/g" {} \;

echo "Setting up secrets..."
mkdir .secrets
base64 --decode <<< "$DEV_SECRETS" > "$PROJECT_DIR/.secrets/dev.json"
base64 --decode <<< "$PROD_SECRETS" > "$PROJECT_DIR/.secrets/prod.json"

echo "Moving MainActivity.kt..."
ANDROID_PROJECT_DIR="$PROJECT_DIR/android"
TEMP_MAIN_ACTIVITY_DIR="$ANDROID_PROJECT_DIR/app/src/main/kotlin"
NEW_MAIN_ACTIVITY_DIR="$ANDROID_PROJECT_DIR/app/src/main/kotlin/$(echo "$APP_ID" | sed -r 's/\./\//g')"

OLD_MAIN_ACTIVITY_DIR1="$ANDROID_PROJECT_DIR/app/src/main/kotlin/com/example/starterkit_app"
if [ -f "$OLD_MAIN_ACTIVITY_DIR1/MainActivity.kt" ]; then
    mv "$OLD_MAIN_ACTIVITY_DIR1/MainActivity.kt" "$TEMP_MAIN_ACTIVITY_DIR/MainActivity.kt"
    rm -rf "$TEMP_MAIN_ACTIVITY_DIR/com"
    mkdir -p $NEW_MAIN_ACTIVITY_DIR
    mv "$TEMP_MAIN_ACTIVITY_DIR/MainActivity.kt" "$NEW_MAIN_ACTIVITY_DIR/MainActivity.kt"
fi

OLD_MAIN_ACTIVITY_DIR2="$ANDROID_PROJECT_DIR/app/src/main/kotlin/com/example/starterkit/app"
if [ -f "$OLD_MAIN_ACTIVITY_DIR2/MainActivity.kt" ]; then
    mv "$OLD_MAIN_ACTIVITY_DIR2/MainActivity.kt" "$TEMP_MAIN_ACTIVITY_DIR/MainActivity.kt"
    rm -rf "$TEMP_MAIN_ACTIVITY_DIR/com"
    mkdir -p $NEW_MAIN_ACTIVITY_DIR
    mv "$TEMP_MAIN_ACTIVITY_DIR/MainActivity.kt" "$NEW_MAIN_ACTIVITY_DIR/MainActivity.kt"
fi

if ! command -v fvm &> /dev/null; then
    echo "fvm could not be found"
    echo "Please install fvm from https://fvm.app/"
    exit 1
fi

cd $PROJECT_DIR
fvm install
fvm dart format --line-length 120 .
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm dart fix --apply
cd $DIR
