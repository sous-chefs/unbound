# frozen_string_literal: true

unbound_install 'unbound' do
  install_strategy 'compile'
end

# unbound_configure 'bar' do
#   local_zone 'id' => 'int_example_com',
#              'ns' => [{ 'int.example.com' => '127.0.0.1' }],
#              'host' => [{ 'www.int.example.com' => '10.1.1.200' }]
#   forward_zone 'forward1' => [{ 'forward.example.com' => '10.1.1.201' }],
#                'forward2' => [{ 'forward2.example.com' => ['10.1.1.202', '10.1.1.203'] }],
#                'forward3' => [{ 'forward3.example.com' => 'ns1.none' }]
# end
