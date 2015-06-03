#!/usr/bin/env bash

# Load common functions
. $(dirname $0)/common.sh

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
