#!/usr/bin/env bash

set -eu -o pipefail

VERSION=$(grep "FROM --platform" Dockerfile | awk '{ print $3}' | awk -F ':' '{ print $2}' | sed 's/-.*//g')
export VERSION
