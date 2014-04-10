class WeightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weight, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /weights
  # GET /weights.json
  def index
    @weights = current_user.weights.order("date DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weights }
    end
  end

  # GET /weights/1
  # GET /weights/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weight }
    end
  end

  # GET /weights/new
  # GET /weights/new.json
  def new
    @weight = Weight.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weight }
    end
  end

  # GET /weights/1/edit
  def edit
  end

  # POST /weights
  # POST /weights.json
  def create
    @weight = current_user.weights.new(weight_params)

    respond_to do |format|
      if @weight.save
        format.html { redirect_to weight_path(@weight), notice: 'Weight was successfully created.' }
        format.json { render json: @weight, status: :created, location: @weight }
      else
        format.html { render action: "new" }
        format.json { render json: @weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weights/1
  # PATCH/PUT /weights/1.json
  def update
    respond_to do |format|
      if @weight.update_attributes(weight_params)
        format.html { redirect_to weight_path(@weight), notice: 'Weight was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weights/1
  # DELETE /weights/1.json
  def destroy
    @weight.destroy

    respond_to do |format|
      format.html { redirect_to weights_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_weight
    @weight = Weight.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def weight_params
    params.require(:weight).permit(:value, :date, :lean_mass, :fat_mass, :fat_percent, :source, :meta)
  end
end
