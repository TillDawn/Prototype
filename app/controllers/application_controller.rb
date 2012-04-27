class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  layout :set_layout
  helper_method :current_user_stream, :current_friend_stream
  
  def current_user_name
    @current_user_name ||= "#{current_user.first_name} #{current_user.last_name.first}."
  end
  
  def current_user_icon_url
    @current_user_icon_url ||= current_user.icon_url
  end
  
  def current_stream(stream_type = nil)
    current_user.stream(stream_type)
  end
  
  def current_user_stream
    @current_user_stream ||= current_user.user_stream
  end
  
  def current_friend_stream
    @current_friend_stream ||= current_user.friend_stream
  end
  
  private
    def set_layout
      user_signed_in? ? "application" : "guest"
    end
end
