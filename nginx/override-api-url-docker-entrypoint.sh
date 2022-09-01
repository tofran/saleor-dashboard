#!/bin/bash

# Replaces the original API_URL from the bundle files with the one in $API_URL_OVERRIDE
# This avoids having to rebuild the bundle, making it possible to use a distributed Docker image.
# This script is automatically picked up by the nginx entrypoint on startup.

set -e

ORIGINAL_API_URL="http://localhost:8000/graphql/"
BUNDLE_PATH="/app/dashboard"

escape_url() {
    printf '%s\n' "$0" | sed -e 's/[\/&]/\\&/g'
}

if [[ "$API_URL" == "$ORIGINAL_API_URL" ]]; then
    echo "Replacing API_URL with '$API_URL'"

    escaped_original_api_url=$(escape_url "$ORIGINAL_API_URL")
    escaped_api_url=$(escape_url "$API_URL")

    find "$BUNDLE_PATH" \
        -type f \
        -name 'dashboard.*.js' \
        -exec sed -i "s/$escaped_original_api_url/$escaped_api_url/g" {} \;

    echo "Done."
fi
