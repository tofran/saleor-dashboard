#!/bin/bash

# Replaces the original API_URL from the bundle's index.html files with the onethe $API_URL env var.
# This avoids having to rebuild the bundle, making it possible to use a distributed Docker image.
# This script is automatically picked up by the nginx entrypoint on startup.

set -e

INDEX_BUNDLE_PATH="/app/dashboard/index.html"

if [[ -z "${API_URL}" ]]; then
    echo "No API_URL provided, using defaults."
else
    echo "Setting API_URL to: $API_URL"

    sed -i "s#API_URL:.*#API_URL: \"$API_URL\",#" "$INDEX_BUNDLE_PATH"
fi
