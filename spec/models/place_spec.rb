# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  date       :datetime
#  lat        :decimal(, )
#  lng        :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Place do
  # it { should validate_presence_of :value }
  it { should validate_numericality_of :lat }
  it { should validate_presence_of :lat }
  it { should validate_numericality_of :lng }
  it { should validate_presence_of :lng }
  it { should belong_to(:user) }
  it { should validate_presence_of :date }
end
