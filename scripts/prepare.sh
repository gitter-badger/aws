#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Ensure AWS Environment
source_remote_script aws.sh
ensure_awscli

# Ensure Docker Environment
source_remote_script docker.sh
ensure_docker && ensure_docker_compose

# Ensure Puppet
source_remote_script puppet.sh
ensure_release_package && ensure_puppet_agent && ensure_librarian

# DONE
e_finish
