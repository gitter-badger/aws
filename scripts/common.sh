#!/usr/bin/env bash
set -ex

# Load Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true

# VARs
BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || true)
SHA=$(git rev-parse --short HEAD 2>/dev/null || true)
[[ $BRANCH == 'master' ]] && ENV='production' || ENV=$BRANCH
BUILD=${CIRCLE_BUILD_NUM:-0}
DEPLOYMENT_GROUP_NAME=$ENV
DEPLOYMENT_BUNDLE='zip'
DATA_DIR="/opt/${APPLICATION_NAME}"

# Compose file name
DEPLOYMENT_KEY=$(echo "${DEPLOYMENT_KEY}.${DEPLOYMENT_BUNDLE}" | \
  sed "s/{BRANCH}/${BRANCH}/" | \
  sed "s/{SHA}/${SHA}/" | \
  sed "s/{BUILD}/${BUILD}/")
