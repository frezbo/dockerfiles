#!/bin/bash

set -eu -o pipefail

trap cleanup EXIT SIGINT

CONTAINER_NAME=$(uuidgen)
REPO="ghcr.io/frezbo"

PROJECT="${1}"
TAG="${2}"

IMAGE="${REPO}/${PROJECT}:${TAG}"

mkdir -p "${PROJECT}"

(
    cd "${PROJECT}"
    # generate keys for bitwarden
    mkdir -p data
    openssl genrsa 4096 -out data/rsa_key.pem
    openssl rsa -in data/rsa_key.pem -outform DER -out data/rsa_key.der
    openssl rsa -in data/rsa_key.pem -inform DER -RSAPublicKey_out -outform DER -out data/rsa_key.pub.der
    docker container run --name "${CONTAINER_NAME}" --detach--publish 8080:8080 --volume "${PWD}/data/:/data/" "${IMAGE}"
    curl -sf http://localhost:8080/alive || docker container logs "${CONTAINER_NAME}"
)

function cleanup() {
    docker container rm --force "${CONTAINER_NAME}"
    rm -rf "${PROJECT}"
}
