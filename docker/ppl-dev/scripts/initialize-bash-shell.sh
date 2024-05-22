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

function build-ppl () {
  # Store the current directory and execute scripts in the current shell process.
  pushd .
  echo "Fixing permission issues..."
  source /root/ppl_ws/docker/ppl-dev/scripts/fix-permission-issues.sh
  echo "Building vcpkg dependencies..."
  source /root/ppl_ws/docker/ppl-dev/scripts/build-vcpkg.sh
  echo "Building PPL..."
  source /root/ppl_ws/docker/ppl-dev/scripts/build-ppl.sh
  popd
}

function build-vizmo () {
  # Store the current directory and execute scripts in the current shell process.
  pushd .
  source /root/ppl_ws/ppl_ws/docker/ppl-dev/scripts/fix-permission-issues.sh
  source /root/ppl_ws/docker/ppl-dev/scripts/build-vizmo.sh
  popd
}

function build-workspace () {
  # Store the current directory and execute scripts in the current shell process.
  pushd .
  source /root/ppl_ws/docker/ppl-dev/scripts/fix-permission-issues.sh
  source /root/ppl_ws/docker/ppl-dev/scripts/build-workspace.sh
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

alias cp='cd /root/ppl_ws/ppl'
alias cps='cd /root/ppl_ws/ppl/src'
alias cpu='cd /root/ppl_ws/pmpl_utils'
alias cpv='cd /root/ppl_ws/vizmo'
# alias cb='colcon build --symlink-install --cmake-args "-DCMAKE_BUILD_TYPE=Release"'
# alias cc='catkin clean'
# alias s='source /root/ppl_ws/ppl_cc_ws/install/setup.bash'

# alias rd='rosdep install -i --from-paths'
# alias rqt_plot='ros2 run rqt_plot rqt_plot'
# alias rqt_reconfigure='ros2 run rqt_reconfigure rqt_reconfigure'
# alias rqt_tf_tree='ros2 run rqt_tf_tree rqt_tf_tree'

###############################################################################

# PhoXi settings

# if [ -d /opt/PhotoneoPhoXiControl-1.2.14 ]; then
#   export PHOXI_CONTROL_PATH=/opt/PhotoneoPhoXiControl-1.2.14
#   export PATH=${PATH}:${PHOXI_CONTROL_PATH}/bin
#   export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PHOXI_CONTROL_PATH}/API/lib
#   export CPATH=${CPATH}:${PHOXI_CONTROL_PATH}/API/include
# fi

###############################################################################

# PhoLocalizationSDK settings

# if [ -d /opt/PhotoneoSDK/Localization ]; then
#   export PHO_LOCALIZATION_PATH=/opt/PhotoneoSDK/Localization
#   export PATH=${PATH}:${PHO_LOCALIZATION_PATH}/bin
#   export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PHO_LOCALIZATION_PATH}/lib
#   export CPATH=${CPATH}:${PHO_LOCALIZATION_PATH}/include
# fi

################################################################################

# Move to the working directory.
cd /root/ppl_ws/