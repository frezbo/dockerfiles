# use the official bitwarden alpine image
FROM --platform=${BUILDPLATFORM:-linux/amd64} mattermost/mattermost-team-edition:5.34 as base

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

FROM scratch

ENV PATH="/mattermost/bin:${PATH}"
COPY --from=base /mattermost /mattermost/
# add ca certificates from base image
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 8080

USER 2000
ENTRYPOINT ["/mattermost/bin/mattermost"]
