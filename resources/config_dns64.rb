#
# Cookbook:: unbound
# Resource:: config_dns64
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
          default: lazy { "#{config_dir}/dns64.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :dns64_prefix, String

property :dns64_synthall, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dns64_ignore_aaaa, String

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
    dns64_config = {
      'dns64-prefix' => new_resource.dns64_prefix,
      'dns64-synthall' => new_resource.dns64_synthall,
      'dns64-ignore-aaaa' => new_resource.dns64_ignore_aaaa,
    }.compact

    config = {
      'server' => dns64_config,
    }

    perform_config_action(config)
  end
end
