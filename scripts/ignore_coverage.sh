#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Add ignore to generated files (for macOS)
    find . -type f -name "*.gen.dart" -exec sh -c 'sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.config.dart" -exec sh -c 'sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.g.dart" -exec sh -c 'sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.gr.dart" -exec sh -c 'sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.freezed.dart" -exec sh -c 'sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.reflectable.dart" -exec sh -c 'sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "messages_*.dart" -exec sh -c 'sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "l10n.dart" -exec sh -c 'sed -i "" -e "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
else
    # Add ignore to generated files (for Linux)
    find . -type f -name "*.gen.dart" -exec sh -c 'sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.config.dart" -exec sh -c 'sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.g.dart" -exec sh -c 'sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.gr.dart" -exec sh -c 'sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.freezed.dart" -exec sh -c 'sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "*.reflectable.dart" -exec sh -c 'sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "messages_*.dart" -exec sh -c 'sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
    find . -type f -name "l10n.dart" -exec sh -c 'sed -i "1s/^/\/\/\ coverage:ignore-file\r\n/" "$1"' -- {} \;
fi