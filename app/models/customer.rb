class Customer < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  validates :tel, presence: true


end

