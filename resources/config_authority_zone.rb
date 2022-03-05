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

use 'partials/_config_file'

property :config_file, String,
          default: lazy { "#{config_dir}/authority-zone-#{name}.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :zone_name, String,
          default: lazy { name }

property :primary, [String, Array],
          coerce: proc { |p| p.to_a }

property :master, [String, Array],
          coerce: proc { |p| p.to_a }

property :url, [String, Array],
          coerce: proc { |p| p.to_a }

property :allow_notify, [String, Array],
          coerce: proc { |p| p.to_a }

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
    chef_gem('deepsort') { compile_time true } if Gem::Specification.find_by_name('deepsort').nil?
    require 'deepsort'

    zone_config = {
      'name' => new_resource.zone_name,
      'primary' => new_resource.primary,
      'master' => new_resource.master,
      'url' => new_resource.url,
      'allow-notify' => new_resource.allow_notify,
      'for-downstream' => new_resource.for_downstream,
      'for-upstream' => new_resource.for_upstream,
      'zonemd-check' => new_resource.zonemd_check,
      'zonemd-reject-absence' => new_resource.zonemd_reject_absense,
      'zonefile' => new_resource.zonefile,
    }.compact

    config = {
      'authority-zone' => zone_config,
    }
    config.deep_sort! if new_resource.sort

    directory new_resource.config_dir do
      owner new_resource.owner
      group new_resource.group
      mode new_resource.directory_mode

      recursive true

      action new_resource.action.eql?(:delete) ? :delete : :create
    end

    template new_resource.config_file do
      cookbook new_resource.cookbook
      source new_resource.template

      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode
      sensitive new_resource.sensitive

      helpers(Unbound::Cookbook::TemplateHelpers)

      variables(content: config)

      action new_resource.action
    end
  end
end

%i(create create_if_missing delete).each { |action_type| action(action_type) { do_template_action } }
