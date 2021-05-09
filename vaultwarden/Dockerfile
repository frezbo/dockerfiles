# use the official vaultwarden alpine container image
FROM --platform=${BUILDPLATFORM:-linux/amd64} vaultwarden/server:1.21.0-alpine as base

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
COPY --from=base /vaultwarden/ /vaultwarden
# add ca certificates from base image
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 8080

USER 1000
ENTRYPOINT ["/vaultwarden"]

