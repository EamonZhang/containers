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
. /opt/drycc/scripts/libmysql.sh

# Load MySQL environment variables
. /opt/drycc/scripts/mysql-env.sh

# Configure MySQL options based on build-time defaults
info "Configuring default MySQL options"
ensure_dir_exists "$DB_CONF_DIR"
mysql_create_default_config

for dir in "$DB_TMP_DIR" "$DB_LOGS_DIR" "$DB_CONF_DIR" "${DB_CONF_DIR}/drycc" "$DB_VOLUME_DIR" "$DB_DATA_DIR" "/.mysqlsh"; do
    ensure_dir_exists "$dir"
    chmod -R g+rwX "$dir"
done

# Redirect logging to PID 1's stdout file descriptor including database initialization logs
ln -sf /proc/1/fd/1 "$DB_LOGS_DIR/mysqld.log"
