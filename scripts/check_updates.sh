#!/bin/bash

# Jenkins Plugin Update Checker
# Usage: ./check_updates.sh <jenkins-url>

JENKINS_URL="$1"

if [ -z "$JENKINS_URL" ]; then
    echo "Usage: $0 <jenkins-url>"
    exit 1
fi

# Download jenkins-cli.jar if not present
if [ ! -f jenkins-cli.jar ]; then
    wget "$JENKINS_URL/jnlpJars/jenkins-cli.jar"
fi

# List installed plugins and their versions
java -jar jenkins-cli.jar -s "$JENKINS_URL" list-plugins | while read line; do
    if [[ $line =~ .*\(.*\) ]]; then
        echo "Update available: $line"
    fi
done