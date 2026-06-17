# frozen_string_literal: true

title 'Default Unbound Tests'

conf_dir = os.debian? ? '/etc/unbound/unbound.conf.d' : '/etc/unbound/conf.d'
include_pattern = os.debian? ? %r{include: /etc/unbound/unbound\.conf\.d/\*\.conf} : %r{include: /etc/unbound/conf\.d/\*\.conf}

control 'unbound-service-01' do
  impact 1.0
  title 'Unbound service is installed, enabled, and running'

  describe service 'unbound' do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'unbound-listener-01' do
  impact 1.0
  title 'Unbound listens on DNS ports'

  describe port(53) do
    it { should be_listening }
    its('processes') { should include 'unbound' }
  end

  describe port(853) do
    it { should be_listening }
    its('processes') { should include 'unbound' }
  end
end

control 'unbound-config-01' do
  impact 0.7
  title 'Unbound configuration files are rendered'

  describe file('/etc/unbound/unbound.conf') do
    it { should exist }
    its('content') { should match(/interface: 127\.0\.0\.1/) }
    its('content') { should match(include_pattern) }
  end

  describe file("#{conf_dir}/forward-zone-test.zone.conf") do
    it { should exist }
    its('content') { should match(/forward-addr: 1\.1\.1\.1/) }
    its('content') { should match(/forward-addr: 8\.8\.8\.8/) }
  end
end
