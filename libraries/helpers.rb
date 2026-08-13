# frozen_string_literal: true
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
        when 'amazon', 'rhel', 'fedora'
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

      def perform_config_action(config)
        resource_action = config_resource_action

        if %i(create create_if_missing).include?(resource_action)
          directory new_resource.config_dir do
            owner new_resource.owner
            group new_resource.group
            mode new_resource.directory_mode
            recursive true
            action :create
          end
        end

        config.merge!(new_resource.extra_options.dup) unless new_resource.extra_options.empty?
        config = normalize_config_keys(config)

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
          action resource_action
        end
      end

      def config_resource_action
        Array(new_resource.action).first
      end

      def normalize_config_keys(config)
        case config
        when Hash
          config.each_with_object({}) do |(key, value), normalized|
            normalized[key.to_s] = normalize_config_keys(value)
          end
        when Array
          config.map { |value| normalize_config_keys(value) }
        else
          config
        end
      end
    end
  end
end
