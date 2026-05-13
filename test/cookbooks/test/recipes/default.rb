# frozen_string_literal: true

unbound_package 'unbound'

server_config = {
  verbosity: 1,
  interface: '127.0.0.1',
}

if platform_family?('rhel', 'fedora')
  server_config.merge!(
    'chroot' => '',
    'username' => 'unbound',
    'directory' => '/etc/unbound',
    'pidfile' => '/var/run/unbound/unbound.pid'
  )
end

unbound_config 'unbound' do
  server server_config
  notifies :restart, 'unbound_service[unbound]', :delayed
end

file '/etc/unbound/unbound.conf.d/root-auto-trust-anchor-file.conf' do
  action :delete
end if platform_family?('debian')

unbound_config_forward_zone 'test.zone' do
  forward_addr %w(1.1.1.1 8.8.8.8)
  notifies :restart, 'unbound_service[unbound]', :delayed
end

unbound_config_remote_control 'unbound-remote-control' do
  control_enable false
end

unbound_service 'unbound' do
  action [:enable, :start]
end
