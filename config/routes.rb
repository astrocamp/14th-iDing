Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks"}
  
  namespace :admin do
    resources :restaurants do
      resources :tables do
        get 'tablemap', on: :collection
      end
      resources :open_times, shallow: true, only: [:index, :create, :edit, :update, :destroy]
      resources :reservations, only: [:create, :edit, :update, :destroy] do
        collection do
          get 'search', to: 'reservations#search'
          get 'calendar', to: 'reservations#calendar'
        end
      end
      resources :holidays, shallow: true, only: [:create, :destroy]
    end
  end

  resources :restaurants do
    member do
      post :filter_timelist
    end
    resources :build, only: [:show, :update]
  end

  namespace :api do
    namespace :v1 do
      resources :restaurants, only: [] do
        member do
          get :reservations
        end
      end
    end
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
      resources :tables, only: [] do
        member do
          patch :update_position
        end
      end
    end
  end

  
  get '/success_page/:reservation_id', to: 'build#success_page', as: :success_page
end
