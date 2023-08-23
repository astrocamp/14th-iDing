# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :restaurant

  # before_validation :generate_serial
  validates :date, presence: true
  validates :time, presence: true
  validates :adult_num, presence: true, numericality: { greater_than: 0 }
<<<<<<< HEAD
  validates :kid_num, presence: true, numericality: true
=======
  validates :kid_num, presence: true, numericality: { greater_than: 0 }
>>>>>>> a5defaf (fix: first-page-data to be saved)

  # def generate_serial
  #   return unless date.present?

  #   date_part = date.strftime('%Y%m%d')
  #   random_part = rand(100..999)
  #   self.serial = "#{date_part}-#{random_part}"
  # end
end
