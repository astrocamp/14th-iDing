Rails.application.routes.draw do
  root to: 'home#index'

  resources :home
  
  devise_for :users, controllers: { 
                                    sessions: 'users/sessions', 
                                    registrations: 'users/registrations',
                                    omniauth_callbacks: "users/omniauth_callbacks"
                                  }
  
  namespace :admin do
    resources :restaurants do
      resources :tables
      resources :open_times, shallow: true, only: [:index, :create, :edit, :update, :destroy]
    end
  end

  resources :tables

  resources :restaurants do
    resources :reservations do
    end
  end


  get "/testcss" ,to: 'home#show'
  
  
  resources :restaurants, only: [:show]

  namespace :reservations do
    resources :build, only: [:show, :update]
  end

  get 'success_page/:reservation_id', to: 'reservations/build#success_page', as: :success_page

end
