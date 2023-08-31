Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks"}
  
  namespace :admin do
    resources :restaurants do
      resources :tables
      resources :open_times, shallow: true, only: [:index, :create, :edit, :update, :destroy]
      resources :reservations, only: [:create, :edit, :update, :destroy] do
        collection do
          get 'search', to: 'reservations#search'
        end
      end
      resources :holidays, shallow: true, only: [:create, :destroy]
    end
  end

  resources :restaurants do
    resources :build, only: [:show, :update]
  end

  resources :reservations, only: :destroy

  namespace :api do
    namespace :v1 do 
      resources :reservations, only: [] do
        member do 
          patch :check_in
          patch :leave
          patch :hold_seat
        end
      end
    end
  end

  
  get '/success_page/:reservation_id', to: 'build#success_page', as: :success_page
end
