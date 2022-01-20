FROM synzen/monitorss@sha256:99390fbfb08e16033d0ea26b4059c7c98bdaf78902a8a1c7d3bded10f9ad723c as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:17-alpine@sha256:64cd7cde5656f0a163def1e4202e271e83b3c7ab47a079963a82ee3716dcbf89

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
