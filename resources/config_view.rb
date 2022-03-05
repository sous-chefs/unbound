#
# Cookbook:: unbound
# Resource:: config_view
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

unified_mode true

use 'partials/_config_file'

property :config_file, String,
          default: lazy { "#{config_dir}/view-#{name}.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :zone_name, String,
          default: lazy { name }

property :local_zone, [String, Array],
          coerce: proc { |p| p.to_a }

property :local_data, [String, Array],
          coerce: proc { |p| p.to_a }

property :local_data_ptr, [String, Array],
          coerce: proc { |p| p.to_a }

property :view_first, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

load_current_value do |new_resource|
  current_value_does_not_exist! unless ::File.exist?(new_resource.config_file)

  if ::File.exist?(new_resource.config_file)
    owner ::Etc.getpwuid(::File.stat(new_resource.config_file).uid).name
    group ::Etc.getgrgid(::File.stat(new_resource.config_file).gid).name
    mode ::File.stat(new_resource.config_file).mode.to_s(8)[-4..-1]
  end
end

action_class do
  def do_template_action
    zone_config = {
      'name' => new_resource.zone_name,
      'local-zone' => new_resource.local_zone,
      'local-data' => new_resource.local_data,
      'local-data-ptr' => new_resource.local_data_ptr,
      'view-first' => new_resource.view_first,
    }.compact

    config = {
      'view' => zone_config,
    }

    perform_config_action(config)
  end
end
