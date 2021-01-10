# use the official bitwarden alpine image
FROM --platform=${BUILDPLATFORM:-linux/amd64} bitwardenrs/server:1.18.0-alpine as base

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

FROM scratch

ENV ROCKET_ENV="production"
ENV ROCKET_PORT=8080
ENV ROCKET_WORKERS=10

COPY --from=base /Rocket.toml /Rocket.toml
COPY --from=base /web-vault/ /web-vault/
COPY --from=base /bitwarden_rs/ /bitwarden_rs

EXPOSE 8080

USER 1000
ENTRYPOINT ["/bitwarden_rs"]