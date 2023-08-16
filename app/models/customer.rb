class Customer < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  validates :tel, presence: true

  has_many :reservations
  accepts_nested_attributes_for :reservations,
                                allow_destroy: true
end

