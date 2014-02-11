class DataProviderSync
  include SuckerPunch::Job

  def perform klass, id
    ActiveRecord::Base.connection_pool.with_connection do
      obj = klass.find(id)
      obj.sync
    end
  end
end
