#
# Cookbook:: unbound
# Resource:: _config_file
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

include Unbound::Cookbook::Helpers

property :owner, String,
          default: 'root',
          description: 'Set to override config file owner. Defaults to root.'

property :group, String,
          default: 'unbound',
          description: 'Set to override config file group. Defaults to unbound.'

property :mode, String,
          default: '0640',
          description: 'Set to override config file mode. Defaults to 0640.'

property :directory_mode, String,
          default: '0750',
          description: 'Set to override config directory mode. Defaults to 0750.'

property :config_dir, String,
          default: lazy { default_config_dir },
          desired_state: false,
          description: 'Set to override unbound configuration directory.'

property :config_file, String,
          default: lazy { "#{config_dir}/unbound.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :cookbook, String,
          default: 'unbound',
          desired_state: false,
          description: 'Template source cookbook for the unbound configuration file.'

property :template, String,
          default: 'unbound.conf.erb',
          desired_state: false,
          description: 'Template source file for the unbound configuration file.'

property :sensitive, [true, false],
          desired_state: false,
          description: 'Ensure that sensitive resource data is not output by Chef Infra Client.'

property :sort, [true, false],
          default: true

property :template_properties, Hash,
          default: {}

property :extra_options, Hash,
          default: {}

action_class do
  def deepsort?
    return if defined?(DeepSort)

    begin
      Gem::Specification.find_by_name('deepsort')
    rescue Gem::MissingSpecError
      declare_resource(:chef_gem, 'deepsort')
    end

    require 'deepsort'

    true
  end

  def perform_config_action(config)
    directory new_resource.config_dir do
      owner new_resource.owner
      group new_resource.group
      mode new_resource.directory_mode

      recursive true

      action new_resource.action.eql?(:delete) ? :delete : :create
    end

    config.merge!(new_resource.extra_options.dup) unless new_resource.extra_options.empty?

    if new_resource.sort
      deepsort?
      config.deep_sort!
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
