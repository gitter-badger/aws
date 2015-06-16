#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Ensure Puppet
ensure_puppet_agent

# Ensure Ruby
install_rvm

# Ensure Puppet Modules
load_puppet_path && load_rvm && install_gem librarian-puppet
cd $PUPPET_CODE_DIR
librarian-puppet install --path modules --clean --verbose

# Ensure AWS Environment
ensure_awscli

# Ensure Docker Environment
ensure_docker_compose

# DONE
e_finish
