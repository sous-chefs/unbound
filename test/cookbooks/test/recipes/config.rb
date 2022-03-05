unbound_config 'unbound' do
  server({
    verbosity: 1,
    interface: [
      '127.0.0.1',
      '127.0.0.1@853',
    ],
  })
  notifies :restart, 'unbound_service[unbound]', :delayed
end

unbound_config_forward_zone 'test.zone' do
  forward_addr %w(1.1.1.1 8.8.8.8)
  notifies :restart, 'unbound_service[unbound]', :delayed
end
