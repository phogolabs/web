#!/usr/bin/env sh

cd git-repository

git tag --list 'v*' --contains HEAD | sed -n 's/^v//p' > version/number
git rev-parse --short HEAD > version/hash
