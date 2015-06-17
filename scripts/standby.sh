#!/usr/bin/env bash

# Load Functions
. $(dirname $0)/common.sh

# Enter/Exit standby before/after deployment
if [[ "${LIFECYCLE_EVENT}" == 'AfterInstall' ]]; then
  autoscaling_enter_standby
elif [[ "${LIFECYCLE_EVENT}" == 'ValidateService' ]]; then
  autoscaling_exit_standby
fi

# DONE
e_finish
