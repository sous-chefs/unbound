# Unbound Cookbook

[![Build Status](https://travis-ci.org/sous-chefs/unbound.svg?branch=master)](https://travis-ci.org/sous-chefs/unbound) [![Cookbook Version](https://img.shields.io/cookbook/v/unbound.svg)](https://supermarket.chef.io/cookbooks/unbound)

Installs and manages the unbound DNS server.

* http://unbound.net

## Requirements

### Platform

A platform with unbound available as a native package. The following platforms have unbound packaged, but note that the filesystem locations are not consistent and at this time only Linux + FHS is supported.

* Ubuntu/Debian
* Red Hat/CentOS/Fedora (requires EPEL)
* FreeBSD

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

This project exists thanks to all the people who contribute.
<img src="https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false" /></a>


### Backers

Thank you to all our backers! 🙏 [[Become a backer](https://opencollective.com/sous-chefs#backer)]
<a href="https://opencollective.com/sous-chefs#backers" target="_blank"><img src="https://opencollective.com/sous-chefs/backers.svg?width=890"></a>

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website. [[Become a sponsor](https://opencollective.com/sous-chefs#sponsor)]
<a href="https://opencollective.com/sous-chefs/sponsor/0/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/1/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/2/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/3/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/4/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/5/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/6/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/7/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/8/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/9/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/9/avatar.svg"></a>

## License and Author

Copyright 2011, Joshua Timberman (<cookbooks@housepub.org>)
Copyright 2017, Dan Webb (<dan.webb@damacus.io>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
