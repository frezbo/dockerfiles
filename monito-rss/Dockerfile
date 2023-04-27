FROM synzen/monitorss@sha256:0c81db12de3ca58defd37d6a089433cbbac69fe09d5229d0c82c5c33836a9518 as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:20-alpine@sha256:cc4e8f3d78a276fa05eae1803b6f8cbb43145441f54c828ab14e0c19dd95c6fd

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

WORKDIR /app
COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
