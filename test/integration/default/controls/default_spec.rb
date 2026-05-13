# frozen_string_literal: true

control 'unbound-service-01' do
  impact 1.0
  title 'Unbound service is installed, enabled, and running'

  describe service('unbound') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'unbound-service-02' do
  impact 1.0
  title 'Unbound listens on configured ports'

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
    its('content') { should include 'interface: 127.0.0.1' }
    its('content') { should include 'interface: 127.0.0.1@853' }
  end

  describe file('/etc/unbound/unbound.conf.d/forward-zone-test.zone.conf') do
    it { should exist }
    its('content') { should include 'forward-addr: 1.1.1.1' }
    its('content') { should include 'forward-addr: 8.8.8.8' }
  end
end
