class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def failure
    flash[:alert] = "There was an error connecting your accounts"
  end

  def withings
    if user_signed_in?
      if current_user.has_withings_auth?
        flash[:success] = "You've already synchronized your scale"
      else
        current_user.create_withings_account(
          userid: request.env["omniauth.auth"]["uid"],
          oauth_token: request.env["omniauth.auth"]["credentials"]["token"],
          oauth_token_secret: request.env["omniauth.auth"]["credentials"]["secret"]
        )

        flash[:success] = "Withings scale synchronized"
      end
      redirect_to dashboard_index_path
    else
      flash[:alert] = "You must be signed in to authenticate your Withings scale"
      redirect_to new_user_session_path
    end
  end

  def fitbit
    if user_signed_in?
      if current_user.has_fitbit_auth?
        flash[:success] = "You've already synchronized your Fitbit account"
      else
        current_user.create_fitbit_account(
          uid: request.env["omniauth.auth"]["uid"],
          oauth_token: request.env["omniauth.auth"]["credentials"]["token"],
          oauth_token_secret: request.env["omniauth.auth"]["credentials"]["secret"]
        )

        flash[:success] = "Fitbit account synchronized"
      end
      redirect_to dashboard_index_path
    else
      flash[:alert] = "You must be signed in to authenticate your Fitbit"
      redirect_to new_user_session_path
    end
  end
end
