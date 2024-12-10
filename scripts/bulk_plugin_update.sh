#!/bin/bash

# Bulk Plugin Update Script
# Usage: ./bulk_plugin_update.sh <jenkins-url> [--safe]

JENKINS_URL="$1"
SAFE_MODE="$2"

if [ -z "$JENKINS_URL" ]; then
    echo "Usage: $0 <jenkins-url> [--safe]"
    exit 1
fi

# Download jenkins-cli.jar if not present
if [ ! -f jenkins-cli.jar ]; then
    wget "$JENKINS_URL/jnlpJars/jenkins-cli.jar"
fi

# Create backup first
./backup_plugins.sh "$JENKINS_HOME" "./backups"

# Get list of updatable plugins
UPDATABLE_PLUGINS=$(java -jar jenkins-cli.jar -s "$JENKINS_URL" list-plugins | grep -e ")$" | awk '{ print $1 }')

if [ "$SAFE_MODE" = "--safe" ]; then
    echo "Safe mode: Will update one plugin at a time"
    for plugin in $UPDATABLE_PLUGINS; do
        echo "Updating $plugin..."
        java -jar jenkins-cli.jar -s "$JENKINS_URL" install-plugin "$plugin" -deploy
        sleep 5
    done
else
    echo "Bulk updating all plugins..."
    echo "$UPDATABLE_PLUGINS" | xargs java -jar jenkins-cli.jar -s "$JENKINS_URL" install-plugin
fi

echo "Updates completed. Restarting Jenkins..."
java -jar jenkins-cli.jar -s "$JENKINS_URL" safe-restart
