# frozen_string_literal: true

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
          default: lazy { "#{config_dir}/#{name}.conf" },
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
