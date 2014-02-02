class DashboardController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check
  # GET /dashboard
  # GET /dashboard.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end
end
