#!/bin/bash
# Copyright Drycc Community
# SPDX-License-Identifier: APACHE-2.0
#
# Drycc custom library

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
# Print the welcome page for a Drycc Docker image
# Globals:
#   DRYCC_APP_NAME
# Arguments:
#   None
# Returns:
#   None
#########################
print_image_welcome_page() {
    local github_url="https://github.com/drycc/containers"

    info ""
    info "${BOLD}Welcome to the Drycc ${DRYCC_APP_NAME} container${RESET}"
    info "Subscribe to project updates by watching ${BOLD}${github_url}${RESET}"
    info "Submit issues and feature requests at ${BOLD}${github_url}/issues${RESET}"
    info "Upgrade to Tanzu Application Catalog for production environments to access custom-configured and pre-packaged software components. Gain enhanced features, including Software Bill of Materials (SBOM), CVE scan result reports, and VEX documents. To learn more, visit ${BOLD}https://drycc.com/enterprise${RESET}"
    info ""
}

