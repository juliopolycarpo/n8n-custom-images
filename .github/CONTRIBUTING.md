# Contributing to n8n-image-templates

Thank you for your interest in contributing! This guide will help you get started.

## How to Contribute

### Adding a New Image

1. **Create the image directory:**
   ```bash
   mkdir -p images/<image-id>/
   ```

2. **Create the Dockerfile:**
   ```dockerfile
   # images/<image-id>/Dockerfile
   ARG N8N_VERSION=latest
   FROM n8nio/n8n:${N8N_VERSION}

   # Your customizations here

   USER node
   ```

3. **Add a README for the image:**
   ```bash
   touch images/<image-id>/README.md
   ```

4. **Register in `images/images.json`:**
   ```json
   {
     "images": [
       {
         "id": "<image-id>",
         "context": "images/<image-id>",
         "dockerfile": "images/<image-id>/Dockerfile",
         "description": "Brief description of the image"
       }
     ]
   }
   ```

5. **Test locally:**
   ```bash
   docker build -t <image-id>:test \
     --build-arg N8N_VERSION=latest \
     images/<image-id>/
   ```

### Reporting Bugs

- Use the [Bug Report](https://github.com/juliopolycarpo/n8n-custom-images/issues/new?template=bug_report.yml) template
- Include the image name, tag, and steps to reproduce

### Requesting Features

- Use the [Feature Request](https://github.com/juliopolycarpo/n8n-custom-images/issues/new?template=feature_request.yml) template
- Describe the use case and expected behavior

## Development Guidelines

### Dockerfile Best Practices

1. **Always use `ARG N8N_VERSION`** to allow version flexibility
2. **End with `USER node`** for security (non-root)
3. **Support both Alpine and Debian** base images when possible
4. **Minimize layers** by combining related commands
5. **Clean up caches** to reduce image size

### Commit Messages

Use conventional commits:
- `feat: add n8n-puppeteer image`
- `fix: correct Python path in n8n-python`
- `docs: update README with new examples`
- `chore: update workflow permissions`

### Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/new-image`)
3. Make your changes
4. Test locally with `docker build`
5. Submit a pull request

## Code of Conduct

Be respectful and inclusive. We follow the [Contributor Covenant](https://www.contributor-covenant.org/).

## Questions?

Open a [Discussion](https://github.com/juliopolycarpo/n8n-custom-images/discussions) or an issue.
