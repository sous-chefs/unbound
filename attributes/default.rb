default['unbound']['interface'] = []
default['unbound']['outgoing_interface'] = nil
default['unbound']['port'] = 53
default['unbound']['num_threads'] = 1
default['unbound']['enable_ipv4'] = true
default['unbound']['enable_ipv6'] = false
default['unbound']['enable_tcp'] = true
default['unbound']['enable_udp'] = true
default['unbound']['access_control'] = { "127.0.0.1/8" => "allow", "0.0.0.0/0" => "refuse" }
default['unbound']['logfile'] =  ""
default['unbound']['use_syslog'] = "yes"

default['unbound']['remote_control']['enable'] = true
default['unbound']['remote_control']['interface'] = "0.0.0.0"
default['unbound']['remote_control']['port'] = "8953"

default['unbound']['stats']['interval'] = 0
default['unbound']['stats']['cumulative'] = "no"
default['unbound']['stats']['extended'] = "no"
default['unbound']['zone_types'] = ['forward']

# /etc/default/unbound settings for Ubuntu (possibly also Debian)
default['unbound']['unbound_enable'] = true
default['unbound']['root_trust_anchor_update'] = true
default['unbound']['root_trust_anchor_file'] = '/var/lib/unbound/root.key'
default['unbound']['resolvconf'] = true
default['unbound']['resolvconf_forwarders'] = false
default['unbound']['daemon_opts'] = '-c /etc/unbound/unbound.conf'

#default['unbound']['dnssec'] - disabled by default, future todo

case node['platform']
when "freebsd"
  default['unbound']['directory'] = "/usr/local//etc/unbound"
  default['unbound']['pidfile'] = "/usr/local/etc/unbound/unbound.pid"
  default['unbound']['bindir'] = "/usr/local/sbin"
else
  default['unbound']['directory'] = "/etc/unbound"
  default['unbound']['pidfile'] = "/var/run/unbound.pid"
  default['unbound']['bindir'] = "/usr/sbin"
end
