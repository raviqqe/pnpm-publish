#!/bin/sh

set -e

timeout=600

start=$(date +%s)

jq -r '.publishedPackages[] | "\(.name) \(.version)"' pnpm-publish-summary.json |
  while read -r name version; do
    echo "Waiting for $name@$version in the registry..."

    until [ $(pnpm view $name@$version version 2>/dev/null) = $version ]; do
      if [ $(($(date +%s) - start)) -gt $timeout ]; then
        echo "$name@$version is not available in the registry." >&2
        exit 1
      fi

      sleep 10
    done
  done
