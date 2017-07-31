property :name, String, name_property: true

action :install do
  package 'unbound' do
    action :upgrade
  end
end
