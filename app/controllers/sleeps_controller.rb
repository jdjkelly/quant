class SleepsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sleep, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /sleeps
  # GET /sleeps.json
  def index
    @sleeps = current_user.sleeps.order("start DESC")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sleeps }
    end
  end

  # GET /sleeps/1
  # GET /sleeps/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sleep }
    end
  end

  # GET /sleeps/new
  # GET /sleeps/new.json
  def new
    @sleep = Sleep.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sleep }
    end
  end

  # GET /sleeps/1/edit
  def edit
  end

  # POST /sleeps
  # POST /sleeps.json
  def create
    @sleep = current_user.sleeps.new(sleep_params)

    respond_to do |format|
      if @sleep.save
        format.html { redirect_to sleeps_url, notice: 'Sleep was successfully created.' }
        format.json { render json: @sleep, status: :created, location: @sleep }
      else
        format.html { render action: 'new' }
        format.json { render json: @sleep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sleeps/1
  # PATCH/PUT /sleeps/1.json
  def update
    respond_to do |format|
      if @sleep.update(sleep_params)
        format.html { redirect_to sleeps_url, notice: 'Sleep was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sleep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sleeps/1
  # DELETE /weights/1.json
  def destroy
    @sleep.destroy
    respond_to do |format|
      format.html { redirect_to sleeps_url, notice: 'Sleep was successfully destroyed.' }
      format.json { head :no_content }
    end
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
