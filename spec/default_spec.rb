require 'spec_helper'

describe 'unbound::default' do
  let(:runner) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') }

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
