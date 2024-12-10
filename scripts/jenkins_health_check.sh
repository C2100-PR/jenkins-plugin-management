#!/bin/bash

# Jenkins Health Check Script
# Usage: ./jenkins_health_check.sh <jenkins-url>

JENKINS_URL="$1"

if [ -z "$JENKINS_URL" ]; then
    echo "Usage: $0 <jenkins-url>"
    exit 1
fi

echo "Running Jenkins Health Check..."

# Check Jenkins is responsive
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $JENKINS_URL)
if [ $HTTP_CODE -eq 200 ]; then
    echo "✅ Jenkins is responsive (HTTP $HTTP_CODE)"
else
    echo "❌ Jenkins is not responding properly (HTTP $HTTP_CODE)"
fi

# Check disk space
JENKINS_HOME="/var/lib/jenkins"
DISK_USAGE=$(df -h $JENKINS_HOME | awk 'NR==2 {print $5}' | sed 's/%//')
if [ $DISK_USAGE -gt 90 ]; then
    echo "❌ Disk space critical: ${DISK_USAGE}% used"
else
    echo "✅ Disk space OK: ${DISK_USAGE}% used"
fi

# Check plugin updates
if [ -f jenkins-cli.jar ]; then
    UPDATE_COUNT=$(java -jar jenkins-cli.jar -s $JENKINS_URL list-plugins | grep -e ")$" | wc -l)
    echo "ℹ️ $UPDATE_COUNT plugins have updates available"
fi

# Check executor status
EXECUTOR_COUNT=$(curl -s $JENKINS_URL/computer/api/json | grep -o '"executors":\[[^]]*\]' | grep -o ':' | wc -l)
BUSY_EXECUTORS=$(curl -s $JENKINS_URL/computer/api/json | grep -o '"inUse":true' | wc -l)
echo "ℹ️ $BUSY_EXECUTORS/$EXECUTOR_COUNT executors busy"
