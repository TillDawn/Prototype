class MainController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:login]
  def login
    redirect_to user_stream_path if user_signed_in?
  end
  
  def update_location
    puts params
  end

end
