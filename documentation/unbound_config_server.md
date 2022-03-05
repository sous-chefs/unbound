# unbound_config_server

[Back to resource list](../README.md#resources)

## Uses

- [partials/_config_file](partials/unbound__config_file.md)

## Provides

- `:unbound_configure`
- `:unbound_config`

## Actions

- None

## Properties

| Name          | Name? | Type          | Default | Description                                 | Allowed Values |
| ------------- | ----- | ------------- | ------- | ------------------------------------------- | -------------- |
| `config_file` |       | String        |         | Set to override unbound configuration file. |                |
| `include`     |       | String, Array |         |                                             |                |
| `server`      |       | Hash          |         | Server configuration as a Hash              |                |
