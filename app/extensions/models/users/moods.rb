module Users
  module Moods
    def moods_from datetime
      moods.where("date >= ?", datetime)
    end

    def moods_after datetime
      moods.where("date > ?", datetime)
    end

    def moods_before datetime
      moods.where("date < ?", datetime)
    end

    def moods_on datetime
      moods.where("date = ?", datetime)
    end
  end
end
