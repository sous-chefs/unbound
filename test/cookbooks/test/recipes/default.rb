include_recipe 'unbound::default'

unbound_service 'unbound' do
  action :enable
  delayed_action :start
end
