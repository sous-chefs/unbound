# Migrating to Custom Resources

This release removes the legacy recipe API. The cookbook now exposes only custom resources.

## What Changed

* `recipes/default.rb` was removed.
* Node attributes are not used for configuration.
* `Berksfile` was replaced by `Policyfile.rb`.
* Test cookbook recipes now show the supported resource-only entrypoint.

## Before

```ruby
include_recipe 'unbound::default'
```

## After

```ruby
unbound_package 'unbound'

unbound_config 'unbound' do
  server(
    verbosity: 1,
    interface: [
      '127.0.0.1',
      '127.0.0.1@853',
    ]
  )
  notifies :restart, 'unbound_service[unbound]', :delayed
end

unbound_config_forward_zone 'test.zone' do
  forward_addr %w(1.1.1.1 8.8.8.8)
  notifies :restart, 'unbound_service[unbound]', :delayed
end

unbound_service 'unbound' do
  action :enable
end

unbound_service 'unbound start' do
  service_name 'unbound'
  action :start
end
```

## Resource Mapping

Use `unbound_package` to install or remove packages, `unbound_config` for the main `unbound.conf`, the specific `unbound_config_*` resources for configuration fragments, and `unbound_service` for packaged service management.

See `test/cookbooks/test/recipes/default.rb` for the maintained smoke-test example.
