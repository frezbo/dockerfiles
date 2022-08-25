FROM synzen/monitorss@sha256:4eeb28e5df07686c724e7dbb470b6cd8c91e0aa9c9b5f11dde75b7880232454d as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:18-alpine@sha256:9d88437327d836315bb5f14f0b5cd0b06bd4aeda6e0783788694213addc02f57

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
