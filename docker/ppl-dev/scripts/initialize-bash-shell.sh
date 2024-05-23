#!/bin/bash

################################################################################

# Link the default shell 'sh' to Bash.
alias sh='/bin/bash'

################################################################################

# Configure the terminal.

# Disable flow control. If enabled, inputting 'ctrl+s' locks the terminal until inputting 'ctrl+q'.
stty -ixon

################################################################################

# Configure 'umask' for giving read/write/execute permission to group members.
umask 0002

################################################################################

# Add the Catkin workspaces to the 'ROS_PACKAGE_PATH'.
# export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/root/ppl_ws/o2ac-ur/catkin_ws/src/
# export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/root/ppl_ws/o2ac-ur/underlay_ws/src/

################################################################################

# Define Bash functions to conveniently execute the helper scripts in the current shell process.

function build-ppl-vcpkg () {
  # Store the current directory and execute scripts in the current shell process.
  pushd .
  echo "Fixing permission issues..."
  source /root/ppl_ws/docker/ppl-dev/scripts/fix-permission-issues.sh
  echo "Building PPL with vcpkg..."
  source /root/ppl_ws/docker/ppl-dev/scripts/build-ppl-vcpkg.sh
  popd
}

function build-ppl-conan () {
  # Store the current directory and execute scripts in the current shell process.
  pushd .
  source /root/ppl_ws/docker/ppl-dev/scripts/fix-permission-issues.sh
  source /root/ppl_ws/docker/ppl-dev/scripts/build-ppl-conan.sh
  popd
}

function build-vizmo () {
  # Store the current directory and execute scripts in the current shell process.
  pushd .
  source /root/ppl_ws/ppl_ws/docker/ppl-dev/scripts/fix-permission-issues.sh
  source /root/ppl_ws/docker/ppl-dev/scripts/build-vizmo.sh
  popd
}

function fix-permission-issues () {
  # Store the current directory and execute scripts in the current shell process.
  pushd .
  source /root/ppl_ws/docker/ppl-dev/scripts/fix-permission-issues.sh
  popd
}


###############################################################################

# aliases

alias goppl='cd /root/ppl_ws/ppl'
alias goppls='cd /root/ppl_ws/ppl/src'
alias gopplu='cd /root/ppl_ws/pmpl_utils'
alias goviz='cd /root/ppl_ws/vizmo'

################################################################################

# Move to the working directory.
cd /root/ppl_ws/