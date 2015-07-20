#<> The name of the package to install
default['unbound']['package_name'] = 'unbound'
#<> Install or upgrade the package
default['unbound']['package_action'] = :upgrade
#<> The name of the service to manage
default['unbound']['service_name'] = 'unbound'
#<> Manage the yum/apt repository definition
default['unbound']['manage_package_repo'] = true

#<
# Array of stub zones.
# ```
# [
#   {
#     "name"       => "example.com",
#     "stub-addr"  => "192.0.2.68",
#     "stub-prime" => "no"
#   }
# }
# ```
#>
default['unbound']['stub_zones'] = {}

#<
# Array of forward zones
# ```
# [
#   {
#     "name"         => "example.com",
#     "forward-addr" => "192.0.2.68",
#     "forward-host" => "fwd.example.com"
#   }
# ]
# ```
#>
default['unbound']['forward_zones'] = {}

#<> The log directory to manage
default['unbound']['log_dir'] = '/var/log/unbound'

#<> Raw configuration hash.
default['unbound']['config'] = {}

#<
# Configure a log file by default. May be overwritten depending
# on how the user sets config hash.
# TODO: Note in README
#>
default['unbound']['config']['server']['logfile'] =
 '/var/log/unbound/unbound.log'
