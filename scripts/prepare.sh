#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Ensure Puppet
install_puppet_agent

# Ensure Ruby 2.2
install_rvm && load_rvm && rvm 2.2
gem install r10k

# Ensure Puppet Modules
cd $PUPPET_CODE_DIR && r10k puppetfile install --verbose

# Ensure AWS Environment
install_awscli

# Ensure Docker Environment
install_docker_compose

# DONE
e_finish
