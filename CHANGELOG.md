# CHANGELOG

This file is used to list changes made in each version of the unbound cookbook.

## Unreleased

- Update Ci files and remove CircleCI config

## 3.0.1 - *2022-09-30*

- Add missing `fallback-enable` setting to `config_authority_zone`

## 3.0.0 - *2022-04-04*

- Add separate configuration resources
- Default recipe now only runs installation
- Refactor configuration template to be Hash driven

## 2.0.3 - *2022-03-04*

- resolved cookstyle error: .delivery/project.toml:2:8 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:4:10 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:5:13 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:6:10 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:7:9 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:8:14 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:9:11 convention: `Style/StringLiterals`

## 2.0.2 - *2021-08-31*

- Standardise files with files in sous-chefs/repo-management

## 2.0.1 - *2021-06-01*

- Updated tests folder to match other cookbooks
- Updated spec platform to supported version

## 2.0.0 - 2020-05-05

- Upgraded to circleci for testing
- Minimum Chef Infra Client version is now **13.0**
- Removed unused long_description metadata.rb field
- Simplify overly complex platform logic
- Migrate to actions for testing

## [1.0.1]

- Simplify logic with root_group
- Fix `root_group` not using new_resource
- Use strings for file modes
- Resolve foodcritic warnings in the `rr` resource
- Fix platform_family logic on the service Update platforms.
- Use dokken images for travis testing.
- Don't test on debian-8/9 and centos-6 as these services don't currently start.
- Account for a list of forward-addrs / effectively disable remote control (#27)

## [1.0.0]

- Add new custom resources `unbound_install` & `unbound_configure`

## [0.1.1]

- Adding support and kitchen testing for forward_zone generation
- Updating to use Sous Chefs guidelines
