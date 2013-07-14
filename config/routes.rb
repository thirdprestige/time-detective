Detective::Application.routes.draw do
  
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  # devise_for :admins
  devise_for :users
  

  root :to => "home#landing"
end
