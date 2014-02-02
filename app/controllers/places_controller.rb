class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /places
  # GET /places.json
  def index
    @places = current_user.places.order("date DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = current_user.places.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to place_path(@place), notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update_attributes(place_params)
        format.html { redirect_to place_path(@place), notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def place_params
      params.require(:place).permit(:date, :lat, :lng)
    end

end
