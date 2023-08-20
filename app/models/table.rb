# frozen_string_literal: true

class Table < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :restaurant_id }
  validates :seat_num, presence: true, numericality:{ greater_than: 0}

  enum category: {'一般座位':0, '包廂':1}

  belongs_to :restaurant
end
