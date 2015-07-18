require 'provider_spec_helper'

describe UnboundConfig::Provider do
  step_into(:unbound_config)
  recipe do
    unbound_config '/etc/unbound/conf.d/main.conf' do
      action :create
      config(
        'server' => {
          'logfile' => '/var/log/unbound/unbound.log'
        }
      )
      provider UnboundConfig::Provider
    end
  end

  # Works
  it { is_expected.to render_file('/etc/unbound/conf.d/main.conf') }

  # Doesn't work
  # Throws:
  # UnboundConfig::Provider should render file "/etc/unbound/conf.d/main.conf" with content "foo"
  # Failure/Error: it { is_expected.to render_file('/etc/unbound/conf.d/main.conf').with_content('foo') }
  # Chef::Exceptions::CookbookNotFound:
  #   Cookbook  not found. If you're loading  from another cookbook, make sure you configure the dependency in your metadata
  #    ./spec/unit/provider/unbound_config_spec.rb:23:in `block (2 levels) in <top (required)>'
  #
  it { is_expected.to render_file('/etc/unbound/conf.d/main.conf').with_content('foo') }
end
