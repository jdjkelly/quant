module SleepsHelper
  def formatted_duration sleep
    pluralize ((sleep.end - sleep.start) / 1.hour).round(1), 'hour'
  end
end
