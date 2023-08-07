# == Schema Information
#
# Table name: restaurants
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Restaurant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :tel, presence: true
  validates :address, presence: true
  validates :close_weekday, presence: true
  validates :open_hour, presence: true
            :recoverable, :rememberable, :validatable,
            :omniauthable, omniauth_providers: [:google_oauth2]

  def self.create_from_provider_data(provider_data)
    where(email: provider_data.info.email).first_or_create do |restaurant|
      restaurant.email = provider_data.info.email
      restaurant.password = Devise.friendly_token[0, 20]
      restaurant.name = provider_data.info.last_name
      restaurant.provider = provider_data.provider
      restaurant.uid = provider_data.uid
    end
  end

end
