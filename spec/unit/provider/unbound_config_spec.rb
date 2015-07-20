require 'provider_spec_helper'

describe UnboundConfig::Provider do
  context 'when managing the main config file' do
    step_into(:unbound_config)
    recipe do
      unbound_config '/etc/unbound/conf.d/main.conf' do
        action :create
        config(
          'server'          => {
            'logfile' => '/var/log/dns/unbound.log',
            'access-control'  => [
              '10.0.0.0/24 allow',
              '172.31.0.0/24 allow'
            ],
            'interface' => '0.0.0.0'
          },
          'include'         => '/etc/unbound/other.d/*.conf',
        )
      end
    end

    it do
      is_expected.to(
        render_file('/etc/unbound/conf.d/main.conf')
          .with_content(<<EOS
server:
  access-control: 10.0.0.0/24 allow
  access-control: 172.31.0.0/24 allow
  interface: 0.0.0.0
  logfile: /var/log/dns/unbound.log
include: /etc/unbound/other.d/*.conf
EOS
          )
      )
    end
  end
end
