module Users
  module Meals
    def meals_from datetime
      meals.where("date >= ?", datetime)
    end

    def meals_after datetime
      meals.where("date > ?", datetime)
    end

    def meals_before datetime
      meals.where("date < ?", datetime)
    end

    def meals_on datetime
      meals.where("date = ?", datetime)
    end
  end
end
