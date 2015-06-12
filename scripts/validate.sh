#!/usr/bin/env bash
set -ex

# Load Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true
source_remote_script docker.sh

# Check Docker
is_cmd docker || e_abort 'Docker is not installed!'
# Check Docker Compose
is_cmd docker-compose || e_abort 'Docker compose is not installed!'

# Wait for PuppetServer to start and return certificate
wait_for 'curl --insecure --output /dev/null --silent --fail https://localhost:8140/puppet-ca/v1/certificate/ca'

# Check running containers
container_running \
  aws_PuppetServer_1

# DONE
e_finish
