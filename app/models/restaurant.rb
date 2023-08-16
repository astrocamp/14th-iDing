class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :URL, presence: true
  validates :tel, presence: true
  validates :address, presence: true

  belongs_to :user
end
