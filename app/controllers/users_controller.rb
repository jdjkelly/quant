class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /users/:id
  # GET /users/:id.json
  def show
    @user = User.find(params[:id])

    begin
      @user.sync_all_provider_data
      flash[:notice] = "API sources refreshed."
    rescue Exceptions::ApiError
      flash[:alert] = "API error - please connected and reconnect."
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end
end
