#!/usr/bin/env bash
set -ex

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

# DONE
e_finish
