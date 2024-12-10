# Usage Guide for Jenkins Plugin Management Scripts

## Installation Script (install_plugins.sh)

```bash
# Install plugins from a list
./install_plugins.sh http://your-jenkins-url plugins.txt

# Example plugins.txt format:
git:latest
blue-ocean:1.25.3
workflow-aggregator
```

## Backup Script (backup_plugins.sh)

```bash
# Backup all plugins
./backup_plugins.sh /var/lib/jenkins /path/to/backup/dir

# The script will create:
# - A timestamped directory with plugin files
# - A text file listing all plugins and versions
```

## Update Checker (check_updates.sh)

```bash
# Check for available updates
./check_updates.sh http://your-jenkins-url

# Output format:
# plugin-name (current-version) -> new-version
```

## Dependency Checker (plugin_dependency_checker.sh)

```bash
# Check dependencies for a specific plugin
./plugin_dependency_checker.sh http://your-jenkins-url pipeline-model-definition
```

## Bulk Update Script (bulk_plugin_update.sh)

```bash
# Update all plugins at once
./bulk_plugin_update.sh http://your-jenkins-url

# Update plugins one at a time (safer)
./bulk_plugin_update.sh http://your-jenkins-url --safe
```

## Best Practices

1. Always run backup before updates
2. Test updates in staging environment first
3. Use --safe flag for critical production systems
4. Keep plugins.txt updated with current versions
5. Monitor Jenkins logs during/after updates
