# unbound_config_rpz_zone

[Back to resource list](../README.md#resources)

## Uses

- [partials/_config_file](partials/unbound__config_file.md)

## Actions

- None

## Properties

| Name                     | Name? | Type                | Default | Description                                 | Allowed Values                                    |
| ------------------------ | ----- | ------------------- | ------- | ------------------------------------------- | ------------------------------------------------- |
| `config_file`            |       | String              |         | Set to override unbound configuration file. |                                                   |
| `zone_name`              |       | String              |         |                                             |                                                   |
| `primary`                |       | String, Array       |         |                                             |                                                   |
| `master`                 |       | String, Array       |         |                                             |                                                   |
| `url`                    |       | String, Array       |         |                                             |                                                   |
| `allow_notify`           |       | String, Array       |         |                                             |                                                   |
| `zonefile`               |       | String              |         |                                             |                                                   |
| `rpz_action_override`    |       | String, Symbol      |         |                                             | nxdomain, nodata, passthru, drop, disabled, cname |
| `rpz_cname_override`     |       | String              |         |                                             |                                                   |
| `rpz_log`                |       | String, true, false |         |                                             |                                                   |
| `rpz_log_name`           |       | String              |         |                                             |                                                   |
| `rpz_signal_nxdomain_ra` |       | String, true, false |         |                                             |                                                   |
| `for_downstream`         |       | String, true, false |         |                                             |                                                   |
| `tags`                   |       | String, Array       |         |                                             |                                                   |
