class Reservation < ApplicationRecord
  belongs_to :customer

  before_validation :generate_serial

  validates :date, presence: true
  validates :time, presence: true
  validates :adult_num, presence: true, numericality:{ greater_than: 0 }
  validates :kid_num, presence: true

  private
  
  def generate_serial
    if self.date.present?
      date_part = self.date.strftime("%Y%m%d")
      random_part = rand(100..999)
      self.serial = "#{date_part}-#{random_part}"
    end
  end  
end
