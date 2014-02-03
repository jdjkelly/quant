class MoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mood, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /moods
  # GET /moods.json
  def index
    @moods = current_user.moods.order("date DESC")

    respond_to do |format|
      format.html do
        @moods_grouped_by_date = @moods.group_by { |m| m.date }
      end
      format.json { render json: @moods }
    end
  end

  # GET /moods/1
  # GET /moods/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mood }
    end
  end

  # GET /moods/new
  # GET /moods/new.json
  def new
    @mood = Mood.new
    @mood.date = Date.current

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mood }
    end
  end

  # GET /moods/1/edit
  def edit
  end

  # POST /moods
  # POST /moods.json
  def create
    @mood = current_user.moods.new(mood_params)

    respond_to do |format|
      if @mood.save
        format.html { redirect_to moods_path, notice: 'Mood was successfully created.' }
        format.json { render json: @mood, status: :created, location: @mood }
      else
        format.html { render action: "new" }
        format.json { render json: @mood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moods/1
  # PUT /moods/1.json
  def update
    respond_to do |format|
      if @mood.update_attributes(mood_params)
        format.html { redirect_to moods_path, notice: 'Mood was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moods/1
  # DELETE /moods/1.json
  def destroy
    @mood.destroy

    respond_to do |format|
      format.html { redirect_to moods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mood
      @mood = Mood.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mood_params
      params.require(:mood).permit(:date, :rating, :description)
    end

end
