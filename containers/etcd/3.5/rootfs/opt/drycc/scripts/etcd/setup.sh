#!/bin/bash
# Drycc Community
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/drycc/scripts/libos.sh
. /opt/drycc/scripts/libetcd.sh

# Load etcd environment settings
. /opt/drycc/scripts/etcd-env.sh

# Ensure etcd environment settings are valid
etcd_validate
# Ensure etcd is stopped when this script ends.
trap "etcd_stop" EXIT
# Ensure 'daemon' user exists when running as 'root'
am_i_root && ensure_user_exists "$ETCD_DAEMON_USER" --group "$ETCD_DAEMON_GROUP"
# Ensure etcd is initialized
etcd_initialize
