# unbound_config_authority_zone

[Back to resource list](../README.md#resources)

## Uses

- [partials/_config_file](partials/unbound__config_file.md)

## Provides

- :unbound_config_auth_zone

## Actions

- None

## Properties

| Name                    | Name? | Type                | Default | Description                                 | Allowed Values |
| ----------------------- | ----- | ------------------- | ------- | ------------------------------------------- | -------------- |
| `config_file`           |       | String              |         | Set to override unbound configuration file. |                |
| `zone_name`             |       | String              |         |                                             |                |
| `primary`               |       | String, Array       |         |                                             |                |
| `master`                |       | String, Array       |         |                                             |                |
| `url`                   |       | String, Array       |         |                                             |                |
| `allow_notify`          |       | String, Array       |         |                                             |                |
| `fallback_enabled`      |       | String, true, false |         |                                             |                |
| `for_downstream`        |       | String, true, false |         |                                             |                |
| `for_upstream`          |       | String, true, false |         |                                             |                |
| `zonemd_check`          |       | String, true, false |         |                                             |                |
| `zonemd_reject_absence` |       | String, true, false |         |                                             |                |
| `zonefile`              |       | String              |         |                                             |                |
