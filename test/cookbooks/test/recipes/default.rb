include_recipe 'unbound::default'

unbound_config 'unbound' do
  config_file '/etc/unbound/unbound-test.conf'
end
