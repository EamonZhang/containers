#!/bin/bash
# Copyright Drycc Community
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/drycc/scripts/libfs.sh
. /opt/drycc/scripts/libos.sh
. /opt/drycc/scripts/libmysql.sh

# Load MySQL environment variables
. /opt/drycc/scripts/mysql-env.sh

# Ensure mysql unix socket file does not exist
rm -rf "${DB_SOCKET_FILE}.lock"
# Ensure MySQL environment variables settings are valid
mysql_validate
# Ensure MySQL is stopped when this script ends.
trap "mysql_stop" EXIT
if am_i_root; then
    # Ensure 'daemon' user exists when running as 'root'
    ensure_user_exists "$DB_DAEMON_USER" --group "$DB_DAEMON_GROUP"
    # Fix logging issue when running as root
    chmod o+w "$(readlink /dev/stdout)"
fi
# Ensure MySQL is initialized
mysql_initialize
# Allow running custom initialization scripts
mysql_custom_scripts 'init'
# Allow running custom start scripts
mysql_custom_scripts 'start'
# Stop MySQL before flagging it as fully initialized.
# Relying only on the trap defined above could produce a race condition.
mysql_stop
