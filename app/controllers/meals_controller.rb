class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /meals
  # GET /meals.json
  def index
    @meals = current_user.meals.order("date DESC")

    respond_to do |format|
      format.html do
        @meals_grouped_by_date = @meals.group_by { |m| m.date }
      end
      format.json { render json: @meals }
    end
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meal }
    end
  end

  # GET /meals/new
  # GET /meals/new.json
  def new
    @meal = Meal.new
    @meal.date = Date.current

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meal }
    end
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = current_user.meals.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to meals_path, notice: 'Meal was successfully created.' }
        format.json { render json: @meal, status: :created, location: @meal }
      else
        format.html { render action: "new" }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meals/1
  # PUT /meals/1.json
  def update
    respond_to do |format|
      if @meal.update_attributes(meal_params)
        format.html { redirect_to meals_path, notice: 'Meal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy

    respond_to do |format|
      format.html { redirect_to meals_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meal
    @meal = Meal.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def meal_params
    params.require(:meal).permit(:date, :calories, :carbohydrates, :fat, :protein, :description)
  end

end
