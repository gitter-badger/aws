#!/usr/bin/env bash

# Load common functions
. $(dirname $0)/common.sh

# Install docker-compose if not installed already
if [ -s $COMPOSE ] && [ -x $COMPOSE ]; then
  echo "'${COMPOSE}' is present."
else
  curl -Lo $COMPOSE https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m`
  chmod +x $COMPOSE
fi

# Pull all images
$COMPOSE pull
# Build environment
$COMPOSE build
# Start all containers
$COMPOSE up -d

e_finish
