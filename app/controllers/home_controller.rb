class HomeController < ApplicationController
  skip_authorization_check
  # GET /home
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
