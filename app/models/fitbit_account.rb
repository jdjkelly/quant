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

class FitbitAccount < DataProvider
  attr_accessible :uid, :oauth_token, :oauth_token_secret

  validates_presence_of :uid, :oauth_token, :oauth_token_secret

  def get_user_data

  end
end
