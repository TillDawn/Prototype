class PostsController < ApplicationController
  
  respond_to :js
  def new_post
    @post = current_user_stream.posts.create(params[:post].merge(:poster => current_user, :poster_icon_url => current_user_icon_url, :poster_name => current_user_name), params[:_type].classify.constantize)
    current_user_stream.save!
    html = render :partial => "posts/#{@post._type.underscore}"
    current_user.connections.each do |connection|
      connection.user_stream.posts.create(@post.attributes)
      Pusher["private-#{connection._id}"].trigger('post', {:html => html.to_s})     
    end
    render 'new_post', :as => :js
  end
  
  def share_post
    
  end
end