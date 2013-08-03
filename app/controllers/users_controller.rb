class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /users/:id
  # GET /users/:id.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end
end
