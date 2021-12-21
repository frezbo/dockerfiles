FROM synzen/monitorss@sha256:99390fbfb08e16033d0ea26b4059c7c98bdaf78902a8a1c7d3bded10f9ad723c as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:17-alpine@sha256:4522cc108ad7c055b71f545596bfc07632d9f9a41125ea12eabe8f04114807f3

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
