class MainController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:login]
  def login
    redirect_to user_stream_path if user_signed_in?
  end
  
  def update_location
    @location = current_user.update_attributes(:coordinates => params[:coordinates])
    # current_user.location_history.locations.create(@location.attributes)
  end

end
