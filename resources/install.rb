property :install_strategy, String, equal_to: %w(package compile), default: 'package'
property :source_version, String, default: '1.8.0'
property :source_url, String, default: lazy { "https://nlnetlabs.nl/downloads/unbound/unbound-#{source_version}.tar.gz" }
property :user, String, default: 'unbound'

action :install do
  if new_resource.install_strategy == 'compile'
    package %w( openssl openssl-devel expat-devel )

    build_essential 'compilation tools'

    remote_file 'unbound source file' do
      path ::File.join(Chef::Config[:file_cache_path], "unbound-#{new_resource.source_version}.tar.gz")
      source new_resource.source_url
      action :create
      notifies :run, 'bash[compile]', :immediately
    end

    bash 'compile' do
      cwd Chef::Config[:file_cache_path]
      code <<-EOH
        tar xzf unbound-#{new_resource.source_version}.tar.gz
        cd unbound-#{new_resource.source_version}
        ./configure
        make
        make install
      EOH
      action :nothing
    end

    package 'unbound'

    cookbook_file '/etc/init.d/unbound' do
      source 'unbound.service'
      cookbook 'unbound'
      owner 'root'
      group 'root'
      mode '0755'
      action :create
    end

  else
    package 'unbound' do
      action :upgrade
    end
  end
end
