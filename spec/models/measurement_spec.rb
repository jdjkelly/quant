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

describe Measurement do
  it { should validate_presence_of :value }
  it { should validate_numericality_of :value }
  it { should belong_to(:user) }
  it { should validate_presence_of :recorded_at }
end
