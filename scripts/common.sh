#!/usr/bin/env bash
set -e

# PATHS
DOCKER='/usr/bin/docker'
COMPOSE='/usr/local/bin/docker-compose'

# Check if command exists
is_cmd() { command -v "$@" > /dev/null 2>&1 ;}

# $1 => error message, $2 => exit code (defaults to 1)
e_abort() { echo $1; exit ${2:-1}; }
e_finish() { echo "Finished $(basename $0) at $(/bin/date "+%F %T")"; }

# Check if container is running
container_running() {
  for container in $@; do
    [[ $($DOCKER inspect --format='{{.State.Running}}' $container 2>/dev/null) == true ]] || \
      e_abort "'$container' container is not running!"
  done
}

# Check if container exited cleanly
container_exited_clean() {
  for container in $@; do
    [[ $($DOCKER inspect --format='{{.State.ExitCode}}' $container 2>/dev/null) == 0 ]] || \
      e_abort "'$container' container did not exit cleanly!"
  done
}

# Wait function
wait_for() { until $1; do sleep 5; done; }
