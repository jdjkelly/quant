# == Schema Information
#
# Table name: measurements
#
#  id          :integer          not null, primary key
#  value       :float
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  recorded_at :datetime
#

require 'spec_helper'

describe Weight do
  describe ".self" do
    it "inherts from Measurement" do
      Weight.new.is_a? Measurement
    end
  end
end
