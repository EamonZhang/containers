#!/bin/bash
# Copyright Drycc Community
# SPDX-License-Identifier: APACHE-2.0
#
# Bitnami custom library

# shellcheck disable=SC1091

# Load Generic Libraries
. /opt/drycc/scripts/liblog.sh

# Constants
BOLD='\033[1m'

# Functions

########################
# Print the welcome page
# Globals:
#   DISABLE_WELCOME_MESSAGE
#   DRYCC_APP_NAME
# Arguments:
#   None
# Returns:
#   None
#########################
print_welcome_page() {
    if [[ -z "${DISABLE_WELCOME_MESSAGE:-}" ]]; then
        if [[ -n "$DRYCC_APP_NAME" ]]; then
            print_image_welcome_page
        fi
    fi
}

########################
# Print the welcome page for a Drycc Container image
# Globals:
#   DRYCC_APP_NAME
# Arguments:
#   None
# Returns:
#   None
#########################
print_image_welcome_page() {
    local github_url="https://github.com/drycc/containers"

    log ""
    log "${BOLD}Welcome to the Bitnami ${DRYCC_APP_NAME} container${RESET}"
    log "Subscribe to project updates by watching ${BOLD}${github_url}${RESET}"
    log "Submit issues and feature requests at ${BOLD}${github_url}/issues${RESET}"
    log ""
}

