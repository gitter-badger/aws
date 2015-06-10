#!/usr/bin/env bash

# Load Functions
. <(wget -qO- https://vladgh.s3.amazonaws.com/scripts/common.sh) || true

# Update System
update_system

# Load AWS Functions
source_remote_script aws.sh
ensure_awscli

# Load Docker Functions
source_remote_script docker.sh
ensure_docker && ensure_docker_compose

# DONE
e_finish
