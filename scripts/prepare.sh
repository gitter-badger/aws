#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Create a link to the latest deployed app
if [ -n "${DEPLOYMENT_ID}" ]; then
  sudo mkdir -p /opt/${APPLICATION_NAME}
  sudo ln -fs $DATA_DIR /opt/${APPLICATION_NAME}/${DEPLOYMENT_GROUP_NAME}
fi

# Ensure Puppet
install_puppet_agent

# Ensure Ruby 2.2
install_rvm && load_rvm
rvm install 2.2 && rvm 2.2
install_gem r10k

# Ensure Puppet Modules
cd $PUPPET_CODE_DIR && r10k puppetfile install --verbose

# Ensure AWS Environment
install_awscli

# Ensure Docker Environment
install_docker_compose

# DONE
e_finish
