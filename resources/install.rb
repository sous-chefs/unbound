action :install do
  package 'unbound' do
    action :upgrade
  end
end
