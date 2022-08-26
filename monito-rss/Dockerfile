FROM synzen/monitorss@sha256:4eeb28e5df07686c724e7dbb470b6cd8c91e0aa9c9b5f11dde75b7880232454d as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:18-alpine@sha256:9b435939937b0deef5c1f6fcfd1f265aa7a77574388b671fda322e662744472d

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
