class PostsController < ApplicationController
  def create
    @post = current_user_stream.posts.create(params[:post].merge(:poster => current_user, :poster_icon_url => current_user_icon_url, :poster_name => current_user_name))
    puts @post._id
    current_user_stream.save!
  end
  
end
