#!/bin/bash

################################################################################

# Set the Docker container name from a project name (first argument).
# If no argument is given, use the current user name as the project name.
PROJECT=$1
if [ -z "${PROJECT}" ]; then
  PROJECT=${USER}
fi
CONTAINER="${PROJECT}-ppl-1"
echo "$0: PROJECT=${CONTAINER}"

################################################################################

# Run the Docker container in the background with host networking.
# Any changes made to './docker/docker-compose.yml' will recreate and overwrite the container.
docker compose -p ${PROJECT} -f ./docker/docker-compose.yml up -d

################################################################################

# Display GUI through X Server by granting full access to any external client.
# Get the host IP address
HOST_IP=$(ipconfig getifaddr en0)
xhost +

################################################################################

# Enter the Docker container with a Bash shell (with or without a custom).
case "$3" in
  ( "" )
  case "$2" in
    ( "" )
    docker exec -e DISPLAY=${HOST_IP}:0 -i -t ${CONTAINER} bash
    ;;
    ( * )
    docker exec -e DISPLAY=${HOST_IP}:0 -i -t ${CONTAINER} bash -i -c "~/root/ppl_ws/docker/ppl-dev/scripts/run-command-repeatedly.sh $2"
  esac
  ;;
  ( * )
  echo "Failed to enter the Docker container '${CONTAINER}': '$3' is not a valid argument value (needs to be a launch file or empty)."
  ;;
esac
