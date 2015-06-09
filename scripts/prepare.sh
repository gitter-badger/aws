#!/usr/bin/env bash

# Load common functions
. $(dirname $0)/common.sh

# Update APT
sudo apt-get -y update

# Ensure Docker is installed
if is_cmd docker && [ -e /var/run/docker.sock ]; then
  echo 'Docker Version:'
  ${DOCKER} version
else
  wget -qO- https://get.docker.com/ | sh
fi

# Ensure Docker Compose is installed
COMPOSE_VERSION='1.2.0'
COMPOSE_URL='https://github.com/docker/compose/releases/download'
COMPOSE_SCRIPT="docker-compose-$(uname -s)-$(uname -m)"
if [ -s $COMPOSE ] && [ -x $COMPOSE ]; then
  echo "'${COMPOSE}' is present."
else
  sudo curl -Lo $COMPOSE ${COMPOSE_URL}/${COMPOSE_VERSION}/${COMPOSE_SCRIPT}
  sudo chmod +x $COMPOSE
fi

# Ensure AWS CLI is installed
is_cmd pip || sudo apt-get install -y python-pip
is_cmd aws && aws --version || sudo pip install awscli

# DONE
e_finish
