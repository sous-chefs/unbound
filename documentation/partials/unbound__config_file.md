# unbound__config_file

[Back to resource list](../README.md#resources)

## Actions

- `:create`
- `:create_if_missing`
- `:delete`

## Properties

| Name                  | Name? | Type        | Default | Description                                                             | Allowed Values |
| --------------------- | ----- | ----------- | ------- | ----------------------------------------------------------------------- | -------------- |
| `owner`               |       | String      |         | Set to override config file owner. Defaults to root.                    |                |
| `group`               |       | String      |         | Set to override config file group. Defaults to unbound.                 |                |
| `mode`                |       | String      |         | Set to override config file mode. Defaults to 0640.                     |                |
| `directory_mode`      |       | String      |         | Set to override config directory mode. Defaults to 0750.                |                |
| `config_dir`          |       | String      |         | Set to override unbound configuration directory.                        |                |
| `config_file`         |       | String      |         | Set to override unbound configuration file.                             |                |
| `cookbook`            |       | String      |         | Template source cookbook for the unbound configuration file.            |                |
| `template`            |       | String      |         | Template source file for the unbound configuration file.                |                |
| `sensitive`           |       | true, false |         | Ensure that sensitive resource data is not output by Chef Infra Client. |                |
| `sort`                |       | true, false |         |                                                                         |                |
| `template_properties` |       | Hash        |         |                                                                         |                |
| `extra_options`       |       | Hash        |         |                                                                         |                |

## Libraries

- `Unbound::Cookbook::Helpers`
