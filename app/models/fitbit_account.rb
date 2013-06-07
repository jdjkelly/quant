# == Schema Information
#
# Table name: fitbit_accounts
#
#  id                 :integer          not null, primary key
#  uid                :string(255)
#  oauth_token        :string(255)
#  oauth_token_secret :string(255)
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class FitbitAccount < ActiveRecord::Base
  attr_accessible :uid, :oauth_token, :oauth_token_secret

  belongs_to :user

  before_create :get_user_data

  def get_user_data
    # NotImplemented
  end
end
