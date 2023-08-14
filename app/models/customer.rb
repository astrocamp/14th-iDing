class Customer < ApplicationRecord
  validates :name, presence: true
  validates :tel, presence: true


end

