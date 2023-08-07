Rails.application.routes.draw do
  root to: "home#index"
<<<<<<< HEAD
=======
  
  devise_for :restaurants,controllers: { omniauth_callbacks: 'restaurants/omniauth_callbacks' }
  
  # devise_scope :restaurants do
  #   get 'auth/google', to: 'restaurants/omniauth_callbacks#passthru', as: :restaurants_google_omniauth_authorize
  # end
>>>>>>> 2e829ce (add googlelogin)

  devise_for :restaurants, controllers: { sessions: 'restaurants/sessions', registrations: 'restaurants/registrations' }
  resources :customers

end
