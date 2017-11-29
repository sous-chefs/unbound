unbound_install 'unbound'

unbound_configure 'config' do
  local_zone 'id' => 'int_example_com',
             'ns' => [{ 'int.example.com' => '127.0.0.1' }],
             'host' => [{ 'www.int.example.com' => '10.1.1.200' }]
  forward_zone 'forward1' => [{ 'forward.example.com' => '10.1.1.201' }],
               'forward2' => [{ 'forward2.example.com' => ['10.1.1.202', '10.1.1.203'] }],
               'forward3' => [{ 'forward3.example.com' => 'ns1.none' }]
  num_threads 2
  enable_ipv4 true
  enable_ipv6 true
  enable_tcp true
  enable_udp true
  access_control '127.0.0.1/8' => 'allow',
                 '0.0.0.0/0' => 'refuse'
  use_syslog 'yes'
  stats_interval 1
  stats_cumulative 'yes'
  stats_extended 'yes'
end
