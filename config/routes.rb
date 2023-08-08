Rails.application.routes.draw do
  root to: "home#index"

  devise_for :restaurants, controllers: { sessions: 'restaurants/sessions', registrations: 'restaurants/registrations' }
end
