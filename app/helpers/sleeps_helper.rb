module SleepsHelper
  def formatted_duration sleep
    pluralize ( sleep.duration / 1.hour).round(1), 'hour'
  end

  def average_duration opts={}
    opts = {
      start: 7.days.ago.at_beginning_of_day,
      end: Date.today.at_beginning_of_day
    }.merge(opts)
    
    sleeps = current_user.sleeps_between(opts[:start], opts[:end])

    if sleeps.present?
      ( sleeps.map(&:duration).reduce(&:+) || 0 ) / sleeps.size
    else
      0
    end
  end
end
