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
      flash[:alert] = "You must be signed in to authenticate your Withings account"
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
          oauth_token_secret: request.env["omniauth.auth"]["credentials"]["secret"],
          activated_at: Date.parse(request.env["omniauth.auth"]["info"]["member_since"].to_s)
        )

        flash[:success] = "Fitbit account synchronized"
      end
      redirect_to dashboard_index_path
    else
      flash[:alert] = "You must be signed in to authenticate your Fitbit account"
      redirect_to new_user_session_path
    end
  end

  def foursquare
    if user_signed_in?
      if current_user.has_foursquare_auth?
        flash[:success] = "You've already synchronized your Foursquare account"
      else
        current_user.create_foursquare_account(
          uid: request.env["omniauth.auth"]["uid"],
          oauth_token: request.env["omniauth.auth"]["credentials"]["token"],
          activated_at: Time.at(request.env["omniauth.auth"]["extra"]["raw_info"]["createdAt"]).utc.to_datetime
        )

        flash[:success] = "Foursquare account synchronized"
      end
      redirect_to dashboard_index_path
    else
      flash[:alert] = "You must be signed in to authenticate your Foursquare account"
      redirect_to new_user_session_path
    end
  end
end
