# Migration

## Migrating from Recipes to Resources

This release removes the legacy `unbound::default` recipe. Wrapper cookbooks must declare the custom resources they need directly.

Before:

```ruby
include_recipe 'unbound::default'
```

After:

```ruby
unbound_package 'unbound'

unbound_config 'unbound' do
  server(
    verbosity: 1,
    interface: ['127.0.0.1']
  )
  notifies :restart, 'unbound_service[unbound]', :delayed
end

unbound_service 'unbound' do
  action [:enable, :start]
end
```

The old default recipe only installed the package and warned that configuration was no longer handled there. Use `unbound_package` for installation, `unbound_config` and related `unbound_config_*` resources for configuration files, and `unbound_service` for service management.

## Test Cookbook Example

See `test/cookbooks/test/recipes/default.rb` for a complete package, configuration, and service example used by the default Kitchen suite.
