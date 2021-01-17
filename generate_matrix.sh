#!/bin/bash

set -eu -o pipefail

CHANGED_DIRS=$(git diff-tree --no-commit-id --name-only -r "${GITHUB_SHA}" '*Dockerfile' '*go.mod' | xargs -I {} dirname {} | uniq)

# for pull requests we have to compare with main branch
if [[ "${GITHUB_EVENT_NAME}" == "pull_request" ]]; then
    git fetch --depth=2 origin main
    CHANGED_DIRS="$(git --no-pager diff --name-only "${GITHUB_SHA}" "$(git merge-base "${GITHUB_SHA}" FETCH_HEAD)" '*Dockerfile' '*go.mod' | xargs -I {} dirname {} | uniq)"
fi

MATRIX_PROJECTS_JSON="["
MATRIX_INCLUDE_JSON="["

for DIR in ${CHANGED_DIRS}; do
    MATRIX_PROJECTS_JSON+=$(sed 's/^/"/;s/$/"/' <<< "${DIR}")
    DOCKERFILE="${DIR}/Dockerfile"
    GOMOD_FILE="${DIR}/go.mod"

    # if go.mod exists find the version from it, else assume we are re-building a public image
    if [[ -e "${GOMOD_FILE}" ]]; then
        VERSION=$(grep "require" "${GOMOD_FILE}" | awk '{ print $3 }')
    else
        VERSION=$(grep "FROM --platform" "${DOCKERFILE}" | awk '{ print $3}' | awk -F ':' '{ print $2}' | sed 's/-.*//g')
    fi

    MATRIX_INCLUDE_JSON+="{\"project\": \"${DIR}\", \"dockerfile\": \"${DOCKERFILE}\", \"version\": \"${VERSION}\"}"
done

MATRIX_INCLUDE_JSON="${MATRIX_INCLUDE_JSON//\}\{/\}, \{}"
MATRIX_INCLUDE_JSON+="]"
MATRIX_PROJECTS_JSON="${MATRIX_PROJECTS_JSON//\"\"/\", \"}"
MATRIX_PROJECTS_JSON+="]"

MATRIX_JSON="{\"projects\": ${MATRIX_PROJECTS_JSON}, \"include\": ${MATRIX_INCLUDE_JSON}}"
echo "${MATRIX_JSON}"

CONTINUE_DOCKER_JOB="no"

if [[ "${MATRIX_PROJECTS_JSON}" != "[]" ]]; then
    CONTINUE_DOCKER_JOB="yes"
fi

echo "::set-output name=continue::${CONTINUE_DOCKER_JOB}"
echo "::set-output name=matrix::${MATRIX_JSON}"
