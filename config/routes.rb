Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :users, controllers: { 
                                    sessions: 'users/sessions', 
                                    registrations: 'users/registrations',
                                    omniauth_callbacks: "users/omniauth_callbacks"
                                  }
  
  namespace :admin do
    resources :restaurants
  end

  resources :tables

  resources :restaurants do
    resources :customers
    resources :reservations
  end


  get "/testcss" ,to: 'home#show'
  
end
