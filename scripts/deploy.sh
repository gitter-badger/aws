#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Deploy
echo 'Uploading application to AWS S3'
awscmd deploy push \
  --application-name ${APPLICATION_NAME} \
  --ignore-hidden-files \
  --s3-location s3://${DEPLOYMENT_BUCKET}/${DEPLOYMENT_KEY} \
  --source ./
echo 'Creating deployment'
awscmd deploy create-deployment --application-name ${APPLICATION_NAME} --s3-location bucket=${DEPLOYMENT_BUCKET},key=${DEPLOYMENT_KEY},bundleType=${DEPLOYMENT_BUNDLE} --deployment-group-name ${DEPLOYMENT_GROUP_NAME} --deployment-config-name ${DEPLOYMENT_CONFIG}

# DONE
e_finish
