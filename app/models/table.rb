# frozen_string_literal: true

# == Schema Information
#
# Table name: tables
#
#  id            :bigint           not null, primary key
#  name          :string
#  seat_num      :integer
#  status        :string
#  category      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint           not null
#
class Table < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :restaurant_id }
  validates :seat_num, presence: true, numericality: { greater_than: 0 }
  before_create :set_default_status

  enum category: { '一般座位': 0, '包廂': 1 }
  has_many :reservations, dependent: :destroy
  belongs_to :restaurant

  private

  def set_default_status
    self.status = 'vacant'
  end
end
