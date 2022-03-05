#
# Cookbook:: unbound
# Resource:: config_dnscrypt
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
          default: lazy { "#{config_dir}/dnscrypt.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :dnscrypt_enable, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnscrypt_port, Integer

property :dnscrypt_provider, [String, Array],
          coerce: proc { |p| p.to_a }

property :dnscrypt_secret_key, String

property :dnscrypt_provider_cert, String

property :dnscrypt_provider_cert_rotated, String

property :dnscrypt_shared_secret_cache_size, String

property :dnscrypt_shared_secret_cache_slabs, Integer

property :dnscrypt_nonce_cache_size, String

property :dnscrypt_nonce_cache_slabs, Integer

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
    dnscrypt_config = {
      'dnscrypt-enable' => new_resource.dnscrypt_enable,
      'dnscrypt-port' => new_resource.dnscrypt_port,
      'dnscrypt-provider' => new_resource.dnscrypt_provider,
      'dnscrypt-secret-key' => new_resource.dnscrypt_secret_key,
      'dnscrypt-provider-cert' => new_resource.dnscrypt_provider_cert,
      'dnscrypt-provider-cert-rotated' => new_resource.dnscrypt_provider_cert_rotated,
      'dnscrypt-shared-secret-cache-size' => new_resource.dnscrypt_shared_secret_cache_size,
      'dnscrypt-shared-secret-cache-slabs' => new_resource.dnscrypt_shared_secret_cache_slabs,
      'dnscrypt-nonce-cache-size' => new_resource.dnscrypt_nonce_cache_size,
      'dnscrypt-nonce-cache-slabs' => new_resource.dnscrypt_nonce_cache_slabs,
    }.compact

    config = {
      'dnscrypt' => dnscrypt_config,
    }

    perform_config_action(config)
  end
end
