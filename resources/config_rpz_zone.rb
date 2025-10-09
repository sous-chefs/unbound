#
# Cookbook:: unbound
# Resource:: config_rpz_zone
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
          default: lazy { "#{config_dir}/rpz-zone-#{name}.conf" },
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

property :zonefile, String

property :rpz_action_override, [String, Symbol],
          equal_to: %w(nxdomain nodata passthru drop disabled cname),
          coerce: proc(&:to_s)

property :rpz_cname_override, String

property :rpz_log, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :rpz_log_name, String

property :rpz_signal_nxdomain_ra, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :for_downstream, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :tags, [String, Array],
          coerce: proc { |p| "\"#{p.to_a.join(' ')} \"" }

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
      'zonefile' => new_resource.zonefile,
      'rpz-action-override' => new_resource.rpz_action_override,
      'rpz-cname-override' => new_resource.rpz_cname_override,
      'rpz-log' => new_resource.rpz_log,
      'rpz-log-name' => new_resource.rpz_log_name,
      'rpz-signal-nxfomain-ra' => new_resource.rpz_signal_nxdomain_ra,
      'for-downstream' => new_resource.for_downstream,
      'tags' => new_resource.tags.dup,
    }.compact

    config = {
      'rpz' => zone_config,
    }

    perform_config_action(config)
  end
end
