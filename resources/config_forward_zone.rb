#
# Cookbook:: unbound
# Resource:: config_forward_zone
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
          default: lazy { "#{config_dir}/forward-zone-#{name}.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :zone_name, String,
          default: lazy { name }

property :forward_host, [String, Array],
          coerce: proc { |p| p.to_a }

property :forward_addr, [String, Array],
          coerce: proc { |p| p.to_a }

property :forward_first, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :forward_tls_upstream, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :forward_ssl_upstream, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :forward_tcp_upstream, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :forward_no_cache, [String, true, false],
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
    chef_gem('deepsort') { compile_time true } if Gem::Specification.find_by_name('deepsort').nil?
    require 'deepsort'

    zone_config = {
      'name' => new_resource.zone_name,
      'forward-host' => new_resource.forward_host,
      'forward-addr' => new_resource.forward_addr,
      'forward-first' => new_resource.forward_first,
      'forward-tls-upstream' => new_resource.forward_tls_upstream,
      'forward-ssl-upstream' => new_resource.forward_ssl_upstream,
      'forward-tcp-upstream' => new_resource.forward_tcp_upstream,
      'forward-no-cache' => new_resource.forward_no_cache,
    }.compact

    config = {
      'forward-zone' => zone_config,
    }

    if new_resource.sort
      deepsort?
      config.deep_sort!
    end

    perform_config_action(config)
  end
end
