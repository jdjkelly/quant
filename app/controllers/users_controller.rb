class UsersController < ApplicationController
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
