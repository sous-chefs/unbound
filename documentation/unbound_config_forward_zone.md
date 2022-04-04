# unbound_config_forward_zone

[Back to resource list](../README.md#resources)

## Uses

- [partials/_config_file](partials/unbound__config_file.md)

## Actions

- None

## Properties

| Name                   | Name? | Type                | Default | Description                                 | Allowed Values |
| ---------------------- | ----- | ------------------- | ------- | ------------------------------------------- | -------------- |
| `config_file`          |       | String              |         | Set to override unbound configuration file. |                |
| `zone_name`            |       | String              |         |                                             |                |
| `forward_host`         |       | String, Array       |         |                                             |                |
| `forward_addr`         |       | String, Array       |         |                                             |                |
| `forward_first`        |       | String, true, false |         |                                             |                |
| `forward_tls_upstream` |       | String, true, false |         |                                             |                |
| `forward_ssl_upstream` |       | String, true, false |         |                                             |                |
| `forward_tcp_upstream` |       | String, true, false |         |                                             |                |
| `forward_no_cache`     |       | String, true, false |         |                                             |                |
