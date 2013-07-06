Detective::Application.routes.draw do
  get "home/landing"
  devise_for :users
  
  root :to => "home#landing"
end
