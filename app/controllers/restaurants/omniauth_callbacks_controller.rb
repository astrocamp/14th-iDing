# frozen_string_literal: true

class Restaurants::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
  
    @restaurant = Restaurant.create_from_provider_data(request.env["omniauth.auth"])

    if @restaurant.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @restaurant, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_restaurant_registration_url
    end
    
    def failure
      redirect_to root_path
    end
  end
  
end
