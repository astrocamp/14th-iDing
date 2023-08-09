Rails.application.routes.draw do
  root to: "home#index"
  
  devise_for :restaurants,controllers: { omniauth_callbacks: 'restaurants/omniauth_callbacks',
                                         sessions: 'restaurants/sessions',
                                         registrations: 'restaurants/registrations'
                                        }
  resources :customers

end
  