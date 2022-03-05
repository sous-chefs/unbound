# unbound_config_dnscrypt

[Back to resource list](../README.md#resources)

## Uses

- [partials/_config_file](partials/unbound__config_file.md)

## Actions

- None

## Properties

| Name                                 | Name? | Type                | Default | Description                                 | Allowed Values |
| ------------------------------------ | ----- | ------------------- | ------- | ------------------------------------------- | -------------- |
| `config_file`                        |       | String              |         | Set to override unbound configuration file. |                |
| `dnscrypt_enable`                    |       | String, true, false |         |                                             |                |
| `dnscrypt_port`                      |       | Integer             |         |                                             |                |
| `dnscrypt_provider`                  |       | String, Array       |         |                                             |                |
| `dnscrypt_secret_key`                |       | String              |         |                                             |                |
| `dnscrypt_provider_cert`             |       | String              |         |                                             |                |
| `dnscrypt_provider_cert_rotated`     |       | String              |         |                                             |                |
| `dnscrypt_shared_secret_cache_size`  |       | String              |         |                                             |                |
| `dnscrypt_shared_secret_cache_slabs` |       | Integer             |         |                                             |                |
| `dnscrypt_nonce_cache_size`          |       | String              |         |                                             |                |
| `dnscrypt_nonce_cache_slabs`         |       | Integer             |         |                                             |                |
