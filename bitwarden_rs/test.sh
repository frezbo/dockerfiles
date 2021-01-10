#!/bin/bash

set -eux -o pipefail

CONTAINER_NAME=$(uuidgen)
REPO="ghcr.io/frezbo"

PROJECT="${1}"
TAG="${2}"

IMAGE="${REPO}/${PROJECT}:${TAG}"
TESTDIR=$(mktemp -d)
DATA_DIR_NAME="data"
DATA_DIR="${TESTDIR}/${DATA_DIR_NAME}"

mkdir -p "${DATA_DIR}"

[[ -v GITHUB_ACTIONS ]] && sudo chown 1000:1000 "${DATA_DIR}"

function cleanup() {
    docker container logs "${CONTAINER_NAME}"
    docker container rm --force "${CONTAINER_NAME}"
    rm -rf "${TESTDIR}"
}

trap cleanup EXIT SIGINT


(
    cd "${TESTDIR}"
    # generate keys for bitwarden
    openssl genrsa -out "${DATA_DIR}/rsa_key.pem" 4096
    openssl rsa -in "${DATA_DIR}/rsa_key.pem" -outform DER -out "${DATA_DIR}/rsa_key.der"
    openssl rsa -in "${DATA_DIR}/rsa_key.der" -inform DER -RSAPublicKey_out -outform DER -out "${DATA_DIR}/rsa_key.pub.der"
    docker container run --name "${CONTAINER_NAME}" --detach --publish 8080:8080 --volume "${DATA_DIR}/:/${DATA_DIR_NAME}/" "${IMAGE}"
    # wait for container to boot
    sleep 10
    curl -sf http://localhost:8080/alive
)
