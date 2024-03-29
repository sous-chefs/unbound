#
# Cookbook:: unbound
# Library:: helpers
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

module Unbound
  module Cookbook
    module Helpers
      def default_config_dir
        return '/etc/unbound' if %i(unbound_config unbound_configure unbound_config_server).include?(declared_type)

        return '/etc/unbound/unbound.conf.d' if platform?('debian', 'ubuntu')

        case declared_type
        when :unbound_config_local
          '/etc/unbound/local.d'
        when :unbound_config_key
          '/etc/unbound/keys.d'
        else
          '/etc/unbound/conf.d'
        end
      end

      def default_includes_dir
        case node['platform_family']
        when 'rhel', 'fedora'
          %w(/etc/unbound/conf.d/*.conf /etc/unbound/local.d/*.conf)
        when 'debian'
          %w(/etc/unbound/unbound.conf.d/*.conf)
        else
          raise "Unsupported platform family #{node['platform_family']}"
        end
      end

      def unbound_yes_no?(value)
        case value
        when true
          'yes'
        when false
          'no'
        when 'yes', 'YES', 'no', 'NO'
          value.downcase
        end
      end
    end
  end
end
