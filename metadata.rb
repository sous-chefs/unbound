name             'unbound'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache-2.0'
description      'Manages unbound DNS resolver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.7'
issues_url       'https://github.com/sous-chefs/unbound/issues'
source_url       'https://github.com/sous-chefs/unbound'
chef_version     '>= 12.5' if respond_to?(:chef_version)

%w( debian ubuntu centos redhat scientific oracle amazon ).each do |os|
  supports os
end
