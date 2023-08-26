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
  validates :kid_num, presence: true, numericality: true

  scope :in_future, ->(current_time) {
    where("date > ? OR (date = ? AND time >= ?)",
          current_time.to_date, current_time.to_date, current_time.strftime("%H:%M:%S"))
      .order(:date, :time)
  }

  # def generate_serial
  #   return unless date.present?

  #   date_part = date.strftime('%Y%m%d')
  #   random_part = rand(100..999)
  #   self.serial = "#{date_part}-#{random_part}"
  # end
end
