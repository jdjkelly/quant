class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_timezone

  # Provides us with global authentication handling, by assuming that
  # every non-devise controller requires authorization, and rescues from
  # the case of an access denied error from CanCan (in the case of a
  # user requesting access to someone else's resource, for example)
  check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/", :alert => exception.message
  end

  def set_timezone
    Time.zone = current_user.time_zone if current_user
  end

  # Required by the strong params behavior in Rails 4.0
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
