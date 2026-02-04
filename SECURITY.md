# Security Policy

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| latest  | :white_check_mark: |
| n8n-vX.Y.Z (current minor) | :white_check_mark: |
| Older versions | :x: |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it responsibly:

1. **DO NOT** open a public issue
2. Email the maintainers directly at julio@polycarpo.dev or use [GitHub Security Advisories](https://github.com/juliopolycarpo/n8n-custom-images/security/advisories/new)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Affected images/versions
   - Potential impact

## Response Timeline

- **Acknowledgment:** Within 48 hours
- **Initial assessment:** Within 7 days
- **Fix release:** Depends on severity (critical: ASAP, high: 7 days, medium: 30 days)

## Security Best Practices

When using these images:

1. **Always pin to specific versions** in production (`n8n-v1.34.0` not `latest`)
2. **Scan images** before deploying (Trivy, Snyk, etc.)
3. **Use read-only filesystems** where possible
4. **Run as non-root** (our images already do this)
5. **Keep images updated** to get security patches

## Upstream Dependencies

These images inherit security properties from:
- [n8n official images](https://github.com/n8n-io/n8n)
- Base OS (Alpine Linux or Debian)

We recommend monitoring upstream advisories as well.
