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
  it { should have_many(:sleeps) }

  it { should have_one(:withings_account) }
  it { should have_one(:fitbit_account) }
  it { should have_one(:foursquare_account) }

  it { should validate_numericality_of :height }
  it { should validate_presence_of :name }

  describe ".has_withings_auth?" do
    pending
  end

  describe ".has_foursquare_auth?" do
    pending
  end

  describe ".has_fitbit_auth?" do
    pending
  end

  describe ".sync_all_provider_data" do
    pending
  end

  describe ".user_id" do
    pending
  end
end
