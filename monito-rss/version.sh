#!/usr/bin/env bash

set -eu -o pipefail

VERSION=$(git ls-remote --quiet https://github.com/synzen/MonitoRSS-Clone.git HEAD | awk '{ print $1 }')
export VERSION

