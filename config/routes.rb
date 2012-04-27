TillDawn::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  scope :controller => :main do
    match 'login'
    match 'update_location'
  end
  
  scope :controller => :streams do
    match 'user_stream'
    match 'friend_stream'
  end
  
  scope :controller => :posts do
    match 'new_post', :defaults => {:_type => "TextPost"}
    match 'share_post/:id' => :share_post
  end
  
  post 'pusher/auth'
  
  root :to => 'main#login'
  
  
end
