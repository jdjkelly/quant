require 'spec_helper'

describe Location do
  # it { should validate_presence_of :value }
  it { should validate_numericality_of :lat }
  it { should validate_presence_of :lat }
  it { should validate_numericality_of :lng }
  it { should validate_presence_of :lng }
  it { should belong_to(:user) }
  it { should validate_presence_of :recorded_at }
end
