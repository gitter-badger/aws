#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Change to the app directory when deployed
if [ -n "${DEPLOYMENT_ID}" ]; then
  cd $DATA_DIR
fi

# Install Puppet Modules
if $CI; then
  cd puppetlabs/code
  source_remote_script puppet.sh && load_puppet_path
  $PUPPET_LIBRARIAN install --path modules --clean --verbose
fi

# Load Docker functions
source_remote_script docker.sh
# Pull all images
$COMPOSE pull
# Build environment
$COMPOSE build
# Start all containers
$COMPOSE --project-name $APPLICATION_NAME up -d

# DONE
e_finish
