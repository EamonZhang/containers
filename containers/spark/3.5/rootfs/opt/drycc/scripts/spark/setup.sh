#!/bin/bash
# Copyright Drycc Community
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace

# Load libraries
. /opt/drycc/scripts/libos.sh
. /opt/drycc/scripts/libfs.sh
. /opt/drycc/scripts/libspark.sh

# Load Spark environment settings
. /opt/drycc/scripts/spark-env.sh

# Ensure Spark environment variables settings are valid
spark_validate

# Ensure 'spark' user exists when running as 'root'
am_i_root && ensure_user_exists "$SPARK_DAEMON_USER" --group "$SPARK_DAEMON_GROUP"

# Ensure Spark is initialized
spark_initialize

# Run custom initialization scripts
spark_custom_init_scripts
