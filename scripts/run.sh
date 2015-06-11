#!/usr/bin/env bash
set -ex
exec > >(sudo logger -t `basename "$0"` -s 2>/dev/console) 2>&1

# Load Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true
source_remote_script docker.sh

# Change to the app directory
[[ $CIRCLECI != true ]] && cd /opt/vgh/aws

# Pull all images
$COMPOSE pull
# Build environment
$COMPOSE build
# Start all containers
$COMPOSE up -d

# Wait for PuppetServer to start
wait_for 'curl --insecure --output /dev/null --silent --head --fail https://localhost:8140/puppet-ca/v1/certificate/ca'

# DONE
e_finish
