module DashboardHelper
  def domain_resize(user_data)
    user_data.map do |d|
      if d == user_data.min
        0
      elsif d == user_data.max
        1
      else
       (d-user_data.min) * 1/(user_data.max-user_data.min).to_f
      end
    end
  end
end
