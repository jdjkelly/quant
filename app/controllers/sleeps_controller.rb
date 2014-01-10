class SleepsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sleep, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /sleeps
  def index
    @sleeps = current_user.sleeps
  end

  # GET /sleeps/1
  def show
  end

  # GET /sleeps/new
  def new
    @sleep = Sleep.new
  end

  # GET /sleeps/1/edit
  def edit
  end

  # POST /sleeps
  def create
    @sleep = current_user.sleeps.new(sleep_params)

    if @sleep.save
      redirect_to sleeps_url, notice: 'Sleep was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /sleeps/1
  def update
    if @sleep.update(sleep_params)
      redirect_to sleeps_url, notice: 'Sleep was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /sleeps/1
  def destroy
    @sleep.destroy
    redirect_to sleeps_url, notice: 'Sleep was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sleep
      @sleep = Sleep.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sleep_params
      params.require(:sleep).permit(:start, :end)
    end
end
