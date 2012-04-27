class PostsController < ApplicationController
  
  def user_post
    @post = current_user_stream.posts.create(params[:post].merge(:poster => current_user, :poster_icon_url => current_user_icon_url, :poster_name => current_user_name), params[:_type].classify.constantize)
    if @post
      current_user_stream.save!
      html = render :partial => "posts/#{@post._type.underscore}"
      Pusher["private-#{current_user._id}"].trigger('user_post', {:post_type=> :html => html.to_s})         
      current_user.connections.where(:coordinates.near => [current_user.coordinates, 1]).each do |connection|
        connection.user_stream.posts.create(@post.attributes)
        Pusher["private-#{connection._id}"].trigger('user_post', {:html => html.to_s})     
      end
    end
  end
  
  def friend_post
    @post = current_friend_stream.posts.create(params[:post].merge(:poster => current_user, :poster_icon_url => current_user_icon_url, :poster_name => current_user_name), params[:_type].classify.constantize)
    if @post
      current_friend_stream.save!
      html = render :partial => "posts/#{@post._type.underscore}"
      Pusher["private-#{current_user._id}"].trigger('friend_post', {:html => html.to_s})         
      current_user.connections.each do |connection|
        connection.friend_stream.posts.create(@post.attributes)
        Pusher["private-#{connection._id}"].trigger('friend_post', {:html => html.to_s})     
      end
    end 
  end
end