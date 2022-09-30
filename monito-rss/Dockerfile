FROM synzen/monitorss@sha256:4eeb28e5df07686c724e7dbb470b6cd8c91e0aa9c9b5f11dde75b7880232454d as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:18-alpine@sha256:2ece80175df95b3730ea35f5d0922417fed7093779ca2009cbbf96ea3cd6a588

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
