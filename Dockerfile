FROM gcr.io/kaniko-project/executor:debug as kaniko

FROM alpine:latest

RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
    curl \
    bash \
    git \
    openssh-client \
    jq

COPY --from=kaniko /kaniko /kaniko

ENV PATH=/kaniko:$PATH
ENV DOCKER_CONFIG='/kaniko/.docker'
ENV DOCKER_CREDENTIAL_GCR_CONFIG=/kaniko/.config/gcloud/docker_credential_gcr_config.json
ENV SSL_CERT_DIR=/kaniko/ssl/certs

ENTRYPOINT ["/kaniko/executor"]
