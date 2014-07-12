class JournalEntrySerializer < ActiveModel::Serializer
  attributes :id, :recorded_at, :feelings, :happiness, :strategies
end
