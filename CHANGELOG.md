# unbound Cookbook CHANGELOG

This file is used to list changes made in each version of the unbound cookbook.

## [1.0.1]

- Simplify logic with root_group
- Fix `root_group` not using new_resource
- Use strings for file modes
- Resolve foodcritic warnings in the `rr` resource
- Fix platform_family logic on the service Update platforms.
- Use dokken images for travis testing.
- Don't test on debian-8/9 and centos-6 as these services don't currently start.

## [1.0.0]

- Add new custom resources `unbound_install` & `unbound_configure`

## [0.1.1]

- Adding support and kitchen testing for forward_zone generation
- Updating to use Sous Chefs guidelines
