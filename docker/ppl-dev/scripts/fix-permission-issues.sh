#!/bin/bash

################################################################################

# Allow current host user to access files generated by Docker 'root' user.
# chown -R ${HOST_UID}:${HOST_GID} /root/ppl_ws/.ros/
chown -R ${HOST_UID}:${HOST_GID} /root/
chown -R ${HOST_UID}:${HOST_GID} /root/ppl_ws/
chown -R ${HOST_UID}:${HOST_GID} /root/ppl_ws/ppl/
chown -R ${HOST_UID}:${HOST_GID} /root/ppl_ws/vizmo/
chown -R ${HOST_UID}:${HOST_GID} /root/ppl_ws/pmpl_utils/
chown -R ${HOST_UID}:${HOST_GID} /root/ppl_ws/docker/
