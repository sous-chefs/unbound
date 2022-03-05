#
# Cookbook:: unbound
# Resource:: config_dnstap
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
          default: lazy { "#{config_dir}/dnstap.conf" },
          desired_state: false,
          description: 'Set to override unbound configuration file.'

property :dnstap_enable, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_bidirectional, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_socket_path, String

property :dnstap_ip, String

property :dnstap_tls, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_tls_server_name, String

property :dnstap_tls_cert_bundle, String

property :dnstap_tls_client_key_file, String

property :dnstap_tls_client_cert_file, String

property :dnstap_send_identity, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_send_version, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_identity, String

property :dnstap_version, String

property :dnstap_log_resolver_query_messages, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_log_resolver_response_messages, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_log_client_query_messages, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_log_client_response_messages, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_log_forwarder_query_messages, [String, true, false],
          coerce: proc { |p| unbound_yes_no?(p) }

property :dnstap_log_forwarder_response_messages, [String, true, false],
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
    zone_config = {
      'dnstap-enable' => new_resource.dnstap_enable,
      'dnstap-bidirectional' => new_resource.dnstap_bidirectional,
      'dnstap-socket-path' => new_resource.dnstap_socket_path,
      'dnstap-ip' => new_resource.dnstap_ip,
      'dnstap-tls' => new_resource.dnstap_tls,
      'dnstap-tls-server-name' => new_resource.dnstap_tls_server_name,
      'dnstap-tls-cert-bundle' => new_resource.dnstap_tls_cert_bundle,
      'dnstap-tls-client-key-file' => new_resource.dnstap_tls_client_key_file,
      'dnstap-tls-client-cert-file' => new_resource.dnstap_tls_client_cert_file,
      'dnstap-send-identity' => new_resource.dnstap_send_identity,
      'dnstap-send-version' => new_resource.dnstap_send_version,
      'dnstap-identity' => new_resource.dnstap_identity,
      'dnstap-version' => new_resource.dnstap_version,
      'dnstap-log-resolver-query-messages' => new_resource.dnstap_log_resolver_query_messages,
      'dnstap-log-resolver-response-messages' => new_resource.dnstap_log_resolver_response_messages,
      'dnstap-log-client-query-messages' => new_resource.dnstap_log_client_query_messages,
      'dnstap-log-client-response-messages' => new_resource.dnstap_log_client_response_messages,
      'dnstap-log-forwarder-query-messages' => new_resource.dnstap_log_forwarder_query_messages,
      'dnstap-log-forwarder-response-messages' => new_resource.dnstap_log_forwarder_response_messages,
    }.compact

    config = {
      'dnstap' => zone_config,
    }

    if new_resource.sort
      deepsort?
      config.deep_sort!
    end

    perform_config_action
  end
end
