TillDawn::Application.routes.draw do
  root :to => 'main#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
