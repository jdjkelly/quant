class JournalEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal_entry, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /journal_entries
  # GET /journal_entries.json
  def index
    @journal_entries = current_user.journal_entries

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @journal_entries }
    end
  end

  # GET /journal_entries/1
  # GET /journal_entries/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @journal_entry }
    end
  end

  # GET /journal_entries/new
  # GET /journal_entries/new.json
  def new
    @journal_entry = JournalEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @journal_entry }
    end
  end

  # GET /journal_entries/1/edit
  def edit
  end

  # POST /journal_entries
  # POST /journal_entries.json
  def create
    @journal_entry = current_user.journal_entries.new(journal_entry_params)

    respond_to do |format|
      if @journal_entry.save
        format.html { redirect_to journal_entries_url, notice: 'journal_entry was successfully created.' }
        format.json { render json: @journal_entry, status: :created, location: @journal_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @journal_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /journal_entries/1
  # PATCH/PUT /journal_entries/1.json
  def update
    respond_to do |format|
      if @journal_entry.update(journal_entry_params)
        format.html { redirect_to journal_entries_url, notice: 'journal_entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @journal_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /journal_entries/1
  # DELETE /weights/1.json
  def destroy
    @journal_entry.destroy
    respond_to do |format|
      format.html { redirect_to journal_entries_url, notice: 'journal_entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal_entry
      @journal_entry = journal_entry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def journal_entry_params
      params.require(:journal_entry).permit(:recorded_at, :feelings, :happiness, :strategies)
    end
end
