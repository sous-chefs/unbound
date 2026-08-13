# frozen_string_literal: true

name             'unbound'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache-2.0'
description      'Provides custom resources to install, configure, and manage Unbound DNS resolver'
version          '4.0.0'
issues_url       'https://github.com/sous-chefs/unbound/issues'
source_url       'https://github.com/sous-chefs/unbound'
chef_version     '>= 16'

gem 'deepsort'

supports 'almalinux', '>= 8.0'
supports 'amazon', '>= 2023.0'
supports 'centos_stream', '>= 9.0'
supports 'debian', '>= 13.0'
supports 'fedora'
supports 'oracle', '>= 8.0'
supports 'redhat', '>= 8.0'
supports 'rocky', '>= 8.0'
supports 'ubuntu', '>= 22.04'
