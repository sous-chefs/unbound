#
# Cookbook:: unbound
# Resource:: config
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

provides :unbound_configure
provides :unbound_config

use 'partials/_config_file'

property :config_file, String,
          default: lazy { "#{config_dir}/unbound.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :include, [String, Array],
          default: lazy { default_includes_dir },
          coerce: proc { |p| p.to_a }

property :server, Hash,
          default: {},
          description: 'Server configuration as a Hash'

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
      'include' => new_resource.include,
      'server' => new_resource.server,
    }.compact

    if new_resource.sort
      deepsort?
      config.deep_sort!
    end

    perform_config_action(config)
  end
end
