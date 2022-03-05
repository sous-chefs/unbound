# unbound_service

[Back to resource list](../README.md#resources)

## Actions

- `:start`
- `:stop`
- `:restart`
- `:reload`
- `:enable`
- `:disable`
- `:test`

## Properties

| Name                      | Name? | Type        | Default | Description                                                      | Allowed Values |
| ------------------------- | ----- | ----------- | ------- | ---------------------------------------------------------------- | -------------- |
| `service_name`            |       | String      |         | The service name to perform actions upon                         |                |
| `config_test`             |       | true, false |         | Perform configuration file test before performing service action |                |
| `config_test_fail_action` |       | Symbol      |         | Action to perform upon configuration test failure.               | raise, log     |
