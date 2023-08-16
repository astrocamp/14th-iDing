class User < ApplicationRecord
  acts_as_paranoid
  
  has_many :restaurants

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.create_from_provider_data(provider_data)
    where(email: provider_data.info.email).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.provider = provider_data.provider
      # user.uid = provider_data.uid
    end
  end
end
