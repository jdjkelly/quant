module Exceptions
  class ApiError < StandardError; end
  class DataProviderForMethodNotDefined < NoMethodError; end
end
