#!/usr/bin/env bash

# Load common functions
. $(dirname $0)/common.sh

# Pull all images
$COMPOSE pull
# Build environment
$COMPOSE build
# Start all containers
$COMPOSE up -d

e_finish
