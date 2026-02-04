#!/usr/bin/env sh
set -eu

. "$(dirname "$0")/tag_helpers.sh"

require_cmd curl
require_cmd jq

response=$(curl -fsSL https://api.github.com/repos/n8n-io/n8n/releases/latest)
tag=$(printf '%s' "$response" | jq -r '.tag_name')

if [ -z "$tag" ] || [ "$tag" = "null" ]; then
  error "Failed to fetch latest n8n release"
  exit 1
fi

version=$(normalize_tag "$tag")
minor=$(version_minor "$version")

write_output version "$version"
write_output version_minor "$minor"
notice "Latest stable: $version (minor: $minor)"
