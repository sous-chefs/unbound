# Unbound Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/unbound.svg)](https://supermarket.chef.io/cookbooks/unbound)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/unbound/master.svg)](https://circleci.com/gh/sous-chefs/unbound)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs and manages the unbound DNS server.

- [http://unbound.net](http://unbound.net)

## Requirements

### Platform

A platform with unbound available as a native package. The following platforms have unbound packaged, but note that the filesystem locations are not consistent and at this time only Linux + FHS is supported.

- Ubuntu/Debian
- Red Hat/CentOS/Fedora (requires EPEL)
- FreeBSD

### Chef

- Chef 12.7+

## Resources

### unbound_install

Install unbound from package.

### unbound_configure

Configures:

- unbound.conf
- forward-zone.conf
- local-zone.conf
- stub-zone.conf

For example usage see `test/fixtures/cookbooks/test/recipes/configure.rb`

### unbound.conf

The main configuration file for unbound. Many settings in the template are controlled via properties on the `unbound_configure` resource. The file is located in the location specified in the `dir` property.

### local-zone.conf

Set up local network resolver configuration with local-zone.conf.

### stub-zone.conf

Edit the stub-zone.erb template to create a stub zone configuration.

### forward-zone.conf

Edit the forward-zone.erb template to create a forward zone configuration.

## Recipes

### default

Installs and configures unbound using defaults.

This example recipe will load the local zone data from a data bag if present, otherwise it will attempt to use `node['dns']['domain']` attribute. The various templates can be edited as required by the local user.

If this does not meet your needs use the `unbound_configure` resource directly.

### chroot (TODO)

The intention of this recipe will be to setup the chroot environment if the chroot setting is enabled. However it is not yet complete.

### `remote_control` (TODO)

Sets up remote control certificate attributes using the unbound configuration directory. Also creates the config file for remote-control settings and creates the certificates with unbound-control-setup.

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
