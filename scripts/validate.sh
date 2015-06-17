#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Check Docker
is_cmd docker || e_abort 'Docker is not installed!'
# Check Docker Compose
is_cmd docker-compose || e_abort 'Docker compose is not installed!'

# Wait for PuppetServer to start and return certificate
wait_for 'curl --insecure --output /dev/null --silent --fail https://localhost:8140/puppet-ca/v1/certificate/ca'

# Check running containers
container_is_running \
  vgh_puppetserver_1

# Create a link to the latest deployed app
if [ -n "${DEPLOYMENT_ID}" ]; then
  sudo ln -fs $DATA_DIR /opt/${APPLICATION_NAME}/${DEPLOYMENT_GROUP_NAME}
fi

# DONE
e_finish
