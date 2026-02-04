#!/usr/bin/env sh
set -eu

notice() {
  printf '::notice::%s
' "$1"
}

error() {
  printf '::error::%s
' "$1" >&2
}

write_output() {
  key=$1
  val=$2
  if [ -n "${GITHUB_OUTPUT:-}" ]; then
    printf '%s=%s
' "$key" "$val" >> "$GITHUB_OUTPUT"
  else
    printf '%s=%s
' "$key" "$val"
  fi
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    error "Missing required command: $1"
    exit 1
  }
}

normalize_tag() {
  tag=$1
  case "$tag" in
    n8n@*) printf '%s
' "${tag#n8n@}" ;;
    v*) printf '%s
' "${tag#v}" ;;
    *) printf '%s
' "$tag" ;;
  esac
}

version_minor() {
  printf '%s
' "${1%.*}"
}
