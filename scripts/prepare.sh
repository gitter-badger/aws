#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Enter Standby
if [[ "${LIFECYCLE_EVENT}" == 'AfterInstall' ]]; then
  autoscaling_enter_standby
fi

# Create a link to the latest deployed app
if [ -n "${DEPLOYMENT_ID}" ]; then
  sudo ln -sfn $DATA_DIR /opt/${APPLICATION_NAME}
fi

# Ensure Puppet
install_puppet_agent

# Ensure Ruby 2.2
install_rvm && load_rvm && rvm_use_ruby 2.2

# Ensure Puppet Modules
install_gem r10k
cd $PUPPET_CODE_DIR && r10k puppetfile install --verbose

# Ensure AWS Environment
install_awscli

# Ensure Docker Environment
install_docker_compose

# DONE
e_finish
