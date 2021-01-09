#!/bin/bash

set -eu -o pipefail

trap cleanup EXIT SIGINT

mkdir -p bitwarden_rs

CONTAINER_NAME=$(uuidgen)

(
    cd bitwarden_rs
    # generate keys for bitwarden
    mkdir -p data
    openssl genrsa 4096 -out data/rsa_key.pem
    openssl rsa -in data/rsa_key.pem -outform DER -out data/rsa_key.der
    openssl rsa -in data/rsa_key.pem -inform DER -RSAPublicKey_out -outform DER -out data/rsa_key.pub.der
    docker container run --name "${CONTAINER_NAME}" --detach--publish 8080:8080 --volume "${PWD}/data/:/data/" ghcr.io/frezbo/bitwarden_rs
    curl -sf http://localhost:8080/alive
)

function cleanup() {
    docker container rm --force "${CONTAINER_NAME}"
    rm -rf bitwarden_rs
}
