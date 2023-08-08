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
end
