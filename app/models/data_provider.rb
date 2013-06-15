# DataProvider makes assumptions about the structure and source of data providers. These
# providers will typically be device manufacturers who grant open API access to consumers.
# We abstract the common API authentication behaviour here.

class DataProvider < ActiveRecord::Base
  # We're not working with a real AR model here
  self.abstract_class = true

  belongs_to :user

  after_create :get_user_data

  # We expect the child model to implement this method
  def get_user_data
    raise NotImplementedError
  end
end
