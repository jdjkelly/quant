# == Schema Information
#
# Table name: sleeps
#
#  id         :integer          not null, primary key
#  start      :datetime
#  end        :datetime
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  meta       :hstore
#  source     :string(255)
#

require 'spec_helper'

describe Sleep do
  it { should validate_presence_of :start }
  it { should validate_presence_of :end }
  it { should belong_to(:user) }

  it "validates that the end is after the start time" do
    pending
  end
end
