#!/bin/bash
set -e

if LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null); then
  :
else
  LATEST_TAG="v0.0.0"
fi
echo "🏷️ Latest Git tag resolved to: $LATEST_TAG"
LATEST_TAG="${LATEST_TAG#v}"

echo "latest_tag=$LATEST_TAG" >> "$GITHUB_OUTPUT"

SHORT_SHA=$(git rev-parse --short HEAD)
DRAFT_VERSION="${LATEST_TAG}-${SHORT_SHA}"

echo "draft_version=$DRAFT_VERSION"
echo "draft_version=$DRAFT_VERSION" >> "$GITHUB_OUTPUT"
