#!/usr/bin/env bash
set -ex

# Load Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true
source_remote_script aws.sh

# VARs
sha=$(git rev-parse --short HEAD 2>/dev/null)
branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3)
[[ $branch == 'master' ]] && branch='production'
build=${CIRCLE_BUILD_NUM:-0}
cd_bundle='zip'

# Compose file name
cd_key=$(echo $cd_key | sed "s/{branch}/$branch/")
cd_key=$(echo $cd_key | sed "s/{sha}/$sha/")
cd_key=$(echo $cd_key | sed "s/{build}/$build/")

# Deploy
echo 'Deploying...'
awscmd deploy push \
  --application-name ${cd_app} \
  --ignore-hidden-files \
  --s3-location s3://${cd_bucket}/${cd_key} \
  --source ./
awscmd deploy create-deployment --application-name ${cd_app} --s3-location bucket=${cd_bucket},key=${cd_key},bundleType=${cd_bundle} --deployment-group-name ${cd_group} --deployment-config-name ${cd_config}

# DONE
e_finish
