#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Ensure Puppet
install_puppet_agent

# Ensure Ruby
install_rvm

# Ensure Puppet Modules
# FIXME Not good at all
# load_puppet_path && load_rvm
#rvm use 2.2.1
gem install r10k
cd $PUPPET_CODE_DIR
r10k puppetfile install --verbose

# Ensure AWS Environment
install_awscli

# Ensure Docker Environment
install_docker_compose

# DONE
e_finish
