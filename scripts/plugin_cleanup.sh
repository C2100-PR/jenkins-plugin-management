#!/bin/bash

# Jenkins Plugin Cleanup Script
# Usage: ./plugin_cleanup.sh <jenkins-url>

JENKINS_URL="$1"

if [ -z "$JENKINS_URL" ]; then
    echo "Usage: $0 <jenkins-url>"
    exit 1
fi

# Download jenkins-cli.jar if needed
if [ ! -f jenkins-cli.jar ]; then
    wget "$JENKINS_URL/jnlpJars/jenkins-cli.jar"
fi

# Get list of installed plugins
echo "Analyzing plugin usage..."
INSTALLED_PLUGINS=$(java -jar jenkins-cli.jar -s $JENKINS_URL list-plugins | awk '{print $1}')

# Check each plugin's usage
for plugin in $INSTALLED_PLUGINS; do
    # Check if plugin is a dependency for others
    DEPENDENT_PLUGINS=$(java -jar jenkins-cli.jar -s $JENKINS_URL list-plugins | grep "$plugin" | grep -v "^$plugin")
    
    if [ -z "$DEPENDENT_PLUGINS" ]; then
        echo "Plugin $plugin has no dependencies and might be removable"
    fi
done
