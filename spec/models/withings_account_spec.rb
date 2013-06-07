# == Schema Information
#
# Table name: withings_accounts
#
#  id                 :integer          not null, primary key
#  userid             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  oauth_token        :string(255)
#  oauth_verifier     :string(255)
#  user_id            :integer
#  oauth_token_secret :string(255)
#

require 'spec_helper'

describe WithingsAccount do
  pending "add some examples to (or delete) #{__FILE__}"
end
