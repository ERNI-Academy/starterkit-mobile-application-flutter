#!/bin/sh

# Usage:
#   bash env_to_dart_defines.sh <env>
#
# Example:
#   bash env_to_dart_defines.sh dev
#   export DART_DEFINES=$(bash env_to_dart_defines.sh dev)
#   flutter build apk $DART_DEFINES

json=$(cat .secrets/${1}.secrets)

jq -M -r 'keys[] as $k | $k, .[$k]' <<< "$json" | \
while read -r key; read -r val; do
   echo "--dart-define \"$key=$val\""
done
