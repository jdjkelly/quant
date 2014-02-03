require 'rspec/expectations'

RSpec::Matchers.define :be_a_data_provider_for do |expected|
  match do |actual|
    actual.provides_data_for.include? expected
  end
end
