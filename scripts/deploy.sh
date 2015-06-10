#!/usr/bin/env bash

# Load Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true

sha=$(git rev-parse --short HEAD)
branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3)
[[ $branch == 'master' ]] && branch='production'
cd_key="${branch}/${cd_key}-${sha}.${cd_bundle}"

# Deploy
echo 'Deploying...'
aws deploy push \
  --application-name ${cd_app} \
  --ignore-hidden-files \
  --s3-location s3://${cd_bucket}/${cd_key} \
  --source ./
aws deploy create-deployment --application-name ${cd_app} --s3-location bucket=${cd_bucket},key=${cd_key},bundleType=${cd_bundle} --deployment-group-name ${cd_group} --deployment-config-name ${cd_config}

# DONE
e_finish
