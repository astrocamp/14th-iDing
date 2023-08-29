# frozen_string_literal: true

# == Schema Information
#
# Table name: reservations
#
#  id            :bigint           not null, primary key
#  date          :date             not null
#  time          :time             not null
#  adult_num     :integer          not null
#  kid_num       :integer          not null
#  purpose       :string
#  note          :text
#  serial        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint           not null
#  name          :string           not null
#  email         :string
#  gender        :integer
#
class Reservation < ApplicationRecord
  acts_as_paranoid

  belongs_to :restaurant
  belongs_to :table, optional: true

  after_save :update_table_status
  before_destroy :free_up_table
  before_save :valid_total_guests

  validates :date, presence: true
  validates :time, presence: true
  validates :name, presence: true
  validates :tel, presence: true
  validates :adult_num, presence: true, numericality: { greater_than: 0 }
  validates :kid_num, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :in_future, lambda { |current_time|
    where('date > ? OR (date = ? AND time >= ?)',
          current_time.to_date, current_time.to_date, current_time.strftime('%H:%M:%S'))
      .order(:date, :time)
  }

  private

  def update_table_status
    table.update(status: 'occupied') if table_id.present?
  end

  def free_up_table
    table.update(status: 'vacant') if table.present?
  end

  def valid_total_guests
    total_guests = adult_num + kid_num
    vacant_table = restaurant.tables.where(status: 'vacant').where('seat_num >= ?', total_guests).first

    if vacant_table
      self.table = vacant_table
    else
      errors.add(:base, '無法找到合適的空桌')
    end
  end
end
