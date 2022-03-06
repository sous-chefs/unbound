describe service 'unbound' do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(53) do
  it { should be_listening }
  its('processes') { should include 'unbound' }
end

describe port(853) do
  it { should be_listening }
  its('processes') { should include 'unbound' }
end
