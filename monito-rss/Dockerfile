FROM synzen/monitorss@sha256:99390fbfb08e16033d0ea26b4059c7c98bdaf78902a8a1c7d3bded10f9ad723c as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:17-alpine@sha256:f61706c2cb120c06cf4fdcf60a2822a804b0bd90b6b2209be1ee00db1d33130c

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
