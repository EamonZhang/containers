#!/bin/bash
# Copyright Drycc Community
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

# Load libraries
. /opt/drycc/scripts/libopensearchdashboards.sh
. /opt/drycc/scripts/libos.sh

# Load environment
. /opt/drycc/scripts/opensearch-dashboards-env.sh

# Ensure opensearch-dashboards environment variables are valid
kibana_validate

# Ensure 'daemon' user exists when running as 'root'
am_i_root && ensure_user_exists "$SERVER_DAEMON_USER" --group "$SERVER_DAEMON_GROUP"

# Ensure opensearch-dashboards is initialized
kibana_initialize

# Ensure custom initialization scripts are executed
kibana_custom_init_scripts
