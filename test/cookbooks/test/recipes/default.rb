include_recipe 'unbound::default'

unbound_config 'unbound' do
  config_file '/etc/unbound/unbound-test.conf'
  config({
    server: {
      verbosity: 1,
      interface: [
        '10.42.0.1',
        '10.42.0.1@853',
        '2001:470:1881::1',
        '2001:470:1881::1@853',
        '127.0.0.1',
        '127.0.0.1@853',
        '::1',
        '::1@853',
      ],
    },
  })
end

unbound_config_forward_zone 'test.zone' do
  forward_addr %w(1.1.1.1 8.8.8.8)
end
