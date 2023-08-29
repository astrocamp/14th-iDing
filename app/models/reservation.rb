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
  before_save :assign_table

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
    if table_id.present?
      table.update(status: "occupied")
    end
  end

  def free_up_table
    table.update(status: "vacant") if table.present?
  end

  def assign_table
    if table_id.blank?
      vacant_table = restaurant.tables.find_by(status: "vacant")
      if vacant_table
        total_guests = adult_num + kid_num
        if total_guests <= vacant_table.seat_num
          self.table_id = vacant_table.id
        else
          errors.add(:base, "訂位人數超過所選座位的容量")
        end
      else
        errors.add(:base, "目前已客滿")
      end
    end
  end

end
