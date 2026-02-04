#!/usr/bin/env sh
set -eu

. "$(dirname "$0")/tag_helpers.sh"

require_cmd curl
require_cmd jq

response=$(curl -fsSL "https://api.github.com/repos/n8n-io/n8n/releases?per_page=100")
prerelease=$(printf '%s' "$response" | jq -r '[.[] | select(.prerelease == true)] | first // empty')

if [ -z "$prerelease" ]; then
  notice "No pre-release found"
  write_output version ""
  exit 0
fi

tag=$(printf '%s' "$prerelease" | jq -r '.tag_name')

if [ -z "$tag" ] || [ "$tag" = "null" ]; then
  notice "No pre-release tag found"
  write_output version ""
  exit 0
fi

version=$(normalize_tag "$tag")

write_output version "$version"
notice "Latest pre-release: $version (tag: $tag)"
