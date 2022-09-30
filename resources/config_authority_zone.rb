#
# Cookbook:: unbound
# Resource:: config_authority_zone
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

provides :unbound_config_auth_zone

use 'partials/_config_file'

property :config_file, String,
          default: lazy { "#{config_dir}/authority-zone-#{name}.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :zone_name, String,
          default: lazy { name }

property :primary, [String, Array],
          coerce: proc { |p| Array(p) }

property :master, [String, Array],
          coerce: proc { |p| Array(p) }

property :url, [String, Array],
          coerce: proc { |p| Array(p) }

property :allow_notify, [String, Array],
          coerce: proc { |p| Array(p) }

property :fallback_enabled, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :for_downstream, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :for_upstream, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :zonemd_check, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :zonemd_reject_absence, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :zonefile, String

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
      'primary' => new_resource.primary.dup,
      'master' => new_resource.master.dup,
      'url' => new_resource.url.dup,
      'allow-notify' => new_resource.allow_notify.dup,
      'fallback-enabled' => new_resource.fallback_enabled,
      'for-downstream' => new_resource.for_downstream,
      'for-upstream' => new_resource.for_upstream,
      'zonemd-check' => new_resource.zonemd_check,
      'zonemd-reject-absence' => new_resource.zonemd_reject_absence,
      'zonefile' => new_resource.zonefile,
    }.compact

    config = {
      'auth-zone' => zone_config,
    }

    perform_config_action(config)
  end
end
