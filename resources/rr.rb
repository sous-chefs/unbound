#
# Cookbook Name:: unbound
# Resource:: rr
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
property :fqdn,     kind_of: String, name_attribute: true
property :ip,       kind_of: String, required: true
property :type,     kind_of: String, default: 'host'
property :cwd,      kind_of: String
property :exists,   kind_of: NilClass, default: nil

action :add do
end
