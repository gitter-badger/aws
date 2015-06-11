#!/usr/bin/env bash
set -ex
exec > >(sudo logger -t `basename "$0"` -s 2>/dev/console) 2>&1

# Load Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true

# Ensure AWS Environment
source_remote_script aws.sh
ensure_awscli

# Ensure Docker Environment
source_remote_script docker.sh
ensure_docker && ensure_docker_compose

# DONE
e_finish
