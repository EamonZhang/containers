#!/bin/bash
# Copyright Drycc Community
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1090,SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/drycc/scripts/liblog.sh
. /opt/drycc/scripts/libos.sh
. /opt/drycc/scripts/libvalidations.sh
. /opt/drycc/scripts/libclickhouse.sh

# Load ClickHouse environment variables
. /opt/drycc/scripts/clickhouse-env.sh

declare -a cmd=("${CLICKHOUSE_BASE_DIR}/bin/clickhouse-server")
declare -a args=("--config-file=${CLICKHOUSE_CONF_FILE}" "--pid-file=${CLICKHOUSE_PID_FILE}")
args+=("$@")

info "** Starting ClickHouse **"
if am_i_root; then
    exec_as_user "$CLICKHOUSE_DAEMON_USER" "${cmd[@]}" "${args[@]}"
else
    exec "${cmd[@]}" "${args[@]}"
fi
