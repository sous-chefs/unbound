# Limitations

## Package Availability

The `unbound_package` resource installs operating system packages. This cookbook does not manage upstream source builds or third-party Unbound repositories.

### APT (Debian/Ubuntu)

* Debian 12: `unbound` 1.17.x is available for amd64, arm64, armel, armhf, i386, mips64el, mipsel, ppc64el, and s390x.
* Debian 13: `unbound` 1.22.x is available for amd64, arm64, armel, armhf, i386, ppc64el, riscv64, and s390x.
* Ubuntu 22.04 and 24.04 provide Unbound packages from the Ubuntu `universe` source package.

### DNF/YUM (RHEL family)

* Fedora 42, 43, 44, and Rawhide publish current `unbound` packages in Fedora repositories.
* RHEL-family 8, 9, and 10 derivatives publish `unbound` packages from AppStream/BaseOS-aligned repositories.
* Amazon Linux is not included in the current test matrix because the configuration helper only supports Debian, Ubuntu, Fedora, and RHEL-family platform families.

### Zypper (SUSE)

* This cookbook does not currently support SUSE paths in the Unbound configuration helper.

## Architecture Limitations

Package architectures are inherited from the operating system repositories. Debian 12 and 13 publish broad architecture coverage, including amd64 and arm64. RHEL-family and Fedora support depends on the enabled distribution repositories for the target platform.

## Source/Compiled Installation

Source installation is outside this cookbook's scope. Use distribution packages or pass explicit package names to `unbound_package`.

## Known Issues

* Only Linux FHS paths are supported by the configuration resources.
* The default Kitchen coverage focuses on Debian, Ubuntu, Fedora, and RHEL-family containers with systemd.
