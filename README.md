# Jenkins Plugin Management Guide

This repository contains resources and tools for managing Jenkins plugins effectively, including automation scripts and best practices.

## Plugin Management Methods

### 1. Web UI Management
- Navigate to `Manage Jenkins > Plugins`
- Use the Available/Installed tabs
- Install/update/remove plugins through the interface

### 2. CLI Management
Basic plugin installation:
```bash
java -jar jenkins-cli.jar -s http://your-jenkins-url install-plugin PLUGIN_NAME [-deploy] [-restart]
```

Enable plugin:
```bash
java -jar jenkins-cli.jar -s http://your-jenkins-url enable-plugin PLUGIN_NAME [-restart]
```

Disable plugin:
```bash
java -jar jenkins-cli.jar -s http://your-jenkins-url disable-plugin PLUGIN_NAME [-restart] [-strategy STRATEGY]
```

### 3. Manual Installation
```bash
# Copy plugin file to Jenkins
cp plugin.hpi JENKINS_HOME/plugins/
# Rename to .jpi if needed
mv JENKINS_HOME/plugins/plugin.hpi JENKINS_HOME/plugins/plugin.jpi
# Restart Jenkins
systemctl restart jenkins
```

## Scripts and Tools

Check the `scripts/` directory for automation tools:
- Plugin installation automation
- Dependency management
- Version control
- Backup and restore

## Best Practices

1. **Version Control**
   - Keep plugin versions documented
   - Use configuration as code when possible
   - Maintain a plugins.txt file

2. **Testing**
   - Test plugin updates in staging
   - Maintain backup before updates
   - Document compatibility issues

3. **Maintenance**
   - Regular plugin updates
   - Remove unused plugins
   - Monitor plugin dependencies

## Common Issues and Solutions

1. **Plugin Conflicts**
   - Check version compatibility
   - Review dependency tree
   - Consult Jenkins logs

2. **Failed Updates**
   - Verify Jenkins version compatibility
   - Check network connectivity
   - Review update center status

## Contributing

Feel free to contribute by:
1. Opening issues for problems or suggestions
2. Submitting pull requests with improvements
3. Sharing your plugin management scripts

## License

MIT License - See LICENSE file for details