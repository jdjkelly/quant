# == Schema Information
#
# Table name: journal_entries
#
#  id                   :integer          not null, primary key
#  feelings             :text
#  happiness            :integer
#  strategies           :text
#  created_at           :datetime
#  updated_at           :datetime
#  user_id              :integer
#  encrypted_happiness  :string(255)
#  encrypted_strategies :text
#  encrypted_feelings   :text
#

require 'spec_helper'

describe JournalEntry do
  pending "add some examples to (or delete) #{__FILE__}"
end
