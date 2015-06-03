#!/usr/bin/env bash

# Load common functions
. $(dirname $0)/common.sh

# Install docker-compose if not installed already
if [ -s $COMPOSE ] && [ -x $COMPOSE ]; then
  echo "'${COMPOSE}' is present."
else
  sudo curl -Lo $COMPOSE https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m`
  sudo chmod +x $COMPOSE
fi

# Install AWS CLI if not installed already
aws --version || true
is_cmd pip || sudo apt-get install -qqy python-pip
is_cmd aws && aws --version || sudo pip install awscli

e_finish
