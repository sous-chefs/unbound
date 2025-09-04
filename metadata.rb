name             'unbound'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache-2.0'
description      'Manages unbound DNS resolver'
version          '3.0.5'
issues_url       'https://github.com/sous-chefs/unbound/issues'
source_url       'https://github.com/sous-chefs/unbound'
chef_version     '>= 16'

%w(debian ubuntu centos redhat scientific oracle amazon).each do |os|
  supports os
end
