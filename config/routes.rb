Detective::Application.routes.draw do
  devise_for :admins
  devise_for :users

  mount RailsAdmin::Engine => '/console', :as => 'rails_admin'

  get '/mobile' => 'home#mobile'
  root :to => "home#landing"
end
