# unbound_config_stub_zone

[Back to resource list](../README.md#resources)

## Uses

- [partials/_config_file](partials/unbound__config_file.md)

## Actions

- None

## Properties

| Name                | Name? | Type                | Default | Description                                 | Allowed Values |
| ------------------- | ----- | ------------------- | ------- | ------------------------------------------- | -------------- |
| `config_file`       |       | String              |         | Set to override unbound configuration file. |                |
| `zone_name`         |       | String              |         |                                             |                |
| `stub_host`         |       | String, Array       |         |                                             |                |
| `stub_addr`         |       | String, Array       |         |                                             |                |
| `stub_prime`        |       | String, true, false |         |                                             |                |
| `stub_first`        |       | String, true, false |         |                                             |                |
| `stub_tls_upstream` |       | String, true, false |         |                                             |                |
| `stub_ssl_upstream` |       | String, true, false |         |                                             |                |
| `stub_tcp_upstream` |       | String, true, false |         |                                             |                |
| `stub__no_cache`    |       | String, true, false |         |                                             |                |
