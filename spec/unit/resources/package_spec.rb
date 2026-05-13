# frozen_string_literal: true

require 'spec_helper'

describe 'unbound_package' do
  step_into :unbound_package
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      unbound_package 'unbound'
    end

    it { is_expected.to install_package('unbound').with(package_name: %w(unbound)) }
  end

  context 'with custom packages' do
    recipe do
      unbound_package 'unbound' do
        packages %w(unbound unbound-anchor)
      end
    end

    it { is_expected.to install_package('unbound').with(package_name: %w(unbound unbound-anchor)) }
  end
end
