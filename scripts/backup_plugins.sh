#!/bin/bash

# Jenkins Plugin Backup Script
# Usage: ./backup_plugins.sh <jenkins-home-dir> <backup-dir>

JENKINS_HOME="$1"
BACKUP_DIR="$2"

if [ -z "$JENKINS_HOME" ] || [ -z "$BACKUP_DIR" ]; then
    echo "Usage: $0 <jenkins-home-dir> <backup-dir>"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create timestamp for backup
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create plugins list
find "$JENKINS_HOME/plugins" -name "*.jpi" -o -name "*.hpi" | while read plugin; do
    basename "$plugin" | sed 's/\.\(jpi\|hpi\)$//' >> "$BACKUP_DIR/plugins_$TIMESTAMP.txt"
done

# Copy plugin files
cp -r "$JENKINS_HOME/plugins" "$BACKUP_DIR/plugins_$TIMESTAMP"

echo "Backup completed: $BACKUP_DIR/plugins_$TIMESTAMP"
echo "Plugin list saved: $BACKUP_DIR/plugins_$TIMESTAMP.txt"