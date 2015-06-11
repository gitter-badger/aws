#!/usr/bin/env bash
set -ex
exec > >(sudo logger -t `basename "$0"` -s 2>/dev/console) 2>&1

# Load Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true
source_remote_script docker.sh

# Check Docker
is_cmd docker || e_abort 'Docker is not installed!'
# Check Docker Compose
is_cmd docker-compose || e_abort 'Docker compose is not installed!'

# Check running containers
container_running \
  aws_PuppetServer_1

# DONE
e_finish
