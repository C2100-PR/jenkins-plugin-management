#!/bin/bash

# Jenkins Plugin Dependency Checker
# Usage: ./plugin_dependency_checker.sh <jenkins-url> <plugin-name>

JENKINS_URL="$1"
PLUGIN_NAME="$2"

if [ -z "$JENKINS_URL" ] || [ -z "$PLUGIN_NAME" ]; then
    echo "Usage: $0 <jenkins-url> <plugin-name>"
    exit 1
fi

# Download jenkins-cli.jar if not present
if [ ! -f jenkins-cli.jar ]; then
    wget "$JENKINS_URL/jnlpJars/jenkins-cli.jar"
fi

# Get plugin dependencies
echo "Checking dependencies for $PLUGIN_NAME..."
java -jar jenkins-cli.jar -s "$JENKINS_URL" list-plugins | grep -B1 "$PLUGIN_NAME" | grep -v "$PLUGIN_NAME" | while read line; do
    if [[ ! -z "$line" ]]; then
        echo "Dependency: $line"
    fi
done
