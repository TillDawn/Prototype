class PostsController < ApplicationController
  def new_post
    @post = current_user_stream.posts.create(params[:post].merge(:poster => current_user, :poster_icon_url => current_user_icon_url, :poster_name => current_user_name), params[:_type].classify.constantize)
    current_user_stream.save!
    html = render :partial => "posts/#{@post._type.underscore}"
    Pusher["private-#{current_user._id}"].trigger('post', {:html => html.to_s})
    current_user.connections.each do |connection|
      connection.user_stream.posts.create(@post.clone)
    end
  end
  
end
