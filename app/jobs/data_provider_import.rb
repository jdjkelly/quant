class DataProviderImport
  include SuckerPunch::Job

  def perform klass, id
    ActiveRecord::Base.connection_pool.with_connection do
      obj = klass.find(id)
      obj.import
    end
  end
end
