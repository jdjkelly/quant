class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def withings
    if user_signed_in?
      current_user.create_withings_account(
        userid: params["userid"],
        oauth_token: request.env["omniauth.auth"]["credentials"]["token"],
        oauth_verifier: params["oauth_verifier"],
        oauth_token_secret: request.env["omniauth.auth"]["credentials"]["secret"])
      flash[:success] = "Account connected"
      redirect_to dashboard_index_path
    else
      flash[:alert] = "There was a problem authenticating your account"
      redirect_to dashboard_index_path
    end
  end
end
