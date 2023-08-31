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

  belongs_to :restaurant
  belongs_to :table, optional: true

  after_save :update_table_status
  before_destroy :free_up_table
  before_save :valid_total_guests

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

  private

  def update_table_status
    table.update(status: 'occupied') if table_id.present?
  end

  def free_up_table
    table.update(status: 'vacant') if table.present?
  end

  def valid_total_guests
    total_guests = adults + kids
    vacant_table = restaurant.tables.where(status: 'vacant').where('seat_num >= ?', total_guests).first

    if vacant_table
      self.table = vacant_table
    else
      errors.add(:base, '無法找到合適的空桌')
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
end
