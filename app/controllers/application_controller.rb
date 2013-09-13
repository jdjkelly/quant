class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_timezone

  check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/", :alert => exception.message
  end

  def set_timezone
    Time.zone = current_user.time_zone if current_user
  end
end
