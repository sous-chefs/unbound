#
# Cookbook Name:: unbound
# Recipe:: _install
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel'
  include_recipe 'yum-epel' if node['unbound']['manage_package_repo']
end

package node['unbound']['package_name'] do
  action node['unbound']['package_action']
end

# Ubuntu doesn't have a conf.d but it's a good pattern so let's make it work
directory '/etc/unbound/conf.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

unbound_config '/etc/unbound/unbound.conf' do
  action :insert
  config 'include' => '/etc/unbound/conf.d/*.conf'
  notifies :restart, 'service[unbound]'
end


