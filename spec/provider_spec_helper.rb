require 'chef'
require 'halite/spec_helper'
require_relative '../libraries/unbound_config'

RSpec.configure do |config|
  config.include Halite::SpecHelper
end
