class DashboardController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check
  # GET /dashboard
  # GET /dashboard.json
  def index
    Thread.new do
      current_user.sync_all_provider_data
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end
end
