#!/bin/bash

VERSION=$(node -e "console.log(require('./package.json').version)")
BRANCH="patch/$VERSION"
PATCHED_VERSION="$VERSION-patch.0"

git checkout -b "$BRANCH"

node patch.cjs

# sync package.json and package-lock.json
npm i

git add -A
git commit -m "Apply patch"

npm version "$PATCHED_VERSION" --no-git-tag-version

git commit -a -m "v$PATCHED_VERSION"
git tag -a "v$PATCHED_VERSION" -m "v$PATCHED_VERSION"

git push -u origin "$BRANCH"
