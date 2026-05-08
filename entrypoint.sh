#!/bin/bash
set -e

# Release mode: Use tag from GITHUB_REF
if [[ "$INPUT_RELEASE" == "true" ]]; then
  TAG_NAME="${GITHUB_REF#refs/tags/}"
  VERSION="${TAG_NAME#v}"

  echo "ℹ️ Using release version from tag: $VERSION"
  if [[ -z "$VERSION" ]]; then
    echo "❌ Resolved draft version is empty. Aborting."
    exit 1
  fi
  echo "release_version=$VERSION" >> "$GITHUB_OUTPUT"
else
  # Draft mode: Use latest git tag + short SHA, or fallback to default.
  # INPUT_TAG_MATCH defaults to 'v*' to match the canonical HMCTS tag
  # format (vX.Y.Z) and ignore non-semver tags such as deploy markers
  # in repos that share refs/tags/*. Callers can pass '*' to match any
  # tag (the pre-tag-match behaviour) or any other glob their repo
  # needs.
  TAG_MATCH="${INPUT_TAG_MATCH:-v*}"
  if LATEST_TAG=$(git describe --tags --abbrev=0 --match="$TAG_MATCH" 2>/dev/null); then
    echo "ℹ️ Latest Git tag resolved to: $LATEST_TAG (match: $TAG_MATCH)"
  else
    LATEST_TAG="v0.0.0"
    echo "⚠️ No Git tag matching '$TAG_MATCH' found. Falling back to default: $LATEST_TAG"
  fi

  LATEST_TAG="${LATEST_TAG#v}"
  SHORT_SHA=$(git rev-parse --short HEAD)
  VERSION="${LATEST_TAG}-${SHORT_SHA}"

  echo "ℹ️ Generated draft version: $VERSION"
  if [[ -z "$VERSION" ]]; then
    echo "❌ Resolved draft version is empty. Aborting."
    exit 1
  fi
  echo "draft_version=$VERSION" >> "$GITHUB_OUTPUT"
fi
