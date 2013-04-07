module Body
  class WeightsController < ApplicationController
    before_filter :authenticate_user!

    # GET /body/weights
    # GET /body/weights.json
    def index
      @weights = current_user.weights

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @weights }
      end
    end

    # GET /body/weights/1
    # GET /body/weights/1.json
    def show
      @weight = current_user.weights.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @weight }
      end
    end

    # GET /body/weights/new
    # GET /body/weights/new.json
    def new
      @weight = current_user.weights.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @weight }
      end
    end

    # GET /body/weights/1/edit
    def edit
      @weight = current_user.weights.find(params[:id])
    end

    # POST /body/weights
    # POST /body/weights.json
    def create
      @weight = current_user.weights.new(params[:weight])

      respond_to do |format|
        if @weight.save
          format.html { redirect_to body_weight_path(@weight), notice: 'Weight was successfully created.' }
          format.json { render json: @weight, status: :created, location: @weight }
        else
          format.html { render action: "new" }
          format.json { render json: @weight.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /body/weights/1
    # PUT /body/weights/1.json
    def update
      @weight = current_user.weights.find(params[:id])

      respond_to do |format|
        if @weight.update_attributes(params[:weight])
          format.html { redirect_to body_weight_path(@weight), notice: 'Weight was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @weight.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /body/weights/1
    # DELETE /body/weights/1.json
    def destroy
      @weight = current_user.weights.find(params[:id])
      @weight.destroy

      respond_to do |format|
        format.html { redirect_to body_weights_url }
        format.json { head :no_content }
      end
    end
  end
end
