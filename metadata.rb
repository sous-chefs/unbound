name             'unbound'
maintainer       'Drew Blessing'
maintainer_email 'drew@blessing.io'
license          'Apache 2.0'
description      'Manages unbound DNS resolver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
issues_url       'https://github.com/sous-chefs/unbound/issues'
source_url       'https://github.com/sous-chefs/unbound'
chef_version     '>= 12.5' if respond_to?(:chef_version)

supports 'centos'
supports 'ubuntu'

recipe 'unbound::default', 'Installs unbound and sets up configuration files'
recipe 'unbound::chroot', 'Sets up the chroot environment if chroot attribute is enabled'
recipe 'unbound::remote_control', 'Sets up remote control certificates'
