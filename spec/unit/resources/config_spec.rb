# frozen_string_literal: true

require 'spec_helper'

describe 'unbound_config' do
  step_into :unbound_config
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config 'unbound' do
      server verbosity: 1
    end
  end

  it { is_expected.to create_directory('/etc/unbound') }
  it { is_expected.to create_directory('/etc/unbound/unbound.conf.d') }
  it { is_expected.to create_template('/etc/unbound/unbound.conf') }
end

describe 'unbound_config on RHEL-family platforms' do
  step_into :unbound_config
  platform 'redhat', '9'

  recipe do
    unbound_config 'unbound' do
      server verbosity: 1
    end
  end

  it { is_expected.to create_directory('/etc/unbound') }
  it { is_expected.to create_directory('/etc/unbound/conf.d') }
  it { is_expected.to create_directory('/etc/unbound/local.d') }
  it { is_expected.to create_template('/etc/unbound/unbound.conf') }
end

describe 'unbound_config on Amazon Linux' do
  step_into :unbound_config
  platform 'amazon', '2023'

  recipe do
    unbound_config 'unbound' do
      server verbosity: 1
    end
  end

  it { is_expected.to create_directory('/etc/unbound') }
  it { is_expected.to create_directory('/etc/unbound/conf.d') }
  it { is_expected.to create_directory('/etc/unbound/local.d') }
  it { is_expected.to create_template('/etc/unbound/unbound.conf') }
end

describe 'unbound_config with mixed string and symbol keys' do
  step_into :unbound_config
  platform 'redhat', '9'

  recipe do
    unbound_config 'unbound' do
      server(
        verbosity: 1,
        interface: '127.0.0.1',
        'chroot' => '',
        'pidfile' => '/var/run/unbound/unbound.pid'
      )
    end
  end

  it { is_expected.to render_file('/etc/unbound/unbound.conf').with_content('chroot: ""') }
  it { is_expected.to render_file('/etc/unbound/unbound.conf').with_content('interface: 127.0.0.1') }
  it { is_expected.to render_file('/etc/unbound/unbound.conf').with_content('pidfile: /var/run/unbound/unbound.pid') }
  it { is_expected.to render_file('/etc/unbound/unbound.conf').with_content('verbosity: 1') }
end

describe 'unbound_config_authority_zone' do
  step_into :unbound_config_authority_zone
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_authority_zone 'example.org' do
      primary '192.0.2.53'
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/authority-zone-example.org.conf') }
end

describe 'unbound_config_cachedb' do
  step_into :unbound_config_cachedb
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_cachedb 'cachedb' do
      backend 'redis'
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/cachedb.conf') }
end

describe 'unbound_config_dns64' do
  step_into :unbound_config_dns64
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_dns64 'dns64' do
      dns64_prefix '64:ff9b::/96'
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/dns64.conf') }
end

describe 'unbound_config_dnscrypt' do
  step_into :unbound_config_dnscrypt
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_dnscrypt 'dnscrypt' do
      dnscrypt_enable true
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/dnscrypt.conf') }
end

describe 'unbound_config_dnstap' do
  step_into :unbound_config_dnstap
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_dnstap 'dnstap' do
      dnstap_enable true
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/dnstap.conf') }
end

describe 'unbound_config_dynamic_library' do
  step_into :unbound_config_dynamic_library
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_dynamic_library 'dyn' do
      dynlib_file '/usr/lib/unbound/filter.so'
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/dyn-lib-dyn.conf') }
end

describe 'unbound_config_forward_zone' do
  step_into :unbound_config_forward_zone
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_forward_zone 'example.com' do
      forward_addr '1.1.1.1'
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/forward-zone-example.com.conf') }
end

describe 'unbound_config_python_script' do
  step_into :unbound_config_python_script
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_python_script 'filter' do
      python_script '/etc/unbound/filter.py'
    end
  end

  it { is_expected.to install_package('python3-unbound') }
  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/python-script-filter.conf') }
end

describe 'unbound_config_remote_control' do
  step_into :unbound_config_remote_control
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_remote_control 'remote-control' do
      control_enable false
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/remote-control.conf') }
end

describe 'unbound_config_rpz_zone' do
  step_into :unbound_config_rpz_zone
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_rpz_zone 'rpz.example' do
      primary '192.0.2.53'
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/rpz-zone-rpz.example.conf') }
end

describe 'unbound_config_stub_zone' do
  step_into :unbound_config_stub_zone
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_stub_zone 'stub.example' do
      stub_addr '192.0.2.53'
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/stub-zone-stub.example.conf') }
end

describe 'unbound_config_view' do
  step_into :unbound_config_view
  platform 'ubuntu', '24.04'

  recipe do
    unbound_config_view 'internal' do
      local_zone 'example.com static'
    end
  end

  it { is_expected.to create_template('/etc/unbound/unbound.conf.d/view-internal.conf') }
end
