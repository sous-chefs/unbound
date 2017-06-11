property :name, String, name_property: true
property :local_zone, [Hash, Array]
property :forward_zone, [Hash, Array]
property :root_group, String, default: lazy {
  case node['platform_family']
  when 'freebsd'
    'wheel'
  else
    'root'
  end
}
property :dir, String, default: lazy {
  case node['platform_family']
  when 'freebsd'
    '/usr/local/etc/unbound'
  else
    '/etc/unbound'
  end
}
# Template Variables
property :interface, Array, default: lazy { [node['ipaddress']] }
property :outgoing_interface, String
property :port, Integer, default: 53
property :num_threads, Integer, default: 1
property :enable_ipv4, [true, false], default: true
property :enable_ipv6, [true, false], default: false
property :enable_tcp, [true, false], default: true
property :enable_udp, [true, false], default: true
property :access_control, [Hash, Array], default: { '127.0.0.1/8' => 'allow', '0.0.0.0/0' => 'refuse' }
property :logfile, String
property :use_syslog, String, equal_to: %w(yes no), default: 'yes'
property :stats_interval, Integer, default: 0
property :stats_cumulative, String, equal_to: %w(yes no), default: 'no'
property :stats_extended, String, equal_to: %w(yes no), default: 'no'
property :chroot, String
property :pid_file, String, default: lazy {
  case node['platform']
  when 'freebsd'
    '/usr/local/etc/unbound/unbound.pid'
  else
    '/var/run/unbound.pid'
  end
}
property :bindir, String, default: lazy {
  case node['platform']
  when 'freebsd'
    '/usr/local/sbin'
  else
    '/usr/sbin'
  end
}

action :create do
  template "#{new_resource.dir}/unbound.conf" do
    source 'unbound.conf.erb'
    cookbook 'unbound'
    mode 0644
    owner 'root'
    group root_group
    variables(
      interface: new_resource.interface,
      access_control: new_resource.access_control,
      stats_interval: new_resource.stats_interval,
      stats_cumulative: new_resource.stats_cumulative,
      stats_extended: new_resource.stats_extended,
      num_threads: new_resource.num_threads,
      port: new_resource.port,
      dir: new_resource.dir,
      outgoing_interface: new_resource.outgoing_interface,
      enable_udp: new_resource.enable_udp,
      enable_tcp: new_resource.enable_tcp,
      enable_ipv4: new_resource.enable_ipv4,
      enable_ipv6: new_resource.enable_ipv6,
      chroot: new_resource.chroot,
      logfile: new_resource.logfile,
      use_syslog: new_resource.use_syslog,
      pid_file: new_resource.pid_file
    )
    notifies :restart, 'service[unbound]', :delayed
  end

  template "#{new_resource.dir}/unbound.conf.d/stub-zone.conf" do
    source 'stub-zone.conf.erb'
    cookbook 'unbound'
    mode 0644
    owner 'root'
    group root_group
    notifies :restart, 'service[unbound]', :delayed
  end

  template "#{new_resource.dir}/unbound.conf.d/local-zone.conf" do
    source 'local-zone.conf.erb'
    cookbook 'unbound'
    mode 0644
    owner 'root'
    group root_group
    variables(local_zone: new_resource.local_zone)
    notifies :restart, 'service[unbound]', :delayed
  end

  template "#{new_resource.dir}/unbound.conf.d/forward-zone.conf" do
    source 'forward-zone.conf.erb'
    cookbook 'unbound'
    mode 0644
    owner 'root'
    group root_group
    variables(forward_zone: new_resource.forward_zone)
    notifies :restart, 'service[unbound]', :delayed
  end

  service 'unbound' do
    case node['platform_family']
    when %w(centos redhat scientific oracle freebsd amazon)
      supports status: true, restart: true, reload: true
    when 'debian'
      supports restart: true
    else
      supports restart: true
    end

    action [:enable, :start]
  end
end
