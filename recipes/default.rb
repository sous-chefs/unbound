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

# Ubuntu doesn't have a conf.d but it's a good pattern so let's make it work
directory '/etc/unbound/conf.d' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/unbound/conf.d/main.conf' do
  source 'main.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[unbound]'
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
      notifies :reload, 'service[unbound]'
    end
  end
end

directory node['unbound']['log_dir'] do
  owner 'unbound'
  group 'unbound'
  mode '0750'
end

service node['unbound']['service_name'] do
  supports status: true, start: true, stop: true, restart: true, reload: true
  action [:start, :enable]
end
