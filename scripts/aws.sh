#!/usr/bin/env bash
set -e

# DATA URL
INSTANCE_DATA_URL='http://instance-data/latest'

# The EC2 instance ID for the local instance
get_instance_id() {
  curl -s ${INSTANCE_DATA_URL}/meta-data/instance-id
  return $?
}

# The AWS region
get_instance_region() {
  if [ -z "$AWS_REGION" ]; then
    AWS_REGION=$(curl -s ${INSTANCE_DATA_URL}/dynamic/instance-identity/document \
      | grep -i region \
      | awk -F\" '{print $4}')
  fi
  echo $AWS_REGION
}

# AWS CLI Command
AWS_CLI="aws --region $(get_instance_region)"
