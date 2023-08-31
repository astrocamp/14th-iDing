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

  # before_save :valid_total_guests

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

  private

  def update_table_status_to_occupied
    table = self.table
    table.occupied! if table.present?
  end

  def update_table_status_to_vacant
    table = self.table
    table.vacant! if table.present?
  end

  # def valid_total_guests
  #   total_guests = adults + kids
  #   vacant_table = restaurant.tables.where(status: 'vacant').where('seat_num >= ?', total_guests).first

  #   if vacant_table
  #     self.table = vacant_table
  #   else
  #     errors.add(:base, '無法找到合適的空桌')
  #   end
  # end
end
