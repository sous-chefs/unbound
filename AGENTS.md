# AGENTS.md

## Cookbook Purpose

This cookbook manages NLnet Labs Unbound as a native-package Linux DNS resolver through custom resources only. The public API is the `unbound_package`, `unbound_config*`, and `unbound_service` resource set; recipes and node attributes are intentionally not part of the API after the full migration.

## Agent Findings

* Full migration scope was explicitly confirmed before edits. Do not add compatibility recipes back unless a maintainer intentionally reintroduces an incremental compatibility layer.
* Unbound package layouts differ by platform family. Debian and Ubuntu include `/etc/unbound/unbound.conf.d/*.conf`; RHEL-family platforms include `/etc/unbound/conf.d/*.conf` and `/etc/unbound/local.d/*.conf`. Keep helper-derived defaults in `libraries/helpers.rb` rather than duplicating paths in recipes.
* Config resources create shared configuration directories but their `:delete` action removes only the managed file. The directory is shared by multiple config resources and by distro packages, so recursively deleting it can remove unrelated config fragments.
* The service resource intentionally uses Chef's `service` resource instead of `systemd_unit` because native packages own the unit file. The custom resource is only responsible for enable/start/stop/reload/restart behavior and optional `unbound-checkconf` validation.
* Dokken is viable for local and CI smoke testing because the default suite only installs native packages, renders config, and manages the packaged systemd service. No hypervisor-only behavior is required.
* Existing workflow edits had already bumped Sous-Chefs reusable workflows from `5.0.8` to `8.0.1`; this migration preserved that direction and aligned the explicit workstation install action to the same version.

## Package Availability

### APT (Debian/Ubuntu)

* Debian 13 ships `unbound` 1.22.0 packages with security updates for multiple architectures including amd64, arm64, ppc64el, riscv64, and s390x: <https://packages.debian.org/trixie/unbound>
* Ubuntu 22.04 and 24.04 ship `unbound` in the standard package repositories: <https://packages.ubuntu.com/search?keywords=unbound>
* Debian 12 has packages but reached regular EOL on 2026-06-10 according to endoflife.date, so it is not in the active Kitchen matrix.

### DNF/YUM (RHEL Family)

* Fedora ships current Unbound packages in the standard Fedora package set: <https://packages.fedoraproject.org/pkgs/unbound/unbound/>
* RHEL-family derivatives are tested with AlmaLinux, Rocky Linux, Oracle Linux, Amazon Linux 2023, and CentOS Stream 9 Dokken images. Native package availability is expected through the distro repositories used by those images.
* CentOS Linux 7 and CentOS Stream 8 are EOL and were removed from Kitchen/CI.

### Zypper (SUSE)

* openSUSE Leap was present only in an old Dokken matrix, not in `metadata.rb`. It was removed during platform normalization because the cookbook has no SUSE-specific helper coverage and no current metadata support declaration.

## Architecture Limitations

* The cookbook does not pin architecture-specific packages. Test coverage is x86_64-focused through Dokken and GitHub Actions runners.
* Upstream Unbound runs on Linux, BSD, and macOS, and NLnet Labs notes packages are available for most platforms, but this cookbook intentionally supports Linux package-managed deployments only: <https://nlnetlabs.nl/projects/unbound/about/>

## Source/Compiled Installation

This cookbook does not compile Unbound from source. NLnet Labs documents source builds requiring OpenSSL headers and the normal `./configure`, `make`, and `make install` flow, but native packages remain the supported installation path here: <https://nlnetlabs.nl/documentation/unbound/howto-setup/>

## Known Issues

* The `unbound_config_python_script` resource installs `python3-unbound` as part of rendering Python module config. Package availability can vary by platform and should be verified before adding that resource to the default smoke suite.
* The remote-control resource writes configuration only. It does not run `unbound-control-setup` or manage generated TLS key material.

## Test and CI Notes

* The required default suite is `default`, converges `recipe[test::default]`, and verifies `test/integration/default/`.
* Keep `kitchen.yml`, `kitchen.dokken.yml`, `kitchen.global.yml`, and `.github/workflows/ci.yml` in sync when platform targets change.
* Prefer `KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen test default-ubuntu-2404 --destroy=always` for local verification. Use Vagrant only if Docker is unavailable.
