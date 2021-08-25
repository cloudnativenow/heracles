#!/usr/bin/env bash

# Note: This script runs after the "terraform apply", use it to make configuration
# changes which would otherwise be overwritten by terraform.
sudo su

# Configure MID Server Process for a "midserver" O/S user
/opt/servicenow/mid/agent/installer.sh -silent \
 -INSTANCE_URL $INSTANCE_URL \
 -MUTUAL_AUTH N \
 -MID_USERNAME $MID_USERNAME \
 -MID_PASSWORD $MID_PASSWORD \
 -USE_PROXY N \
 -MID_NAME $(hostname) \
 -APP_NAME mid \
 -APP_LONG_NAME $(hostname) \
 -NON_ROOT_USER midserver