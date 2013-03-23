require 'spec_helper'

describe Measurement do
  it { should validate_presence_of :value }
  it { should validate_numericality_of :value }
  it { should belong_to(:user) }
  it { should validate_presence_of :recorded_at }
end
