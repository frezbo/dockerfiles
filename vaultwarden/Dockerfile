# use the official vaultwarden alpine container image
FROM --platform=${BUILDPLATFORM:-linux/amd64} vaultwarden/server:1.28.1-alpine as base

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

FROM scratch

ENV ROCKET_PROFILE="release"
ENV ROCKET_ADDRESS=0.0.0.0
ENV ROCKET_PORT=8080

COPY --from=base /web-vault/ /web-vault/
COPY --from=base /vaultwarden/ /vaultwarden
# add ca certificates from base image
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 8080

# run as non-root user 1000
USER 1000
ENTRYPOINT ["/vaultwarden"]
