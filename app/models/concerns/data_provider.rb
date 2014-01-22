# DataProvider makes assumptions about the structure and source of data providers. These
# providers will typically be device manufacturers who grant open API access to consumers.
# We abstract the common API authentication behaviour here.

module DataProvider
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    after_create :get_user_data

    def get_user_data
      provides_data_for.each do |type|

        begin
          self.send type
        rescue NoMethodError
          raise Exceptions::DataProviderForMethodNotDefined.new type.to_s
        end
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
