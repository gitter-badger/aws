#!/usr/bin/env bash

# Load common functions
. $(dirname $0)/common.sh

# Check Docker
is_cmd docker || e_abort 'Docker is not installed!'
# Check Docker Compose
is_cmd docker-compose || e_abort 'Docker compose is not installed!'

# Check running containers
container_running \
  aws_PuppetServer_1

# DONE
e_finish
