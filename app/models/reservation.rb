# frozen_string_literal: true

# == Schema Information
#
# Table name: reservations
#
#  id            :bigint           not null, primary key
#  date          :date             not null
#  time          :time             not null
#  adults     :integer          not null
#  kids       :integer          not null
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
  include AASM

  belongs_to :restaurant
  belongs_to :table, optional: true

  before_create :valid_total_guests

  validates :date, presence: true
  validates :time, presence: true
  validates :name, presence: true
  validates :tel, presence: true
  validates :adults, presence: true, numericality: { greater_than: 0 }
  validates :kids, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :in_future, lambda { |current_time|
    where('date > ? OR (date = ? AND time >= ?)',
          current_time.to_date, current_time.to_date, current_time.strftime('%H:%M:%S'))
      .order(:date, :time)
  }

  aasm column: :state do
    state :reserved, initial: true
    state :keeped, :used, :completed, :cancelled

    event :keep do
      transitions from: :reserved, to: :keeped
    end

    event :use do
      transitions from: %i[reserved keeped], to: :used, after: :update_table_status_to_occupied
    end

    event :complete do
      transitions from: :used, to: :completed, after: :update_table_status_to_vacant
    end

    event :cancel do
      transitions from: %i[reserved keeped], to: :cancelled
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name tel date restaurant_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['restaurant']
  end

  def self.search(params)
    result = all

    result = result.where(date: params[:date_eq]) if params[:date_eq].present?

    result = result.ransack('name_or_tel_cont' => params[:name_or_tel_cont]).result if params[:name_or_tel_cont].present?
    result
  end

  ransacker :name_or_tel_cont do
    Arel::Nodes::NamedFunction.new('CONCAT_WS', [Arel::Nodes.build_quoted(' '), arel_table[:name], arel_table[:tel]])
  end

  def valid_total_guests
    total_guests = adults + kids
    suitable_table = find_suitable_table(total_guests, date, time)

    if suitable_table
      self.table = suitable_table
    else
      self.table = nil
      errors.add(:base, '無法找到合適的空桌')
      false
    end
  end

  def find_suitable_table(guests, reservation_date, reservation_time)
    @mealtime = restaurant.mealtime.minutes
    hour_before = reservation_time - @mealtime + 1
    hour_after = reservation_time + @mealtime - 1

    restaurant.tables
              .where('seat_num >= ?', guests)
              .where.not(id: reserved_table_within_time_range(reservation_date, hour_before, hour_after))
              .first
  end

  def reserved_table_within_time_range(date, start_time, end_time)
    reserved_tables = Reservation
                      .where(date:, time: start_time..end_time)
                      .pluck(:table_id)

    reserved_tables.uniq
  end

  def update_table_status_to_occupied
    table.occupied! if table.present? && table.may_occupied?
  end

  def update_table_status_to_vacant
    table.vacant! if table.present? && table.may_vacant?
  end
end
