FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.15.6-buster AS builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG VERSION

ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOPATH=/go/src/
WORKDIR /go/src/github.com/emersion/hydroxide
RUN git clone --branch ${VERSION} https://github.com/emersion/hydroxide.git /go/src/github.com/emersion/hydroxide

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build ./cmd/hydroxide

FROM scratch
COPY --from=builder /go/src/github.com/emersion/hydroxide/hydroxide /bin/hydroxide
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
ENV XDG_CONFIG_HOME=/home
USER 1000
ENTRYPOINT ["/bin/hydroxide"]
CMD ["serve"]
