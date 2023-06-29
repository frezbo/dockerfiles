FROM synzen/monitorss@sha256:4fc4ef49007c18f89bf7423c7b3cdea7864f2330589c0961faedcdb82490c311 as monito-rss

FROM --platform=${BUILDPLATFORM:-linux/amd64} node:20-alpine@sha256:cc4e8f3d78a276fa05eae1803b6f8cbb43145441f54c828ab14e0c19dd95c6fd

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

WORKDIR /app
COPY --from=monito-rss /app .
USER 1000
CMD ["server.js"]
