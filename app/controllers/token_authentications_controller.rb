# token_authentications_controller.rb

class TokenAuthenticationsController < ApplicationController

  def create
    @user = User.criteria.id(params[:user_id]).first
    @user.reset_authentication_token!
    redirect_to edit_user_registration_path(@user)
  end

  def destroy
    @user = User.criteria.id(params[:id]).first
    @user.authentication_token = nil
    @user.save
    redirect_to edit_user_registration_path(@user)
  end

end
