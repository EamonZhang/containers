#!/bin/bash
# Copyright Drycc Community
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o nounset

. /opt/drycc/scripts/liblog.sh
. /opt/drycc/scripts/libhook.sh

while : ; do
    waiting="false"
    if ! debug_execute rabbitmq-diagnostics -q check_if_node_is_mirror_sync_critical; then
        debug "check_if_node_is_mirror_sync_critical returns error. Continuing to wait"
        waiting="true"
    fi
    if ! debug_execute rabbitmq-diagnostics -q check_if_node_is_quorum_critical; then
        debug "check_if_node_is_quorum_critical returns error. Continuing to wait"
        waiting="true"
    fi
    if [[ $waiting = "true" ]]; then
        sleep 1
    else
        break
    fi
done
