FROM synzen/monitorss@sha256:4eeb28e5df07686c724e7dbb470b6cd8c91e0aa9c9b5f11dde75b7880232454d as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:19-alpine@sha256:1a04e2ec39cc0c3a9657c1d6f8291ea2f5ccadf6ef4521dec946e522833e87ea

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
