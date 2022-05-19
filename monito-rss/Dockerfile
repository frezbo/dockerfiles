FROM synzen/monitorss@sha256:99390fbfb08e16033d0ea26b4059c7c98bdaf78902a8a1c7d3bded10f9ad723c as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:18-alpine@sha256:12209422d0c3107ccff0212c518beefc6d2632b627c9b5c54d714beda9622f71

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
