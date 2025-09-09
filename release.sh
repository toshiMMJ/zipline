#!/bin/bash

set -e -u


THIS_DIR=$(cd -P "$(dirname "$(readlink "${BASH_SOURCE[0]}" || echo "${BASH_SOURCE[0]}")")" && pwd)
DEFAULT_MVN_REPO="${THIS_DIR}/zipline-releases/"
THE_MVN_REPO=${MVN_REPO:-${1:-$DEFAULT_MVN_REPO}}

DEFAULT_SDK_VERSION=$(grep VERSION_NAME ${THIS_DIR}/gradle.properties | cut -d"=" -f2)
SDK_VERSION=${OVERRIDE_SDK_VERSION:-${DEFAULT_SDK_VERSION}}

MVN_REPO_PATH=$(realpath $THE_MVN_REPO)
THE_MVN_REPO="file:${MVN_REPO_PATH}"

export MVN_REPO=$THE_MVN_REPO

echo "Releasing zipline ${SDK_VERSION}"
echo "Using ${MVN_REPO} as the Maven repo"

./gradlew clean
./gradlew assembleRelease
./gradlew publish
