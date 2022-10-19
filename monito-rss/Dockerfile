FROM synzen/monitorss@sha256:4eeb28e5df07686c724e7dbb470b6cd8c91e0aa9c9b5f11dde75b7880232454d as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:19-alpine@sha256:88f6aa846169ea75341059f3104d6c5ebeac4be861a5adcf0489fccb55573ea7

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
