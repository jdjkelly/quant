class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def failure
    flash[:alert] = "There was an error connecting your accounts"
  end

  def withings
    store_account WithingsAccount, do
      current_user.create_withings_account(
        userid: request.env["omniauth.auth"]["uid"],
        oauth_token: request.env["omniauth.auth"]["credentials"]["token"],
        oauth_token_secret: request.env["omniauth.auth"]["credentials"]["secret"]
      )
    end
  end

  def fitbit
    store_account FitbitAccount, do
      current_user.create_fitbit_account(
        uid: request.env["omniauth.auth"]["uid"],
        oauth_token: request.env["omniauth.auth"]["credentials"]["token"],
        oauth_token_secret: request.env["omniauth.auth"]["credentials"]["secret"],
        activated_at: Date.parse(request.env["omniauth.auth"]["info"]["member_since"].to_s)
      )
    end
  end

  def foursquare
    store_account FoursquareAccount, do
      current_user.create_foursquare_account(
        uid: request.env["omniauth.auth"]["uid"],
        oauth_token: request.env["omniauth.auth"]["credentials"]["token"],
        activated_at: Time.at(request.env["omniauth.auth"]["extra"]["raw_info"]["createdAt"]).utc.to_datetime
      )
    end
  end

  def jawbone
    binding.pry
    store_account JawboneAccount, do
      current_user.create_jawbone_account
    end
  end

  private

  def store_account klass, callback
    if user_signed_in?
      if current_user.send(klass.model_name.singular)
        flash[:success] = "You've already synchronized your #{klass.model_name.humanize}"
      else
        yield callback

        flash[:success] = "#{klass.model_name.humanize} synchronized"
      end
      redirect_to dashboard_index_path
    else
      flash[:alert] = "You must be signed in to authenticate your #{klass.model_name.humanize}"
      redirect_to new_user_session_path
    end
  end
end
