#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Pull all images
$COMPOSE pull
# Build environment
$COMPOSE build
# Start all containers
$COMPOSE --project-name $APPLICATION_NAME up -d

# DONE
e_finish
