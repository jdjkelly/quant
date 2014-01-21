require 'spec_helper'

describe Sleep do
  it { should validate_presence_of :start }
  it { should validate_presence_of :end }
  it { should belong_to(:user) }

  it "validates that the end is after the start time" do
    pending
  end
end
