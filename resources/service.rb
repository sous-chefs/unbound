#
# Cookbook:: unbound
# Resource:: service
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

property :service_name, String,
          default: 'unbound',
          description: 'The service name to perform actions upon'

property :config_test, [true, false],
          default: true,
          description: 'Perform configuration file test before performing service action'

property :config_test_fail_action, Symbol,
          equal_to: %i(raise log),
          default: :raise,
          description: 'Action to perform upon configuration test failure.'

action_class do
  def perform_config_test
    cmd = shell_out('/usr/sbin/unbound-checkconf')
    cmd.error!
  rescue Mixlib::ShellOut::ShellCommandFailed
    if new_resource.config_test_fail_action.eql?(:log)
      Chef::Log.error("Configuration test failed, #{new_resource.service_name} #{action} action aborted!\n\n" \
                      "Error\n-----\n#{cmd.stderr}")
    else
      raise "Configuration test failed, #{new_resource.service_name} #{action} action aborted!\n\n" \
            "Error\n-----\nAction: #{action}\n#{cmd.stderr}"
    end
  end

  def do_service_action(service_action)
    with_run_context(:root) do
      if %i(start restart reload).include?(service_action)
        if new_resource.config_test
          perform_config_test
          Chef::Log.info("Configuration test passed, creating #{new_resource.service_name} #{new_resource.declared_type} resource with action #{service_action}")
        else
          Chef::Log.info("Configuration test disabled, creating #{new_resource.service_name} #{new_resource.declared_type} resource with action #{service_action}")
        end

        declare_resource(:service, new_resource.service_name) { delayed_action(service_action) }
      else
        declare_resource(:service, new_resource.service_name) { action(service_action) }
      end
    end
  end
end

%i(start stop restart reload enable disable).each { |action_type| action(action_type) { do_service_action(action_type) } }

action :test do
  converge_by('Performing configuration test') { perform_config_test }
end
