#!/usr/bin/env bash

# Load common functions
. $(dirname $0)/common.sh

# Check Docker
is_cmd docker || e_abort 'Docker is not installed!'
# Check Docker Compose
is_cmd docker-compose || e_abort 'Docker compose is not installed!'

# Wait for web server to start
wait_for 'curl --insecure --output /dev/null --silent --head --fail https://localhost:8140/puppet-ca/v1/certificate/ca'

# Check running containers
container_running \
  aws_PuppetServer_1

aws --version
aws s3 ls

e_finish
