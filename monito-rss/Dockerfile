FROM synzen/monitorss@sha256:99390fbfb08e16033d0ea26b4059c7c98bdaf78902a8a1c7d3bded10f9ad723c as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:17-alpine@sha256:57106b8c14fdfc6d1ee2b27de320a4d17db55032c4e6e99ff1021d81ef01c328

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
