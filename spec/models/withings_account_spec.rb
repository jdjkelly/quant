# == Schema Information
#
# Table name: withings_accounts
#
#  id                 :integer          not null, primary key
#  userid             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  oauth_token        :string(255)
#  user_id            :integer
#  oauth_token_secret :string(255)
#  synced_at          :datetime
#  activated_at       :datetime
#

require 'spec_helper'
require 'shared_examples_a_data_provider'

describe WithingsAccount do
  it { should validate_presence_of :userid }
  it { should validate_presence_of :oauth_token }
  it { should validate_presence_of :oauth_token_secret }
  it { should belong_to(:user) }
  it { should be_a_data_provider_for :weights }

  it_behaves_like "a data provider"

  let(:user) { Fabricate(:user, withings_account: Fabricate(:withings_account)) }

  before do
    stub_request(:get, /.*wbsapi.withings.net\/user\?action=getbyuserid.*/).
      to_return(:status => 200, :body => "{\"status\":0,\"body\":{\"users\":[{\"id\":0,\"firstname\":\"Test\",\"lastname\":\"User\",\"shortname\":\"TES\",\"gender\":0,\"fatmethod\":131,\"birthdate\":598467600,\"ispublic\":5}]}}", :headers => {})
    stub_request(:get, /.*wbsapi.withings.net\/measure\?action=getmeas.*/).
      to_return(:status => 200, :body => "{\"status\":0,\"body\":{\"updatetime\":1370730432,\"more\":370,\"measuregrps\":[{\"grpid\":123986552,\"attrib\":0,\"date\":1370691572,\"category\":1,\"measures\":[{\"value\":64400,\"type\":1,\"unit\":-3},{\"value\":54519,\"type\":5,\"unit\":-3},{\"value\":15344,\"type\":6,\"unit\":-3},{\"value\":9881,\"type\":8,\"unit\":-3}]}]}}", :headers => {})
  end

  context "with an active withings account" do
    describe ".sync" do
      it "should update #synced_at" do
        pending
      end

      it "should get add weights to user" do
        pending
      end
    end
  end
end
