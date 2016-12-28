#!/usr/bin/env sh

VERSION_DIR="$(cd version && pwd)"

# shellcheck disable=2164
cd repository

git tag --list 'v*' --contains HEAD | sed -n 's/^v//p' > "$VERSION_DIR/number"
git rev-parse --short HEAD > "$VERSION_DIR/hash"

[ -z "$product_name" ] && echo "$product_name" > "$VERSION_DIR/name"
