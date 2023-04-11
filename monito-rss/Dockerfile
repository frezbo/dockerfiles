FROM synzen/monitorss@sha256:0c81db12de3ca58defd37d6a089433cbbac69fe09d5229d0c82c5c33836a9518 as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:19-alpine@sha256:ab3603cb7934b21f1ffb522b1a1d538809516c6e4cd73b144716bc1830aad1a6

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
