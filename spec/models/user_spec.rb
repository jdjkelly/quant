# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

require 'spec_helper'

describe User do
  it { should have_many(:measurements) }
  it { should have_many(:weights) }

  describe ".weight" do
    let(:user) {
      Fabricate(:user) do
        weights(count: 3) { |attrs, i| Fabricate(:weight, recorded_at: Time.now + i, value: i.to_f) }
      end
    }
    it "returns the last recorded Weight" do
      user.weight.should eq(user.weights.order("recorded_at DESC").first)
    end

    it "returns the same value as .current" do
      user.weight.should eq(user.weights.current)
    end
  end
end
