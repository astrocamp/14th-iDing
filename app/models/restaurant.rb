class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :english_name, presence: true
  validates :tel, presence: true
  validates :address, presence: true

  belongs_to :user
end
