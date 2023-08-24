# frozen_string_literal: true

class Reservation < ApplicationRecord
  acts_as_paranoid

  belongs_to :restaurant

  # before_validation :generate_serial

  validates :date, presence: true
  validates :time, presence: true
  validates :name, presence: true
  validates :tel, presence: true
  validates :adult_num, presence: true, numericality: { greater_than: 0 }
  validates :kid_num, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
