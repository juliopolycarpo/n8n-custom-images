#!/usr/bin/env sh
set -eu

. "$(dirname "$0")/tag_helpers.sh"

require_cmd curl

: "${GH_TOKEN:?GH_TOKEN is required}"
: "${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}"
: "${VERSION:=}"
: "${FORCE:=false}"
: "${RELEASE_TAG_PREFIX:=n8n-v}"

if [ -z "$VERSION" ]; then
  write_output should_build "false"
  notice "No version detected; skipping"
  exit 0
fi

if [ "$FORCE" = "true" ]; then
  write_output should_build "true"
  notice "Force build enabled"
  exit 0
fi

release_tag="${RELEASE_TAG_PREFIX}${VERSION}"
api="https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/tags/${release_tag}"
status=$(curl -s -o /dev/null -w "%{http_code}"   -H "Authorization: Bearer $GH_TOKEN"   -H "Accept: application/vnd.github+json"   "$api")

if [ "$status" = "200" ]; then
  write_output should_build "false"
  notice "Release $release_tag already exists, skipping"
else
  write_output should_build "true"
  notice "New release detected: $release_tag"
fi
