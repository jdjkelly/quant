class DashboardController < ApplicationController
  before_filter :authenticate_user!
  # GET /dashboard
  # GET /dashboard.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end
end
