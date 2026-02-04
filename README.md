# n8n-custom-images

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CI](https://github.com/juliopolycarpo/n8n-custom-images/actions/workflows/ci.yml/badge.svg)](https://github.com/juliopolycarpo/n8n-custom-images/actions/workflows/ci.yml)
[![Stable](https://github.com/juliopolycarpo/n8n-custom-images/actions/workflows/trigger-stable.yml/badge.svg)](https://github.com/juliopolycarpo/n8n-custom-images/actions/workflows/trigger-stable.yml)
[![Pre-release](https://github.com/juliopolycarpo/n8n-custom-images/actions/workflows/trigger-prerelease.yml/badge.svg)](https://github.com/juliopolycarpo/n8n-custom-images/actions/workflows/trigger-prerelease.yml)

Automated container images for n8n with optional runtime dependencies (e.g., Python 3).

## Goals

- Maximum automation with minimal long-term maintenance.
- Deterministic builds based on upstream n8n releases.
- Multiple images supported via a simple registry file.

## How it works

GitHub Actions monitors n8n releases and automatically builds custom images:

| Workflow | Schedule | Detects | Tags |
|----------|----------|---------|------|
| **Stable** | Daily (3:10 AM UTC) | `/releases/latest` | `latest`, `n8n-vX.Y.Z` |
| **Pre-release** | Twice daily (3:10 AM/PM UTC) | `prerelease: true` | `pre`, `n8n-pre-vX.Y.Z` |

- If a new version is detected, images are built and pushed to GHCR and Docker Hub.
- Pre-release tags mirror upstream suffixes (e.g., `-beta.N`, `-rc.N`).
- GitHub Releases track "already built" versions (pre-releases are marked accordingly).
- CI validates all changes with yamllint, shellcheck, hadolint, and Docker build tests.

## Image registry
All images are defined in `images/images.json`. Add a new image by:
1) Creating a folder in `images/<image-id>/` with a `Dockerfile`.
2) Adding an entry to `images/images.json`.

## Scripts
CI expects these scripts to be executable and uses them directly in workflows.

The workflows call small POSIX scripts under `scripts/` to keep logic decoupled and easy to change:
- `scripts/fetch_latest_stable.sh`
- `scripts/fetch_latest_prerelease.sh`
- `scripts/check_release_exists.sh`
- `scripts/tag_helpers.sh`

## Tags

### Stable Releases
| Tag | Description | Example |
|-----|-------------|---------|
| `latest` | Most recent stable release | `n8n-python:latest` |
| `n8n-vX.Y.Z` | Exact version (pinned) | `n8n-python:n8n-v1.34.0` |
| `n8n-vX.Y` | Minor version (auto-updates patches) | `n8n-python:n8n-v1.34` |

### Pre-releases (Experimental/Beta/RC)
| Tag | Description | Example |
|-----|-------------|---------|
| `pre` | Most recent pre-release | `n8n-python:pre` |
| `n8n-pre-vX.Y.Z-<pre>` | Exact pre-release version (mirrors upstream suffixes like `-exp.N`, `-beta.N`, `-rc.N`) | `n8n-python:n8n-pre-v2.4.7-exp.0` |

> **Recommendation:** Use `latest` for production. Use `pre` for testing upcoming features.

## Setup

### 1. Create a Docker Hub Access Token

1. Go to [Docker Hub Security Settings](https://hub.docker.com/settings/security)
2. Click **New Access Token**
3. Configure:
   - **Description:** `github-actions`
   - **Permissions:** `Read & Write`
4. Copy the generated token (it won't be shown again)

### 2. Configure GitHub Secrets

Go to your repository: **Settings → Secrets and variables → Actions**

Add these secrets:

| Secret Name | Example Value | Description |
|-------------|---------------|-------------|
| `DOCKERHUB_USER` | `myusername` | Your Docker Hub username |
| `DOCKERHUB_TOKEN` | `dckr_pat_abc123...` | Access token from step 1 |

### 3. Enable Workflow Permissions

Go to: **Settings → Actions → General → Workflow permissions**

Select:
- ✅ **Read and write permissions**
- ✅ **Allow GitHub Actions to create and approve pull requests**

## Required secrets
- `DOCKERHUB_USER` - Docker Hub username
- `DOCKERHUB_TOKEN` - Docker Hub access token (not password)

> **Note:** `GITHUB_TOKEN` is automatically provided by GitHub Actions.

## Manual run

Trigger builds manually via `workflow_dispatch`:

1. Go to **Actions** tab
2. Select the workflow:
   - **Release: Stable** for production versions
   - **Release: Pre-release** for beta/rc versions
3. Click **Run workflow**
4. (Optional) Check **Force build** to rebuild even if the release already exists

## Available Images

| Image | Description | Pull Command |
|-------|-------------|--------------|
| `n8n-python` | n8n with Python 3 for Task Runner support | `docker pull ghcr.io/juliopolycarpo/n8n-python:latest` |

## Contributing

See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for guidelines on adding new images.

## Security

See [SECURITY.md](SECURITY.md) for our security policy.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
