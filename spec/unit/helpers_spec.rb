# frozen_string_literal: true

require 'spec_helper'

describe Unbound::Cookbook::Helpers do
  subject(:helper) do
    Class.new do
      include Unbound::Cookbook::Helpers
      attr_accessor :declared_type
    end.new
  end

  describe '#unbound_yes_no?' do
    it 'coerces booleans to Unbound yes/no strings' do
      expect(helper.unbound_yes_no?(true)).to eq('yes')
      expect(helper.unbound_yes_no?(false)).to eq('no')
    end
  end
end
