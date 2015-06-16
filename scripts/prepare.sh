#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Ensure Puppet
install_puppet_agent

# Ensure Ruby
install_rvm

# Ensure Puppet Modules
load_puppet_path && load_rvm
rvm use 2.2.1 && install_gem librarian-puppet
cd $PUPPET_CODE_DIR
librarian-puppet install --path modules --clean --verbose

# Ensure AWS Environment
install_awscli

# Ensure Docker Environment
install_docker_compose

# DONE
e_finish
