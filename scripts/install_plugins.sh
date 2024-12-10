#!/bin/bash

# Jenkins Plugin Installation Script
# Usage: ./install_plugins.sh <jenkins-url> <plugin-list-file>

JENKINS_URL="$1"
PLUGIN_LIST="$2"

if [ -z "$JENKINS_URL" ] || [ -z "$PLUGIN_LIST" ]; then
    echo "Usage: $0 <jenkins-url> <plugin-list-file>"
    exit 1
fi

# Check if jenkins-cli.jar exists, download if not
if [ ! -f jenkins-cli.jar ]; then
    wget "$JENKINS_URL/jnlpJars/jenkins-cli.jar"
fi

# Read plugin list and install each plugin
while IFS= read -r plugin || [ -n "$plugin" ]; do
    # Skip comments and empty lines
    [[ $plugin =~ ^#.*$ ]] && continue
    [[ -z $plugin ]] && continue
    
    echo "Installing plugin: $plugin"
    java -jar jenkins-cli.jar -s "$JENKINS_URL" install-plugin "$plugin" -deploy
    
    if [ $? -ne 0 ]; then
        echo "Failed to install plugin: $plugin"
    fi
done < "$PLUGIN_LIST"

# Restart Jenkins to apply changes
echo "Restarting Jenkins..."
java -jar jenkins-cli.jar -s "$JENKINS_URL" safe-restart