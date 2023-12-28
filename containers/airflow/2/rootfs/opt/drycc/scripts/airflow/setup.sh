#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load Airflow environment variables
. /opt/drycc/scripts/airflow-env.sh

# Load PostgreSQL Client environment for 'postgresql_remote_execute' (after 'airflow-env.sh' so that MODULE is not set to a wrong value)
if [[ -f /opt/drycc/scripts/postgresql-client-env.sh ]]; then
    . /opt/drycc/scripts/postgresql-client-env.sh
elif [[ -f /opt/drycc/scripts/postgresql-env.sh ]]; then
    . /opt/drycc/scripts/postgresql-env.sh
fi

# Load libraries
. /opt/drycc/scripts/libos.sh
. /opt/drycc/scripts/libfs.sh
. /opt/drycc/scripts/libairflow.sh

# Ensure Airflow environment variables settings are valid
airflow_validate
# Ensure Airflow daemon user exists when running as root
am_i_root && ensure_user_exists "$AIRFLOW_DAEMON_USER" --group "$AIRFLOW_DAEMON_GROUP"
# Ensure Airflow is initialized
airflow_initialize
