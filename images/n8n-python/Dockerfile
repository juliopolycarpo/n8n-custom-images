ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root

# n8n v2.x uses Docker Hardened Images without package manager (apk removed for security)
# Solution: Use apk.static binary to bootstrap package installation
# Reference: https://github.com/n8n-io/n8n/issues/23246
ARG APK_STATIC_VERSION=2.14.4
ARG ALPINE_VERSION=3.22

RUN wget -q "https://gitlab.alpinelinux.org/api/v4/projects/5/packages/generic/v${APK_STATIC_VERSION}/x86_64/apk.static" \
         -O /tmp/apk.static \
    && chmod +x /tmp/apk.static \
    && /tmp/apk.static \
         -X "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/main" \
         -X "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/community" \
         -U --allow-untrusted --initdb \
         add apk-tools python3 py3-pip \
    && rm /tmp/apk.static \
    && rm -rf /var/cache/apk/*

USER node
