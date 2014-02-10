# DataProvider makes assumptions about the structure and source of data providers. These
# providers will typically be device manufacturers who grant open API access to consumers.
# We abstract the common API authentication behaviour here.

# All schemas for DataProviders should implement the following columns:
# => synced_at :datetime            Last datetime data was imported from API
# => activated_at :datetime         First known creation date of account - useful for pulling historical data
# => user_id :integer               All accounts should belong to a user

module DataProvider
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    after_create :import
    attr_accessible :activated_at

    def import
      get_data import: true
    end

    def sync
      get_data sync: true
    end

    private

    def get_data options={}
      provides_data_for.each do |type|

        self.send type, options.slice(:import, :sync)
      end

      update_attribute :synced_at, Time.now
    end
  end

  module ClassMethods
    def data_provider_for(*attrs)
      class_attribute :provides_data_for
      self.provides_data_for = attrs
    end

    def provides_data_for
      self.provides_data_for
    end
  end
end
