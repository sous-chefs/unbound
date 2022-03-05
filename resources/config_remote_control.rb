#
# Cookbook:: unbound
# Resource:: config_remote_control
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
          default: lazy { "#{config_dir}/remote-control.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :control_enable, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :control_interface, [String, Array],
          coerce: proc { |p| p.to_a }

property :control_port, Integer

property :control_use_cert, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :control_key_file, String

property :control_cert_file, String

property :server, String

property :server_cert_file, String

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

    remote_control = {
      'control-enable' => new_resource.control_enable,
      'control-interface' => new_resource.control_interface,
      'control-port' => new_resource.control_port,
      'control-use-cert' => new_resource.control_use_cert,
      'control-key-file' => new_resource.control_key_file,
      'control-cert-file' => new_resource.control_cert_file,
      'server-key-file' => new_resource.server_key_file,
      'server-cert-file' => new_resource.server_cert_file,
    }.compact

    config = {
      'remote-control' => remote_control,
    }

    if new_resource.sort
      deepsort?
      config.deep_sort!
    end

    perform_config_action
  end
end
