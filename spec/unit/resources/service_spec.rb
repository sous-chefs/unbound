# frozen_string_literal: true

require 'spec_helper'

describe 'unbound_service' do
  step_into :unbound_service
  platform 'ubuntu', '24.04'

  context 'action :enable' do
    recipe do
      unbound_service 'unbound' do
        action :enable
      end
    end

    it { is_expected.to enable_service('unbound') }
  end

  context 'action :test' do
    recipe do
      unbound_service 'unbound' do
        action :test
      end
    end

    stubs_for_provider('unbound_service[unbound]') do |provider|
      allow(provider).to receive_shell_out('/usr/sbin/unbound-checkconf')
    end

    it { is_expected.to test_unbound_service('unbound') }
  end
end
