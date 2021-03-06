#!/usr/bin/env bash
set -e

# VARs
BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || true)
SHA=$(git rev-parse --short HEAD 2>/dev/null || true)
[[ $BRANCH == 'master' ]] && ENV='production' || ENV=$BRANCH
BUILD=${CIRCLE_BUILD_NUM:-0}
DEPLOYMENT_GROUP_NAME=${DEPLOYMENT_GROUP_NAME:-$ENV}
DATA_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
PUPPET_CODE_DIR="${DATA_DIR}/puppetlabs/code"
HOME='/home/ubuntu'
PATH=$PATH:/usr/local/bin

# Compose deployment key
DEPLOYMENT_KEY=$(echo "${DEPLOYMENT_KEY}.${DEPLOYMENT_BUNDLE}" | \
  sed "s/{BRANCH}/${BRANCH}/" | \
  sed "s/{SHA}/${SHA}/" | \
  sed "s/{BUILD}/${BUILD}/")

# Load Remote Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true
for script in aws puppet ruby docker; do
  source_remote_script ${script}.sh
done
