Detective::Application.routes.draw do
  devise_for :users

  scope '/:account_id' do
    resources :projects do
      resources :activities, only: [:index, :create]
      resources :time_entries, only: [:index, :create, :destroy] do
        member do
          put :confirm
        end
      end
    end
  end
end
