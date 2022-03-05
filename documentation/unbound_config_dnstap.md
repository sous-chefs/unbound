# unbound_config_dnstap

[Back to resource list](../README.md#resources)

## Uses

- [partials/_config_file](partials/unbound__config_file.md)

## Actions

- None

## Properties

| Name                                     | Name? | Type                | Default | Description                                 | Allowed Values |
| ---------------------------------------- | ----- | ------------------- | ------- | ------------------------------------------- | -------------- |
| `config_file`                            |       | String              |         | Set to override unbound configuration file. |                |
| `dnstap_enable`                          |       | String, true, false |         |                                             |                |
| `dnstap_bidirectional`                   |       | String, true, false |         |                                             |                |
| `dnstap_socket_path`                     |       | String              |         |                                             |                |
| `dnstap_ip`                              |       | String              |         |                                             |                |
| `dnstap_tls`                             |       | String, true, false |         |                                             |                |
| `dnstap_tls_server_name`                 |       | String              |         |                                             |                |
| `dnstap_tls_cert_bundle`                 |       | String              |         |                                             |                |
| `dnstap_tls_client_key_file`             |       | String              |         |                                             |                |
| `dnstap_tls_client_cert_file`            |       | String              |         |                                             |                |
| `dnstap_send_identity`                   |       | String, true, false |         |                                             |                |
| `dnstap_send_version`                    |       | String, true, false |         |                                             |                |
| `dnstap_identity`                        |       | String              |         |                                             |                |
| `dnstap_version`                         |       | String              |         |                                             |                |
| `dnstap_log_resolver_query_messages`     |       | String, true, false |         |                                             |                |
| `dnstap_log_resolver_response_messages`  |       | String, true, false |         |                                             |                |
| `dnstap_log_client_query_messages`       |       | String, true, false |         |                                             |                |
| `dnstap_log_client_response_messages`    |       | String, true, false |         |                                             |                |
| `dnstap_log_forwarder_query_messages`    |       | String, true, false |         |                                             |                |
| `dnstap_log_forwarder_response_messages` |       | String, true, false |         |                                             |                |
