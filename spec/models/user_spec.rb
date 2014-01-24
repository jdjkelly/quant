# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  name                   :string(255)
#  height                 :float
#  time_zone              :string(255)      default("UTC")
#

require 'spec_helper'

describe User do
  it { should have_many(:weights) }
  it { should have_many(:meals) }
  it { should have_many(:places) }
  it { should validate_numericality_of :height }

  describe "#has_withings_auth?" do
    #pending
  end

  describe "#has_scale_auth?" do
    #pending
  end
end
