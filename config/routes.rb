Detective::Application.routes.draw do
  devise_for :admins
  devise_for :users

  mount RailsAdmin::Engine => '/console', :as => 'rails_admin'


  root :to => "home#landing"
end
