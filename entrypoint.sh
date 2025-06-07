#!/bin/bash
set -e

# Release mode: Use tag from GITHUB_REF
if [[ "$INPUT_RELEASE" == "true" ]]; then
  TAG_NAME="${GITHUB_REF#refs/tags/}"
  VERSION="${TAG_NAME#v}"

  echo "ℹ️ Using release version from tag: $VERSION"
  echo "release_version=$VERSION" >> "$GITHUB_OUTPUT"
else
  # Draft mode: Use latest git tag + short SHA, or fallback to default
  if LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null); then
    echo "ℹ️ Latest Git tag resolved to: $LATEST_TAG"
  else
    LATEST_TAG="v0.0.0"
    echo "⚠️ No Git tag found. Falling back to default: $LATEST_TAG"
  fi

  LATEST_TAG="${LATEST_TAG#v}"
  SHORT_SHA=$(git rev-parse --short HEAD)
  VERSION="${LATEST_TAG}-${SHORT_SHA}"

  echo "ℹ️ Generated draft version: $VERSION"
  echo "draft_version=$VERSION" >> "$GITHUB_OUTPUT"
fi
