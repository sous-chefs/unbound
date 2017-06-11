#
# Cookbook Name:: unbound
# Recipe:: default
#
# Copyright 2011, Joshua Timberman
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

unbound_install 'unbound'

unbound_configure 'bar' do
  begin
    local_zone data_bag_item('dns', node['dns']['domain'].tr('.', '_'))
  rescue
    local_zone node['dns']['domain']
  end

  begin
    forward_zone data_bag_item('dns', node['dns']['forward_zone'].tr('.', '_'))
  rescue
    forward_zone node['dns']['forward_zone']
  end
end
