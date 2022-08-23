#!/bin/sh

# Usage:
#   bash set_dart_defines_variable.sh <env>
#
# Example:
#   bash set_dart_defines_variable.sh dev
#   export DART_DEFINES=$(bash set_dart_defines_variable.sh dev)
#   eval flutter build apk $DART_DEFINES

json=$(cat .secrets/${1}.secrets)

jq -M -r 'keys[] as $k | $k, .[$k]' <<< "$json" | \
while read -r key; read -r val; do
   echo "--dart-define \"$key=$val\""
done
