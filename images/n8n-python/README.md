# n8n-python

n8n base image with Python 3 and pip installed for Task Runner support and Execute Command node.

## Features

- Python 3.12+ with pip
- Compatible with n8n v2.x hardened images
- Multi-architecture support (amd64/arm64)

## Build args

| Argument | Default | Description |
|----------|---------|-------------|
| `N8N_VERSION` | `latest` | n8n version to use as base |
| `APK_STATIC_VERSION` | `2.14.4` | apk.static version for package installation |
| `ALPINE_VERSION` | `3.22` | Alpine repository version |

## Local build

```bash
docker build --build-arg N8N_VERSION=latest -t n8n-python:local .
```

## Usage

```bash
docker run -d \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  ghcr.io/juliopolycarpo/n8n-python:latest
```

## Technical notes

Since n8n v2.1.0, the official images use Docker Hardened Images without `apk` package manager. This image uses `apk.static` to bootstrap package installation securely.
