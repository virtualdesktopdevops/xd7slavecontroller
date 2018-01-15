# Changelog - xd7slavecontroller #

## Unreleased
- **BREAKING CHANGE** : Migrated puppet example code in README.md to future parser syntax (4.x). Impact on parameters refering to remote locations (file shares) which have to be prefixed with \\\\ instead of the classical \\. This is because of Puppet >= 4.x parsing \\ as a single \ in single-quoted strings. Use parser = future in puppet 3.x /etc/puppet/puppet.conf to use this new configuration in your Puppet 3.x and prepare Puppet 4.x migration.

## Version 1.0.0
- Initial release
