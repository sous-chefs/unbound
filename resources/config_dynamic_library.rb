#
# Cookbook:: unbound
# Resource:: config_dynamic_library
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
          default: lazy { "#{config_dir}/dyn-lib-#{name}.conf" },
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

property :dynlib_file, [String, Array],
          coerce: proc { |p| p.to_a }

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

    config = {
      'dynlib-file' => new_resource.dynlib_file,
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

      variables(content: config, separator: ':')

      action new_resource.action
    end
  end
end

%i(create create_if_missing delete).each { |action_type| action(action_type) { do_template_action } }
