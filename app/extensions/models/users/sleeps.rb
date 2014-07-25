module Users
  module Sleeps
    def sleeps_from datetime
      sleeps.where('start >= ?', datetime)
    end
  
    def sleeps_between start_datetime, end_datetime
      sleeps.where('start >= ? AND "end" <= ?', start_datetime, end_datetime)
    end

    def sleeps_after datetime
      sleeps.where('start > ?', datetime)
    end

    def sleeps_before datetime
      sleeps.where('start < ?', datetime)
    end

    def sleeps_on datetime
      sleeps.where('start = ?', datetime)
    end
  end
end
