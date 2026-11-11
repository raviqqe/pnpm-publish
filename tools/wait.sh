#!/bin/sh

set -e

start=$(date +%s)
packages=$(jq -r '.publishedPackages[] | "\(.name)@\(.version)"' pnpm-publish-summary.json)

for package in $packages; do
  echo "Waiting for $package in the registry..."

  until [ "$(pnpm view $package version 2>/dev/null)" = "${package##*@}" ]; do
    if [ $(($(date +%s) - start)) -gt 1800 ]; then
      echo "$package is not available in the registry." >&2
      exit 1
    fi

    sleep 10
  done
done
