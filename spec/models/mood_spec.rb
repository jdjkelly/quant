# == Schema Information
#
# Table name: moods
#
#  id          :integer          not null, primary key
#  date        :datetime
#  user_id     :integer
#  rating      :decimal(, )
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Mood do
  it { should validate_presence_of :date }
  it { should validate_numericality_of :rating }
  it { should ensure_inclusion_of(:rating).in_range(1..5) }
  it { should belong_to(:user) }
  it { should allow_mass_assignment_of(:date) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:rating) }

  let(:mood) { Fabricate.build(:mood) }
end
