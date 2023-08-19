Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :users, controllers: { 
                                    sessions: 'users/sessions', 
                                    registrations: 'users/registrations',
                                    omniauth_callbacks: "users/omniauth_callbacks"
                                  }
  
  namespace :admin do
    resources :restaurants do
      resources :open_times, shallow: true, only: [:index, :create, :edit, :update, :destroy]
    end
  end

  resources :tables

  resources :customers
  get "/testcss" ,to: 'home#show'
  
end
