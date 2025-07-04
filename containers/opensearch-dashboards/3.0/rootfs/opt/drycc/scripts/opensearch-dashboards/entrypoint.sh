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
. /opt/drycc/scripts/liblog.sh

# Load environment
. /opt/drycc/scripts/opensearch-dashboards-env.sh

# We add the copy from default config in the entrypoint to not break users 
# bypassing the setup.sh logic. If the file already exists do not overwrite (in
# case someone mounts a configuration file in /opt/drycc/elasticsearch/conf)
debug "Copying files from $SERVER_DEFAULT_CONF_DIR to $SERVER_CONF_DIR"
cp -nr "$SERVER_DEFAULT_CONF_DIR"/. "$SERVER_CONF_DIR"

if ! is_dir_empty "$SERVER_DEFAULT_PLUGINS_DIR"; then
    debug "Copying plugins from $SERVER_DEFAULT_PLUGINS_DIR to $SERVER_PLUGINS_DIR"
    # Copy the plugins installed by default to the plugins directory
    # If there is already a plugin with the same name in the plugins folder do nothing
    for plugin_path in "${SERVER_DEFAULT_PLUGINS_DIR}"/*; do
        plugin_name="$(basename "$plugin_path")"
        plugin_moved_path="${SERVER_PLUGINS_DIR}/${plugin_name}"
        if ! [[ -d "$plugin_moved_path" ]]; then
            cp -r "$plugin_path" "$plugin_moved_path" 
        fi
    done
fi
if [[ "$1" = "/opt/drycc/scripts/opensearch-dashboards/run.sh" ]]; then
    info "** Starting Opensearch Dashboards setup **"
    /opt/drycc/scripts/opensearch-dashboards/setup.sh
    info "** Opensearch Dashboards setup finished! **"
fi

echo ""
exec "$@"
