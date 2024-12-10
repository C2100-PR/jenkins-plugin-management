#!/bin/bash

# Jenkins Configuration Backup Script
# Usage: ./config_backup.sh <jenkins-home> <backup-dir>

JENKINS_HOME="$1"
BACKUP_DIR="$2"

if [ -z "$JENKINS_HOME" ] || [ -z "$BACKUP_DIR" ]; then
    echo "Usage: $0 <jenkins-home> <backup-dir>"
    exit 1
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_PATH="$BACKUP_DIR/jenkins_backup_$TIMESTAMP"

# Create backup directory
mkdir -p "$BACKUP_PATH"

# Backup essential configurations
cp "$JENKINS_HOME/config.xml" "$BACKUP_PATH/"
cp -r "$JENKINS_HOME/jobs" "$BACKUP_PATH/"
cp -r "$JENKINS_HOME/plugins" "$BACKUP_PATH/"
cp -r "$JENKINS_HOME/secrets" "$BACKUP_PATH/"
cp -r "$JENKINS_HOME/users" "$BACKUP_PATH/"

# Create manifest
echo "Backup created on $(date)" > "$BACKUP_PATH/MANIFEST.txt"
echo "Jenkins Home: $JENKINS_HOME" >> "$BACKUP_PATH/MANIFEST.txt"
echo "\nContents:" >> "$BACKUP_PATH/MANIFEST.txt"
ls -R "$BACKUP_PATH" >> "$BACKUP_PATH/MANIFEST.txt"

# Compress backup
tar -czf "$BACKUP_PATH.tar.gz" -C "$BACKUP_DIR" "jenkins_backup_$TIMESTAMP"
rm -rf "$BACKUP_PATH"

echo "Backup completed: $BACKUP_PATH.tar.gz"
