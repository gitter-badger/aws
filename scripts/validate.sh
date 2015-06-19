#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Check running containers
container_is_running vgh_puppetserver_1

# Wait for PuppetServer to start and return certificate
wait_for 'curl --insecure --output /dev/null --silent --fail https://localhost:8140/puppet-ca/v1/certificate/ca'

# DONE
e_finish
