#!/bin/bash

# List of file patterns to ignore
file_patterns=("*.gen.dart" "*.config.dart" "*.g.dart" "*.gr.dart" "*.reflectable.dart" "*.auto_mappr.dart" "messages_*.dart" "l10n.dart")

# Determine the correct sed command based on the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed_command='sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"'
else
    sed_command='sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"'
fi

# Loop over the file patterns and add the ignore line to each matching file
for pattern in "${file_patterns[@]}"; do
    find . -type f -name "$pattern" -exec sh -c "$sed_command" -- {} \;
done