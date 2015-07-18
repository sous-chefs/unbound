#
# Cookbook Name:: unbound
# Recipe:: default
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

include_recipe 'unbound::_install'

unbound_config '/etc/unbound/conf.d/main.conf' do
  action :create
  config node['unbound']['config']
  notifies :restart, 'service[unbound]'
end

%w(stub forward).each do |type|
  node['unbound']["#{type}_zones"].each do |zone|
    # Copy the zone so we can modify it and not affect the node object
    zone = zone.dup

    template "/etc/unbound/conf.d/#{type}_#{zone['name']}.conf" do
      source 'zone.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        name: zone.delete('name'),
        type: type,
        config: zone
      )
      notifies :restart, 'service[unbound]'
    end
  end
end

directory node['unbound']['log_dir'] do
  owner 'unbound'
  group 'unbound'
  mode '0750'
end

include_recipe 'unbound::_service'
